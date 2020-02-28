# encoding: UTF-8

require 'sivel2_gen/concerns/controllers/conteos_controller'

module Sivel2Gen
  class ConteosController < ApplicationController

    include Sivel2Gen::Concerns::Controllers::ConteosController

    def personas_filtros_especializados
      @opsegun =  ["", "AÑO DE NACIMIENTO", "SEXO"]
      @titulo_personas = 'Demografía de Beneficiarios'
      @titulo_personas_fecha = 'Fecha del Caso'
    end

    def personas_procesa_segun_om(que1, tablas1, where1, que3, tablas3, where3)
      case @pSegun
      when ''
        que1 = agrega_tabla(que1, 'cast(\'total\' as text) as total')
        que3 << ["", ""]

      when 'AÑO DE NACIMIENTO'
        que1 = agrega_tabla(que1, 'persona.anionac AS anionac')
        tablas1 = agrega_tabla(tablas1, 'public.sip_persona AS persona')
        where1 = consulta_and_sinap(
          where1, "persona.id", "victima.id_persona")
        que3 << ["anionac", "Año de Nacimiento"]

      when 'SEXO'
        que1 = agrega_tabla(que1, 'persona.sexo AS sexo')
        tablas1 = agrega_tabla(tablas1, 'public.sip_persona AS persona')
        where1 = consulta_and_sinap(
          where1, "persona.id", "victima.id_persona")
        que3 << ["sexo", "Sexo"]


      else
        puts "opción desconocida pSegun=#{@pSegun}"
      end

      return que1, tablas1, where1, que3, tablas3, where3
    end


    def personas_procesa_segun(que1, tablas1, where1, que3, tablas3, where3)
      return personas_procesa_segun_om(
        que1, tablas1, where1, que3, tablas3, where3
      )
    end


    # A partir de vista personas_cons1, crea vista personas_cons2 que añade
    # información geografica
    def personas_vista_geo(que3, tablas3, where3)
      if (@pDepartamento == "1") 
        que3 << ["departamento_nombre", "Departamento"]
      end
      if (@pMunicipio== "1") 
        que3 << ["municipio_nombre", "Municipio"]
      end

      return ["CREATE VIEW #{personas_cons2} AS SELECT #{personas_cons1}.*,
            ubicacion.id_departamento, 
            departamento.nombre AS departamento_nombre, 
            ubicacion.id_municipio, municipio.nombre AS municipio_nombre, 
            ubicacion.id_clase, clase.nombre AS clase_nombre
            FROM
            #{personas_cons1} JOIN sivel2_gen_caso AS caso ON
              (#{personas_cons1}.id_caso = caso.id) 
            LEFT JOIN sip_ubicacion AS ubicacion ON
              (caso.ubicacion_id = ubicacion.id) 
            LEFT JOIN sip_departamento AS departamento ON 
              (ubicacion.id_departamento=departamento.id) 
            LEFT JOIN sip_municipio AS municipio ON 
              (ubicacion.id_municipio=municipio.id)
            LEFT JOIN sip_clase AS clase ON 
              (ubicacion.id_clase=clase.id)
            GROUP BY 1,2,3,4,5,6,7,8,9,10,11", que3, tablas3, where3]
    end

    # Genera q3 y llena @coltotales
    def personas_consulta_final(i, que3, tablas3, where3, qc, gb)
      @coltotales = [i-1]
      que3 << ["", "Víctimas"]
      twhere3 = where3 == "" ? "" : "WHERE " + where3
      q3="SELECT #{qc}
            SUM(#{personas_cons2}.npersona) AS npersona
            FROM #{tablas3}
            #{twhere3}
            #{gb}"
      #puts "OJO q3 es #{q3}"
      return q3
    end

    def personas
      authorize! :contar, Sivel2Gen::Caso

      @pSegun = param_escapa([:filtro, 'segun'])
      @pMunicipio = param_escapa([:filtro, 'municipio'])
      @pDepartamento = param_escapa([:filtro, 'departamento'])
      personas_filtros_especializados()

      # La estrategia es 
      # 1. Agrupar en la vista personas_cons1 personas con lo que se contará 
      #    restringiendo por filtros con códigos sin desp. ni info geog.
      # 2. En vista personas_cons2 dejar lo mismo que en personas_cons1, pero añadiendo
      #    info geografica.
      # 3. Contar victima sobre personas_cons2, cambiar códigos
      #    por información por desplegar

      # Validaciones todo caso tiene victima
      # Validaciones todo caso tiene ubicacion
      where1 = '';
      @fechaini = '';
      @fechafin = '';
      if (params[:filtro] && params[:filtro]['fechaini'] && 
          params[:filtro]['fechaini'] != "") 
        @fechaini = fecha_local_estandar(params[:filtro]['fechaini'])
        where1 = personas_fecha_inicial(where1)
      end
      if (params[:filtro] && params[:filtro]['fechafin'] && 
          params[:filtro]['fechafin'] != "") 
        @fechafin = fecha_local_estandar(params[:filtro]['fechafin'])
        where1 = personas_fecha_final(where1)
      end
      que1 = 'caso.id AS id_caso, subv.id_victima AS id_victima, ' +
        'subv.id_persona AS id_persona, 1 AS npersona'
      tablas1 = 'public.sivel2_gen_caso AS caso, ' +
        'public.sivel2_gen_victima AS victima, ' +
        '(SELECT id_persona, ' +
        ' MAX(id) AS id_victima' +
        ' FROM sivel2_gen_victima GROUP BY 1) AS subv '

      where1 = consulta_and_sinap(where1, "subv.id_victima", "victima.id")
      where1 = consulta_and_sinap(where1, "caso.id", "victima.id_caso")

      # Para la consulta final emplear arreglo que3, que tendrá parejas
      # (campo, titulo por presentar en tabla)
      que3 = []
      tablas3 = "#{personas_cons2}"
      where3 = ''
      que1, tablas1, where1, que3, tablas3, where3 = 
        personas_procesa_filtros(
          que1, tablas1, where1, que3, tablas3, where3
      )

      que1, tablas1, where1, que3, tablas3, where3 = 
        personas_procesa_segun(que1, tablas1, where1, que3, tablas3, where3)
      ActiveRecord::Base.connection.execute "DROP VIEW  IF EXISTS #{personas_cons2}"
      ActiveRecord::Base.connection.execute "DROP VIEW  IF EXISTS #{personas_cons1}"

      if where1 != ''
        where1 = 'WHERE ' + where1
      end
      # Filtrar 
      q1="CREATE VIEW #{personas_cons1} AS 
              SELECT #{que1}
              FROM #{tablas1} #{where1}
      "
      #            q1 += 'GROUP BY '
      #            q1 += (3..que1.split(',').count).to_a.join(', ')
      puts "OJO q1 es #{q1}<hr>"
      ActiveRecord::Base.connection.execute q1

      # Paso 2
      # Añadimos información geográfica que se pueda
      q2, que3, tablas3, where3 = 
        personas_vista_geo(que3, tablas3, where3)
      #puts "OJO q2 es #{q2}<hr>"
      ActiveRecord::Base.connection.execute q2

      #puts "OJO que3 es #{que3}"
      # Generamos 1,2,3 ...n para GROUP BY
      gb = sep = ""
      qc = ""
      i = 1
      que3.each do |t|
        if (t[1] != "") 
          gb += sep + i.to_s
          qc += t[0] + ", "
          sep = ", "
          i += 1
        end
      end
      if (gb != "") 
        gb ="GROUP BY #{gb} ORDER BY #{gb}"
      end
      q3 = personas_consulta_final(i, que3, tablas3, where3, qc, gb)
      @cuerpotabla = ActiveRecord::Base.connection.select_all(q3)

      @enctabla = []
      que3.each do |t|
        if (t[1] != "") 
          @enctabla << CGI.escapeHTML(t[1])
        end
      end

      respond_to do |format|
        format.html { render 'sivel2_gen/conteos/personas', layout: 'application' }
        format.json { head :no_content }
        format.js   { render 'sivel2_gen/conteos/resultado' }
      end
    end # def personas


  end
end
