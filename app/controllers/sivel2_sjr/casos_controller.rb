# encoding: UTF-8

require_dependency 'sivel2_sjr/concerns/controllers/casos_controller'
require_dependency 'heb412_gen/docs_controller'

module Sivel2Sjr
  class CasosController < Heb412Gen::ModelosController

    include Sivel2Sjr::Concerns::Controllers::CasosController

    before_action :set_caso, only: [:show, :edit, :update, :destroy],
      exclude: [:poblacion_sexo_rangoedadac, :personas_casos]
    load_and_authorize_resource class: Sivel2Gen::Caso

    def vistas_manejadas
      ['Caso']
    end

    def atributos_show
      [
        # basicos
        :id,
        :fecharec,
        :oficina,
        :fecha,
        :memo,
        :created_at,
        :asesor,
        :contacto,
        :direccion,
        :telefono,
        :atenciones,
        :listado_familiares,
        :listado_anexos
      ]
    end

    # Campos en filtro
    def campos_filtro1
      [
        :apellidos, 
        :apellidossp, 
        :atenciones_fechaini,
        :atenciones_fechafin,
        :categoria_id,
        :codigo,
        :departamento_id,
        :descripcion,
        :expulsion_pais_id, 
        :expulsion_departamento_id, 
        :expulsion_municipio_id,
        :fechaini, 
        :fechafin, 
        :fecharecini, 
        :fecharecfin, 
        :llegada_pais_id, 
        :llegada_departamento_id, 
        :llegada_municipio_id,
        :nombressp, 
        :numerodocumento,
        :nombres, 
        :oficina_id, 
        :rangoedad_id, 
        :sexo, 
        :tdocumento, 
        :ultimaatencion_fechaini, 
        :ultimaatencion_fechafin,
        :usuario_id,
      ]
    end

    # Campos por presentar en listado index
    def incluir_inicial
      return ['casoid', 'contacto', 'fecharec', 'oficina', 
              'nusuario', 'fecha', 'expulsion',
              'llegada', 'ultimaatencion_fecha', 'memo'
      ]
    end

    # Ordenamiento inicial por este campo
    def campoord_inicial
      'fecharec'
    end

    def asegura_camposdinamicos(registro, current_usuario_id)
    end


    # Responde con mensaje de error
    def resp_error(m)
      respond_to do |format|
        format.html { 
          render inline: m
        }
        format.json { 
          render json: m, status: :unprocessable_entity 
        }
      end
    end

    # Fución API que retorna personas de un caso
    def personas_casos
      authorize! :read, Sip::Persona
      res = []
      if params && params['caso_ids']
        puts "params es #{params.inspect}"
        params['caso_ids'].split(',').each do |cc|
          nc = cc.to_i
          if Sivel2Gen::Caso.where(id: nc).count == 0
            resp_error("No se encontró caso #{nc}")
            return
          end
          c = Sivel2Gen::Caso.find(nc)
          c.persona.each do |p|
            res.push({
              persona_id: p.id,
              nombres: p.nombres,
              apellidos: p.apellidos,
              tdocumento_sigla: p.tdocumento ? p.tdocumento.sigla : '',
              numerodocumento: p.numerodocumento
            })
          end
        end
      end

      resj = res.to_json
      respond_to do |format|
        format.js { render text: resj }
        format.json { render json: resj, status: :created }
        format.html { render inline: resj }
      end

    end

    def filtrar_ca(conscaso)
      if current_usuario && current_usuario.rol == Ability::ROLINV
        aeu = current_usuario.etiqueta_usuario.map { |eu| eu.etiqueta_id }
        conscaso = conscaso.joins(
          'JOIN sivel2_gen_caso_etiqueta as cet ON cet.id_caso=id_caso')
        if aeu.count == 0
          conscaso = conscaso.where('FALSE')
        else
          conscaso = conscaso.where('cet.id_etiqueta IN [?]', aeu.join(','))
        end
      end
      return conscaso
    end

    # Tipo de reporte Resolución 1612
    def filtro_particular(conscaso, params_filtro)
      if (params_filtro['dispresenta'] == 'tabla1612') 
        @incluir =  [
          'casoid', 'tipificacion', 'victimas', 'fechadespemb', 
          'ubicaciones', 'presponsables', 'descripcion', 'memo1612'
        ]
        conscaso = conscaso.where('caso_id in (SELECT id_caso 
                                        FROM public.sivel2_gen_acto
                                        WHERE id_categoria = 3020
                                        OR id_categoria=3021)')
        @usa_consexpcaso = true
        Sivel2Gen::Consexpcaso.crea_consexpcaso(conscaso)

        @consexpcaso = Sivel2Gen::Consexpcaso.all
      end
      return conscaso
    end

    def update
      (caso_params[:migracion_attributes] || []).each do |clave, mp|
        mi = Sivel2Sjr::Migracion.find(mp[:id].to_i)

        sal_pais_id = (mp[:salida_pais_id] && mp[:salida_pais_id]!="") ? mp[:salida_pais_id].to_i : nil
        sal_dep_id = (mp[:salida_departamento_id] && mp[:salida_departamento_id]!="") ? mp[:salida_departamento_id].to_i : nil
        sal_mun_id = (mp[:salida_municipio_id] && mp[:salida_municipio_id]!="") ? mp[:salida_municipio_id].to_i : nil
        sal_clas_id = (mp[:salida_clase_id] && mp[:salida_clase_id]!="") ? mp[:salida_clase_id].to_i : nil
        sal_lug = (mp[:salida_lugar] && mp[:salida_lugar]!="") ? mp[:salida_lugar] : nil
        sal_sit = (mp[:salida_sitio] && mp[:salida_sitio]!="") ? mp[:salida_sitio] : nil
        sal_tsit = (mp[:salida_tsitio_id] && mp[:salida_tsitio_id]!="") ? mp[:salida_tsitio_id] : nil
        sal_latitud = (mp[:salida_latitud] && mp[:salida_latitud]!="") ? mp[:salida_latitud] : nil
        sal_longitud = (mp[:salida_longitud] && mp[:salida_longitud]!="") ? mp[:salida_longitud] : nil
        if sal_pais_id
          ubipresal = Sip::Ubicacionpre.where(pais_id: sal_pais_id, departamento_id: sal_dep_id, municipio_id: sal_mun_id, clase_id: sal_clas_id, lugar: sal_lug, sitio: sal_sit)
          if ubipresal[0]
            mi.salidaubicacionpre_id = ubipresal[0] ? ubipresal[0].id : nil
            mi.save!
          else
            pa = Sip::Pais.find(sal_pais_id).nombre
            dep = Sip::Departamento.find(sal_dep_id).nombre + " / "
            mu = Sip::Municipio.find(sal_mun_id).nombre + " / "
            cla = Sip::Clase.find(sal_clas_id).nombre + " / "
            tsit = Sip::Tsitio.find(sal_tsit).nombre + " / "
            sit = sal_sit ? sal_sit + " / " : ""
            lug = sal_lug ? sal_lug : ""
            ## Latitud y longitud
            if !sal_latitud
              lat = Sip::Clase.find(sal_clas_id) ? Sip::Clase.find(sal_clas_id).latitud : nil
              if !lat
                lat = Sip::Departamento.find(sal_dep_id) ? Sip::Departamento.find(sal_dep_id).latitud : nil
                if !lat
                  lat = Sip::Pais.find(sal_pais_id) ? Sip::Pais.find(sal_pais_id).latitud : nil
                end
              end
            else
              lat = sal_latitud
            end
            if !sal_longitud
              lon = Sip::Clase.find(sal_clas_id) ? Sip::Clase.find(sal_clas_id).longitud : nil
              if !lon
                lon = Sip::Departamento.find(sal_dep_id) ? Sip::Departamento.find(sal_dep_id).longitud : nil
                if !lon
                  lon = Sip::Pais.find(sal_pais_id) ? Sip::Pais.find(sal_pais_id).longitud : nil
                end
              end
            else
              lon = sal_longitud
            end

            nombre = sit + lug + " : " + tsit + cla + mu + dep + pa + " @ " + lat.to_s + ", " + lon.to_s
            nombre_sinp = sit + lug + " : " + tsit + cla + mu + dep[..-4] + " @ " + lat.to_s + ", " + lon.to_s
            miubipre = Sip::Ubicacionpre.create!(nombre: nombre, pais_id: sal_pais_id, departamento_id: sal_dep_id, municipio_id: sal_mun_id, clase_id: sal_clas_id, lugar: sal_lug, sitio: sal_sit, latitud: lat, longitud: lon, tsitio_id: sal_tsit, nombre_sin_pais: nombre_sinp)
            mi.salidaubicacionpre_id = miubipre ? miubipre.id : nil
            mi.save!
          end
        end

        lleg_pais_id = (mp[:llegada_pais_id] && mp[:llegada_pais_id]!="") ? mp[:llegada_pais_id].to_i : nil
        lleg_dep_id = (mp[:llegada_departamento_id] && mp[:llegada_departamento_id]!="") ? mp[:llegada_departamento_id].to_i : nil
        lleg_mun_id = (mp[:llegada_municipio_id] && mp[:llegada_municipio_id]!="") ? mp[:llegada_municipio_id].to_i : nil
        lleg_clas_id = (mp[:llegada_clase_id] && mp[:llegada_clase_id]!="") ? mp[:llegada_clase_id].to_i : nil
        lleg_lug = (mp[:llegada_lugar] && mp[:llegada_lugar]!="") ? mp[:llegada_lugar] : nil
        lleg_sit = (mp[:llegada_sitio] && mp[:llegada_sitio]!="") ? mp[:llegada_sitio] : nil
        lleg_tsit = (mp[:llegada_tsitio_id] && mp[:llegada_tsitio_id]!="") ? mp[:llegada_tsitio_id] : nil
        lleg_latitud = (mp[:llegada_latitud] && mp[:llegada_latitud]!="") ? mp[:llegada_latitud] : nil
        lleg_longitud = (mp[:llegada_longitud] && mp[:llegada_longitud]!="") ? mp[:llegada_longitud] : nil
        if lleg_pais_id
          ubiprelleg = Sip::Ubicacionpre.where(pais_id: lleg_pais_id, departamento_id: lleg_dep_id, municipio_id: lleg_mun_id, clase_id: lleg_clas_id, lugar: lleg_lug, sitio: lleg_sit)
          if ubiprelleg[0]
            mi.llegadaubicacionpre_id = ubiprelleg[0] ? ubiprelleg[0].id : nil
            mi.save!
          else
            pa = Sip::Pais.find(lleg_pais_id).nombre
            dep = Sip::Departamento.find(lleg_dep_id).nombre + " / "
            mu = Sip::Municipio.find(lleg_mun_id).nombre + " / "
            cla = Sip::Clase.find(lleg_clas_id).nombre + " / "
            tsit = Sip::Tsitio.find(lleg_tsit).nombre + " / "
            sit = lleg_sit ? lleg_sit + " / " : ""
            lug = lleg_lug ? lleg_lug + " / " : ""
            ## Latitud y longitud
            if !lleg_latitud
              lat = Sip::Clase.find(lleg_clas_id) ? Sip::Clase.find(lleg_clas_id).latitud : nil
              if !lat
                lat = Sip::Departamento.find(lleg_dep_id) ? Sip::Departamento.find(lleg_dep_id).latitud : nil
                if !lat
                  lat = Sip::Pais.find(lleg_pais_id) ? Sip::Pais.find(lleg_pais_id).latitud : nil
                end
              end
            else
              lat = lleg_latitud
            end
            if !lleg_longitud
              lon = Sip::Clase.find(lleg_clas_id) ? Sip::Clase.find(lleg_clas_id).longitud : nil
              if !lon
                lon = Sip::Departamento.find(lleg_dep_id) ? Sip::Departamento.find(lleg_dep_id).longitud : nil
                if !lon
                  lon = Sip::Pais.find(lleg_pais_id) ? Sip::Pais.find(lleg_pais_id).longitud : nil
                end
              end
            else
              lon = lleg_longitud
            end
            nombre = sit + lug + " : " + tsit + cla + mu + dep + pa + " @ " + lat.to_s + ", " + lon.to_s
            nombre_sinp = sit + lug + " : " + tsit + cla + mu + dep[..-4] + " @ " + lat.to_s + ", " + lon.to_s
            miubipre = Sip::Ubicacionpre.create!(nombre: nombre, pais_id: lleg_pais_id, departamento_id: lleg_dep_id, municipio_id: lleg_mun_id, clase_id: lleg_clas_id, lugar: lleg_lug, sitio: lleg_sit, latitud: lat, longitud: lon, nombre_sin_pais: nombre_sinp, tsitio_id: lleg_tsit)
            mi.llegadaubicacionpre_id = miubipre ? miubipre.id : nil
            mi.save!
          end
        end

        des_pais_id = (mp[:destino_pais_id] && mp[:destino_pais_id]!="") ? mp[:destino_pais_id].to_i : nil
        des_dep_id = (mp[:destino_departamento_id] && mp[:destino_departamento_id]!="") ? mp[:destino_departamento_id].to_i : nil
        des_mun_id = (mp[:destino_municipio_id] && mp[:destino_municipio_id]!="") ? mp[:destino_municipio_id].to_i : nil
        des_clas_id = (mp[:destino_clase_id] && mp[:destino_clase_id]!="") ? mp[:destino_clase_id].to_i : nil
        des_lug = (mp[:destino_lugar] && mp[:destino_lugar]!="") ? mp[:destino_lugar] : nil
        des_sit = (mp[:destino_sitio] && mp[:destino_sitio]!="") ? mp[:destino_sitio] : nil
        des_tsit = (mp[:destino_tsitio_id] && mp[:destino_tsitio_id]!="") ? mp[:destino_tsitio_id] : nil
        des_latitud = (mp[:destino_latitud] && mp[:destino_latitud]!="") ? mp[:destino_latitud] : nil
        des_longitud = (mp[:destino_longitud] && mp[:destino_longitud]!="") ? mp[:destino_longitud] : nil
        if des_pais_id
          ubipredes = Sip::Ubicacionpre.where(pais_id: des_pais_id, departamento_id: des_dep_id, municipio_id: des_mun_id, clase_id: des_clas_id, lugar: des_lug, sitio: des_sit)
          if ubipredes[0]
            mi.destinoubicacionpre_id = ubipredes[0] ? ubipredes[0].id : nil
            mi.save!
          else
            pa = Sip::Pais.find(des_pais_id).nombre
            dep = Sip::Departamento.find(des_dep_id).nombre + " / "
            mu = Sip::Municipio.find(des_mun_id).nombre + " / "
            cla = Sip::Clase.find(des_clas_id).nombre + " / "
            tsit = Sip::Tsitio.find(des_tsit).nombre + " / "
            sit = des_sit ? des_sit + " / " : ""
            lug = des_lug ? des_lug + " / " : ""
            ## Latitud y longitud
            if !des_latitud
              lat = Sip::Clase.find(des_clas_id) ? Sip::Clase.find(des_clas_id).latitud : nil
              if !lat
                lat = Sip::Departamento.find(des_dep_id) ? Sip::Departamento.find(des_dep_id).latitud : nil
                if !lat
                  lat = Sip::Pais.find(des_pais_id) ? Sip::Pais.find(des_pais_id).latitud : nil
                end
              end
            else
              lat = des_latitud
            end
            if !des_longitud
              lon = Sip::Clase.find(des_clas_id) ? Sip::Clase.find(des_clas_id).longitud : nil
              if !lon
                lon = Sip::Departamento.find(des_dep_id) ? Sip::Departamento.find(des_dep_id).longitud : nil
                if !lon
                  lon = Sip::Pais.find(des_pais_id) ? Sip::Pais.find(des_pais_id).longitud : nil
                end
              end
            else
              lon = des_longitud
            end

            nombre = sit + lug + " : " + tsit + cla + mu + dep + pa + " @ " + lat.to_s + ", " + lon.to_s
            nombre_sinp = sit + lug + " : " + tsit + cla + mu + dep[..-4] + " @ " + lat.to_s + ", " + lon.to_s
            miubipre = Sip::Ubicacionpre.create!(nombre: nombre, pais_id: des_pais_id, departamento_id: des_dep_id, municipio_id: des_mun_id, clase_id: des_clas_id, lugar: des_lug, sitio: des_sit, latitud: lat, longitud: lon, nombre_sin_pais: nombre_sinp, tsitio_id: des_tsit)
            mi.destinoubicacionpre_id = miubipre ? miubipre.id : nil
            mi.save!
          end
        end
      end

    # Convertir valores de radios tri-estado, el valor 3 en el 
      # botón de radio es nil en la base de datos
      if params && params[:caso] && params[:caso][:victima_attributes]
        params[:caso][:victima_attributes].each do |l, v|
          [:actualtrabajando, :asisteescuela, 
           :cabezafamilia, :tienesisben].each do |sym|
            if v[:victimasjr_attributes] && v[:victimasjr_attributes][sym] && v[:victimasjr_attributes][sym] == '3'
              v[:victimasjr_attributes][sym] = nil
            end
          end
        end
      end
      update_sivel2_sjr
    end

    def destroy
      if @caso.casosjr.respuesta
        # No se logró hacer ni con dependente:destroy en
        # las relaciones ni borrando con delete 
        @caso.casosjr.respuesta.each do |r|
          Sivel2Sjr::AccionjuridicaRespuesta.where(respuesta_id: r.id).
            delete_all
        end
      end
      sivel2_sjr_destroy
    end

    def otros_params_respuesta
      [
        :accionjuridica_respuesta_attributes => [
          :accionjuridica_id,
          :favorable,
          :id,
          :_destroy
        ]
      ]
    end

    def otros_params_victimasjr 
      [ :actualtrabajando, :discapacidad_id ]
    end

    def otros_params_victima
      [:anexo_victima_attributes => [
        :fecha_localizada,
        :tipoanexo_id,
        :id, 
        :id_victima,
        :_destroy,
        :sip_anexo_attributes => [
          :adjunto, 
          :descripcion, 
          :id, 
          :_destroy
        ]
      ] ]
    end

    def otros_params
      [
        :migracion_attributes => [
          :actor_pago,
          :autoridadrefugio_id,
          :causaRefugio_id,
          :causamigracion_id,
          :concepto_pago,
          :destino_clase_id,
          :destino_departamento_id,
          :destino_municipio_id,
          :destino_pais_id,
          :destino_latitud,
          :destino_longitud,
          :destino_lugar,
          :destino_sitio,
          :destino_tsitio_id,
          :fechallegada,
          :fechaNpi,
          :fechaPep,
          :fechasalida,
          :fechaendestino,
          :id,
          :llegada_clase_id,
          :llegada_departamento_id,
          :llegada_municipio_id,
          :llegada_pais_id,
          :llegada_latitud,
          :llegada_longitud,
          :llegada_lugar,
          :llegada_sitio,
          :llegada_tsitio_id,
          :llegada_ubicacionpre_id,
          :miembrofamiliar_id,
          :migracontactopre_id,
          :observacionesref,
          :otraagresion,
          :otraautoridad,
          :otracausa,
          :otromiembro,
          :otracausagrpais,
          :otracausaagresion,
          :otronpi,
          :pagoingreso_id,
          :pep,
          :perpeagresenpais,
          :perpetradoresagresion,
          :perfilmigracion_id,
          :proteccion_id,
          :salida_pais_id,
          :salida_departamento_id,
          :salida_municipio_id,
          :salida_clase_id,
          :salida_latitud,
          :salida_longitud,
          :salida_lugar,
          :salida_sitio,
          :salida_tsitio_id,
          :salida_ubicacionpre_id,
          :salvoNpi,
          :se_establece_en_sitio_llegada,
          :statusmigratorio_id,
          :tratoauto,
          :tratoresi,
          :tipopep,
          :tipoproteccion_id,
          :ubifamilia,
          :valor_pago,
          :viadeingreso_id,
          :_destroy,
          :agresionmigracion_ids => [],
          :agresionenpais_ids => [],
          :causaagresion_ids => [],
          :causaagrpais_ids => [],
          :dificultadmigracion_ids => []
        ],
      ]
    end

    def importa_dato(datosent, datossal, menserror, registro = nil, 
                     opciones = {})
      importa_dato_gen(datosent, datossal, menserror, registro, opciones)
    end
  
    def establece_registro
      @registro = @basica = nil
      if !params || !params[:id] || 
          Sivel2Gen::Caso.where(id: params[:id]).count != 1
        return
      end
      Sivel2Gen::Conscaso.refresca_conscaso
      cc = Sivel2Gen::Conscaso.where(caso_id: params[:id])
      Sivel2Gen::Consexpcaso.crea_consexpcaso(cc, nil)
      @registro = @basica = Sivel2Gen::Consexpcaso.
        where(caso_id: params[:id]).take
    end

  end
end
