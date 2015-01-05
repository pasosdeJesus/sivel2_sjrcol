# encoding: UTF-8

class ConteosController < ApplicationController

  ##
  # Agrega una nueva tabla al listado $t
  #
  # @param string &$t Listado de tablas separadas por ,
  # @param string $nt Nueva tabla por agregar si falta
  #
  # @return string cadena t completada para asegurar tabla
  #/
  def agrega_tabla(t, nt)
    at = t.split(',')
    if (!at.include? nt)
        at << nt
    end
    t = at.join(",")
  end

  ##
  # Agrega condición a WHERE en un SELECT de SQL
  #
  # @param unknown &$db   Conexión a base de datos
  # @param string  &$w    cadena con WHERE que se completa
  # @param string  $n     nombre de campo
  # @param string  $v     valor esperado
  # @param string  $opcmp operador de comparación por usar.
  # @param string  $con   con
  #
  # @return string cadena w completada con nueva condición
  def consulta_and(w, n, v, opcmp = '=', con='AND')
    if (!v || v === '' || $v === ' ') 
        return
    end
    if (w != "") 
        w += " #{con}"
    end
    w += " " + n + opcmp + Sivel2Gen::Caso.sanitize(v)
  end


  ##
  # Como la función anterior sólo que el valor no lo pone entre apostrofes
  # y supone que ya viene escapado el valor $v
  #
  # @param string &$w    cadena con WHERE que se completa
  # @param string $n     nombre de campo
  # @param string $v     valor esperado
  # @param string $opcmp operador de comparación por usar.
  # @param string $con   con
  #
  # @return string cadena w completada con nueva condición
  #/
  def consulta_and_sinap(w, n, v, opcmp = '=', con = "AND")
    if (w != "") 
        w += " " + con
    end
    w += " " + n + opcmp + v
  end

  def param_escapa(p)
    params[p] ? Sivel2Gen::Caso.connection.quote_string(params[p]) : ''
  end

  # Vacíos de protección
  def vacios
    @pque = { 
      'ayudaestado' => 'Ayuda del Estado',
      'ayudasjr' => 'Ayuda Humanitaria del SJR',
      'motivosjr' => 'Servicio/Asesoria del SJR',
      'progestado' => 'Subsidio/Programa del Estado'
    }

    pFaini = param_escapa('fechaini')
    pFafin = param_escapa('fechafin')
    pContar = param_escapa('contar')
    pOficina = param_escapa('oficina')
    pDerecho = param_escapa('derecho')

    if (pContar == '') 
      pContar = 'ayudaestado'
    end

    if (!@pque.has_key?(pContar)) then
      puts "opción desconocida #{pContar}"
      return
    end


    cons1 = 'cvp1'
    cons2 = 'cvp2'
    # La estrategia es 
    # 1. Agrupar en la vista cons1 respuesta con lo que se contará 
    #    restringiendo por filtros con códigos 
    # 2. Contar derechos/respuestas cons1, cambiar códigos
    #    por información por desplegar

    # Para la vista cons1 emplear que1, tablas1 y where1
    que1 = 'respuesta.id AS id_respuesta, ' +
      'derecho_respuesta.id_derecho AS id_derecho'
    tablas1 = 'sivel2_sjr_casosjr AS casosjr, ' +
      'sivel2_sjr_respuesta AS respuesta, ' +
      'sivel2_sjr_derecho_respuesta AS derecho_respuesta'
    where1 = ''

    # where1 = consulta_and(where1, 'caso.id', GLOBALS['idbus'], '<>')
    where1 = consulta_and_sinap(where1, "respuesta.id", "casosjr.id_caso")
    where1 = consulta_and_sinap( 
      where1, "derecho_respuesta.id_respuesta", "respuesta.id"
    )

    if (pFaini != '') 
      where1 = consulta_and(where1, "respuesta.fechaatencion", pFaini, ">=") 
    end
    if (pFafin != '') 
      where1 = consulta_and(where1, "respuesta.fechaatencion", pFafin, "<=")
    end
    if (pOficina != '') 
      where1 = consulta_and(where1, "casosjr.id_regionsjr", pOficina)
    end
    if (pDerecho != '') 
      where1 = consulta_and(where1, "derecho_respuesta.id_derecho", pDerecho)
    end


    que1 = agrega_tabla(que1, "casosjr.id_regionsjr AS id_regionsjr")
    
    ActiveRecord::Base.connection.execute "DROP VIEW  IF EXISTS #{cons1}"
    ActiveRecord::Base.connection.execute "DROP VIEW  IF EXISTS #{cons2}"

    # Paso 1. Filtrar 
    q1="CREATE VIEW #{cons1} AS 
            SELECT #{que1}
            FROM #{tablas1} WHERE #{where1}"
    puts "q1 es #{q1}"
    ActiveRecord::Base.connection.execute q1

    # Paso 2
    # Otra consulta
    q2="CREATE VIEW #{cons2} AS SELECT id_respuesta, derecho_id as id_derecho, id_#{pContar}
        FROM sivel2_sjr_#{pContar}_respuesta AS ar, 
          sivel2_sjr_#{pContar}_derecho AS ad 
        WHERE 
          ar.id_#{pContar}=ad.#{pContar}_id "
    puts "q2 es #{q2}"
    ActiveRecord::Base.connection.execute q2

    que3 = []
    tablas3 = cons1
    where3 = ''

    tablas3 = "sivel2_sjr_derecho AS derecho, cvp1 LEFT OUTER JOIN cvp2 ON 
    (cvp1.id_respuesta=cvp2.id_respuesta AND cvp1.id_derecho=cvp2.id_derecho)"
    where3 = consulta_and_sinap(where3, "cvp1.id_derecho", "derecho.id")
    que3 << ["derecho.nombre AS derecho", "Derecho"]
    que3 << ["(SELECT nombre FROM sivel2_sjr_#{pContar} WHERE id=id_#{pContar}) AS atendido", 
      @pque[pContar] ]

    #puts que3
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

    @coltotales = [i-1, i]
    if (gb != "") 
      gb ="GROUP BY #{gb} ORDER BY 1, 2"
    end
    que3 << ["", "Atendidos"]
    que3 << ["", "Reportados"]
    twhere3 = where3 == "" ? "" : "WHERE " + where3
    q3 = "SELECT derecho, atendido, (CASE WHEN atendido IS NULL THEN 0 
            ELSE reportados END) AS atendidos, reportados 
          FROM (SELECT #{qc}
            COUNT(cvp1.id_respuesta) AS reportados
            FROM #{tablas3}
            #{twhere3}
            #{gb}) AS s
    "
    puts "q3 es #{q3}"
    @cuerpotabla = ActiveRecord::Base.connection.select_all(q3)

    puts "que3 es #{que3}"
    @enctabla = []
    que3.each do |t|
      if (t[1] != "") 
        @enctabla << CGI.escapeHTML(t[1])
      end
    end


    respond_to do |format|
      format.html { }
      format.json { head :no_content }
      format.js   { render 'vacios' }
    end

  end

  def respuestas
    @pque = { 'derecho' => 'Derecho vulnerado',
      'ayudaestado' => 'Ayuda del Estado',
      'ayudasjr' => 'Ayuda Humanitaria del SJR',
      'motivosjr' => 'Servicio/Asesoria del SJR',
      'progestado' => 'Subsidio/Programa del Estado'
    }

    pFaini = param_escapa('fechaini')
    pFafin = param_escapa('fechafin')
    pContar = param_escapa('contar')
    pOficina = param_escapa('oficina')

    if (pContar == '') 
      pContar = 'derecho'
    end

    cons1 = 'cres1'
    # La estrategia es 
    # 1. Agrupar en la vista cons1 respuesta con lo que se contará 
    #    restringiendo por filtros con códigos 
    # 2. Contar derechos/respuestas cons1, cambiar códigos
    #    por información por desplegar

    # Para la vista cons1 emplear que1, tablas1 y where1
    que1 = 'caso.id AS id_caso, respuesta.fechaatencion AS fechaatencion'
    tablas1 = 'sivel2_gen_caso AS caso, sivel2_sjr_casosjr AS casosjr, ' +
      'sivel2_sjr_respuesta AS respuesta'
    where1 = ''

    # Para la consulta final emplear arreglo que3, que tendrá parejas
    # (campo, titulo por presentar en tabla)
    que3 = []
    tablas3 = cons1
    where3 = ''

    # where1 = consulta_and(where1, 'caso.id', GLOBALS['idbus'], '<>')
    where1 = consulta_and_sinap(where1, "caso.id", "casosjr.id_caso")
    where1 = consulta_and_sinap(where1, "caso.id", "respuesta.id_caso")
    if (pFaini != '') 
      where1 = consulta_and(
        where1, "respuesta.fechaatencion", pFaini, ">="
      )
    end
    if (pFafin != '') 
      where1 = consulta_and(
        where1, "respuesta.fechaatencion", pFafin, "<="
      )
    end

    if (pOficina != '') 
      where1 = consulta_and(where1, "casosjr.id_regionsjr", pOficina)
    end

    que1 = agrega_tabla(que1, "casosjr.id_regionsjr AS id_regionsjr")
    trel = "#{pContar}_respuesta"
    idrel = "id_#{pContar}"
    case (pContar) 
    when 'ayudasjr', 'ayudaestado', 'derecho', 'motivosjr', 'progestado'
      que1 = agrega_tabla(que1, "#{trel}.#{idrel} AS #{idrel}")
      where1 = consulta_and_sinap(
        where1, "respuesta.id", "#{trel}.id_respuesta"
      )
      #where1 = consulta_and_sinap( where1, "respuesta.fechaatencion", "#{trel}.fechaatencion")
      tablas1 = agrega_tabla(tablas1, "sivel2_sjr_#{trel} AS #{trel}")
      tablas3 = agrega_tabla(tablas3, "sivel2_sjr_#{pContar} AS #{pContar}")
      where3 = consulta_and_sinap(where3, idrel, "#{pContar}.id")
      que3 << ["#{pContar}.nombre", @pque[pContar]]
    else
      puts "opción desconocida #{pContar}"
    end

    ActiveRecord::Base.connection.execute "DROP VIEW  IF EXISTS #{cons1}"

    # Filtrar 
    q1="CREATE VIEW #{cons1} AS 
            SELECT #{que1}
            FROM #{tablas1} WHERE #{where1}"
    #puts "q1 es #{q1}"
    ActiveRecord::Base.connection.execute q1

    #puts que3
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

    @coltotales = [i-1, i]
    if (gb != "") 
      gb ="GROUP BY #{gb} ORDER BY #{i} DESC"
    end
    que3 << ["", "Cantidad atenciones"]
    twhere3 = where3 == "" ? "" : "WHERE " + where3
    q3 = "SELECT #{qc}
        COUNT(cast(#{cons1}.id_caso as text) || ' '
        || cast(#{cons1}.fechaatencion as text))
        FROM #{tablas3}
        #{twhere3}
        #{gb}
    "
    #puts "q3 es #{q3}"
    @cuerpotabla = ActiveRecord::Base.connection.select_all(q3)

    @enctabla = []
    que3.each do |t|
      if (t[1] != "") 
        @enctabla << CGI.escapeHTML(t[1])
      end
    end


    respond_to do |format|
      format.html { }
      format.json { head :no_content }
      format.js   { render 'resultado' }
    end


  end

  def personas
    authorize! :contar, Sivel2Gen::Caso
    pFaini = param_escapa('faini')
    pFafin = param_escapa('fafin') 
    pSegun = param_escapa('segun')
    pOficina = param_escapa('oficina')
    pMunicipio = param_escapa('municipio')
    pDepartamento = param_escapa('departamento')

    # La estrategia es 
    # 1. Agrupar en la vista cons1 personas con lo que se contará 
    #    restringiendo por filtros con códigos sin desp. ni info geog.
    # 2. En vista cons2 dejar lo mismo que en cons1, pero añadiendo
    #    expulsión más reciente y su ubicacion si la hay.
    #    Al añadir info. geográfica no es claro
    #    cual poner, porque un caso debe tener varias ubicaciones 
    #    correspondientes a los sitios por donde ha pasado durante
    #    desplazamientos.  Estamos suponiendo que interesa
    #    el sitio de la ultima expulsion.
    # 3. Contar beneficiarios contactos sobre cons2, cambiar códigos
    #    por información por desplegar
    # 4. Contar beneficiarios no contactos sobre cons2, cambiar códigos
    #    por información por desplegar

    # Validaciones todo caso es casosjr y viceversa
    # Validaciones todo caso tiene victima
    # Validaciones todo caso tiene ubicacion

    cons1 = 'cben1';
    cons2 = 'cben2';
    cons3 = 'cben3';
    @fechaini = '';
    where1 = '';
    if (params[:fechaini] && params[:fechaini] != "") 
        pfechaini = DateTime.strptime(params[:fechaini], '%Y-%m-%d')
        @fechaini = pfechaini.strftime('%Y-%m-%d')
        where1 = consulta_and(
          where1, "casosjr.fecharec", @fechaini, ">="
        )
    end
    @fechafin = '';
    if (params[:fechafin] && params[:fechafin] != "") 
        pfechafin = DateTime.strptime(params[:fechafin], '%Y-%m-%d')
        @fechafin = pfechafin.strftime('%Y-%m-%d')
        where1 = consulta_and(
          where1, "casosjr.fecharec", @fechafin, "<="
        )
    end
    que1 = 'caso.id AS id_caso, victima.id_persona AS id_persona,
            CASE WHEN (casosjr.contacto=victima.id_persona) THEN 1 ELSE 0 END 
            AS contacto, 
            CASE WHEN (casosjr.contacto<>victima.id_persona) THEN 1 ELSE 0 END
            AS beneficiario, 
            1 as npersona'
    tablas1 = 'sivel2_gen_caso AS caso, sivel2_sjr_casosjr AS casosjr, 
    sivel2_gen_victima AS victima'
    

    # Para la consulta final emplear arreglo que3, que tendrá parejas
    # (campo, titulo por presentar en tabla)
    que3 = []
    tablas3 = "#{cons2}"
    where3 = ''

#    consulta_and(where1, 'caso.id', GLOBALS['idbus'], '<>')
    where1 = consulta_and_sinap(where1, "caso.id", "casosjr.id_caso")
    where1 = consulta_and_sinap(where1, "caso.id", "victima.id_caso")
       
    if (pOficina != '') 
      where1 = consulta_and(where1, "casosjr.id_regionsjr", pOficina)
    end
    #byebug
    case pSegun
    when ''
      titSegun = 'Total'
      que1 = agrega_tabla(que1, 'cast(\'total\' as text) as total')
      que3 << ["", ""]
    when 'RANGO DE EDAD'
      que1 = agrega_tabla(que1, 'victima.id_rangoedad AS id_rangoedad')
      tablas3 = agrega_tabla(tablas3, 'sivel2_gen_rangoedad AS rangoedad')
      where3 = consulta_and_sinap(where3, "id_rangoedad", "rangoedad.id")
      que3 << ["rangoedad.rango", "Edad"]
    when 'SEXO'
      que1 = agrega_tabla(que1, 'persona.sexo AS sexo')
      tablas1 = agrega_tabla(tablas1, 'sivel2_gen_persona AS persona')
      where1 = consulta_and_sinap(where1, "persona.id", "victima.id_persona")
      que3 << ["sexo", "Sexo"]
    when 'SECTOR SOCIAL'
      que1 = agrega_tabla(que1, 'victima.id_sectorsocial AS id_sectorsocial')
      tablas3 = agrega_tabla(tablas3, 'sivel2_gen_sectorsocial AS sectorsocial')
      where3 = consulta_and_sinap(where3, "id_sectorsocial", "sectorsocial.id")
      que3 << ["sectorsocial.nombre", "Sector Social"]
    when 'MES RECEPCIÓN'
      que1 = agrega_tabla(que1, "extract(year from fecharec) || '-' " +
                   "|| lpad(cast(extract(month from fecharec) as text), 2, " +
                   "cast('0' as text)) as mes")
      que3 << ["mes", "Mes"]
    else
      puts "opción desconocida pSegun=#{pSegun}"
    end

    ActiveRecord::Base.connection.execute "DROP VIEW  IF EXISTS #{cons2}"
    ActiveRecord::Base.connection.execute "DROP VIEW  IF EXISTS #{cons1}"

    if where1 != ''
      where1 = 'WHERE ' + where1
    end
    # Filtrar 
    q1="CREATE VIEW #{cons1} AS 
        SELECT #{que1}
        FROM #{tablas1} #{where1}"
    #puts "q1 es #{q1}<hr>"
    ActiveRecord::Base.connection.execute q1

    # Paso 2
    # Añadimos información geográfica que se pueda
    q2="CREATE VIEW #{cons2} AS SELECT #{cons1}.*, 
            ubicacion.id_departamento, 
            departamento.nombre AS departamento_nombre, 
            ubicacion.id_municipio, municipio.nombre AS municipio_nombre, 
            ubicacion.id_clase, clase.nombre AS clase_nombre, 
            max(sivel2_sjr_desplazamiento.fechaexpulsion) FROM
            #{cons1} LEFT JOIN sivel2_sjr_desplazamiento ON
            (#{cons1}.id_caso = sivel2_sjr_desplazamiento.id_caso)
            LEFT JOIN sivel2_gen_ubicacion AS ubicacion ON 
              (sivel2_sjr_desplazamiento.id_expulsion = ubicacion.id) 
            LEFT JOIN sivel2_gen_departamento AS departamento ON 
              (ubicacion.id_departamento=departamento.id) 
            LEFT JOIN sivel2_gen_municipio AS municipio ON 
              (ubicacion.id_municipio=municipio.id 
                AND ubicacion.id_departamento=municipio.id_departamento) 
            LEFT JOIN sivel2_gen_clase AS clase ON 
              (ubicacion.id_clase=clase.id 
                AND ubicacion.id_municipio=clase.id_municipio 
                AND ubicacion.id_departamento=clase.id_departamento) 
            GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12"

    #puts "q2 es #{q2}<hr>"
    ActiveRecord::Base.connection.execute q2

    if (pDepartamento == "1") 
      que3 << ["departamento_nombre", "Último Departamento Expulsor"]
    end
    if (pMunicipio== "1") 
      que3 << ["municipio_nombre", "Último Municipio Expulsor"]
    end
    #puts "que3 es #{que3}"
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
    @coltotales = [i-1, i, i+1]
    que3 << ["", "Contactos"]
    que3 << ["", "Beneficiarios"]
    que3 << ["", "Total"]
    twhere3 = where3 == "" ? "" : "WHERE " + where3
    q3="SELECT #{qc}
            SUM(#{cons2}.contacto) AS contacto, 
            SUM(#{cons2}.beneficiario) AS beneficiario,
            SUM(#{cons2}.npersona) AS npersona
            FROM #{tablas3}
            #{twhere3}
            #{gb}"
    #puts "q3 es #{q3}"
    @cuerpotabla = ActiveRecord::Base.connection.select_all(q3)

    @enctabla = []
    que3.each do |t|
      if (t[1] != "") 
        @enctabla << CGI.escapeHTML(t[1])
      end
    end

    respond_to do |format|
      format.html { }
      format.json { head :no_content }
      format.js   { render 'resultado' }
    end
  end


  def municipios
    authorize! :contar, Sivel2Gen::Caso
    #byebug
    @fechaini = '';
    cfecha = '';
    if (params[:fechaini] && params[:fechaini] != "") 
        pfechaini = DateTime.strptime(params[:fechaini], '%Y-%m-%d')
        @fechaini = pfechaini.strftime('%Y-%m-%d')
        cfecha += "fechaexpulsion >= '#{@fechaini}' AND "
    end
    @fechafin = '';
    if (params[:fechafin] && params[:fechafin] != "") 
        pfechafin = DateTime.strptime(params[:fechafin], '%Y-%m-%d')
        @fechafin = pfechafin.strftime('%Y-%m-%d')
        cfecha += "fechaexpulsion <= '#{@fechafin}' AND "
    end
 

    # expulsores
    @expulsores = ActiveRecord::Base.connection.select_all("
      SELECT (SELECT nombre FROM sivel2_gen_pais WHERE id=id_pais) AS pais, 
        (SELECT nombre FROM sivel2_gen_departamento
          WHERE id_pais=ubicacion.id_pais 
          AND id=id_departamento) AS departamento, 
        (SELECT nombre FROM sivel2_gen_municipio
          WHERE id_pais=ubicacion.id_pais 
          AND id_departamento=ubicacion.id_departamento 
          AND id=ubicacion.id_municipio) AS municipio, 
        COUNT(victima.id) AS cuenta
      FROM sivel2_sjr_desplazamiento AS desplazamiento, 
        sivel2_gen_ubicacion AS ubicacion, 
        sivel2_gen_victima AS victima
      WHERE 
        #{cfecha} 
        id_expulsion=ubicacion.id 
        AND desplazamiento.id_caso=victima.id_caso
      GROUP BY 1,2,3 ORDER BY 4 desc;
    ")
    # receptores
    @receptores = ActiveRecord::Base.connection.select_all("
      SELECT (SELECT nombre FROM sivel2_gen_pais WHERE id=id_pais) AS pais, 
        (SELECT nombre FROM sivel2_gen_departamento 
          WHERE id_pais=ubicacion.id_pais 
          AND id=id_departamento) AS departamento, 
        (SELECT nombre FROM sivel2_gen_municipio 
        WHERE id_pais=ubicacion.id_pais 
          AND id_departamento=ubicacion.id_departamento 
          AND id=ubicacion.id_municipio) AS municipio, 
        COUNT(victima.id) AS cuenta
      FROM sivel2_sjr_desplazamiento AS desplazamiento, 
        sivel2_gen_ubicacion AS ubicacion, 
        sivel2_gen_victima AS victima
      WHERE 
        #{cfecha} 
        id_llegada=ubicacion.id 
        AND desplazamiento.id_caso=victima.id_caso
      GROUP BY 1,2,3 ORDER BY 4 desc;
    ")
    respond_to do |format|
      format.html { }
      format.json { head :no_content }
      format.js   { }
    end
  end

  def rutas
    authorize! :contar, Sivel2Gen::Caso
    # Retorna cadena correspondiente al municipio de una ubicación
    ActiveRecord::Base.connection.select_all("
      CREATE OR REPLACE FUNCTION municipioubicacion(int) RETURNS varchar AS
      $$
        SELECT (SELECT nombre FROM sivel2_gen_pais WHERE id=ubicacion.id_pais) 
            || COALESCE((SELECT '/' || nombre FROM sivel2_gen_departamento 
            WHERE sivel2_gen_departamento.id_pais=ubicacion.id_pais 
            AND sivel2_gen_departamento.id=ubicacion.id_departamento),'') 
            || COALESCE((SELECT '/' || nombre FROM sivel2_gen_municipio 
            WHERE sivel2_gen_municipio.id_pais=ubicacion.id_pais 
            AND sivel2_gen_municipio.id_departamento=ubicacion.id_departamento 
            AND sivel2_gen_municipio.id=ubicacion.id_municipio),'') 
            FROM sivel2_gen_ubicacion AS ubicacion 
            WHERE ubicacion.id=$1;
      $$ 
      LANGUAGE SQL
    ");
    @rutas = ActiveRecord::Base.connection.select_all(
      "SELECT ruta, cuenta FROM ((SELECT municipioubicacion(d1.id_expulsion) || ' - ' 
        || municipioubicacion(d1.id_llegada) AS ruta, 
        count(id) AS cuenta
      FROM sivel2_sjr_desplazamiento AS d1
      GROUP BY 1)
      UNION  
      (SELECT municipioubicacion(d1.id_expulsion) || ' - ' 
        || municipioubicacion(d1.id_llegada) || ' - '
        || municipioubicacion(d2.id_llegada) AS ruta, 
        count(d1.id_caso) AS cuenta
      FROM sivel2_sjr_desplazamiento AS d1, 
        sivel2_gen_ubicacion AS l1, 
        sivel2_sjr_desplazamiento as d2,
        sivel2_gen_ubicacion AS e2, sivel2_gen_ubicacion AS l2
      WHERE 
      d1.id_caso=d2.id_caso
      AND d1.fechaexpulsion < d2.fechaexpulsion
      AND d1.id_llegada = l1.id
      AND d2.id_llegada = l2.id
      AND d2.id_expulsion = e2.id
      GROUP BY 1)) as sub
      ORDER BY 2 DESC
      "
    )
  end

  def desplazamientos
    authorize! :contar, Sivel2Gen::Caso
    if params[:ordenar] == 'Sexo'
        cord = "3, 6 DESC, 1"
    elsif params[:ordenar] == 'Edad'
        cord = "4, 6 DESC, 1"
    elsif params[:ordenar] == 'Sector'
        cord = "5, 6 DESC, 1"
    else
        cord = "6 DESC, 1"
    end
    @desplazamientos = ActiveRecord::Base.connection.select_all(
      "SELECT victima.id_caso, persona.id AS persona, 
        persona.sexo, rangoedad.rango as rangoedad,
        sectorsocial.nombre as sectorsocial,
        COUNT(desplazamiento.id) as cuenta
      FROM sivel2_gen_victima AS victima, 
        sivel2_gen_persona AS persona, 
        sivel2_sjr_desplazamiento AS desplazamiento, 
        sivel2_gen_rangoedad AS rangoedad, 
        sivel2_gen_sectorsocial AS sectorsocial
      WHERE victima.id_caso=desplazamiento.id_caso
        AND victima.id_persona=persona.id
        AND victima.id_rangoedad=rangoedad.id
        AND victima.id_sectorsocial=sectorsocial.id
      GROUP BY 1, 2, 3, 4, 5 ORDER BY #{cord};
      "
    )
  end
end
