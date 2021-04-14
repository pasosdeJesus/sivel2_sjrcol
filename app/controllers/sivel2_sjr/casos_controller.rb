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
      # Procesar ubicacionespre de migración
      (caso_params[:migracion_attributes] || []).each do |clave, mp|
        mi = Sivel2Sjr::Migracion.find(mp[:id].to_i)
        mi.salidaubicacionpre_id = Sip::Ubicacionpre::buscar_o_agregar(
          mp[:salida_pais_id], mp[:salida_departamento_id],
          mp[:salida_municipio_id], mp[:salida_clase_id],
          mp[:salida_lugar], mp[:salida_sitio], mp[:salida_tsitio_id],
          mp[:salida_latitud], mp[:salida_longitud]
        )
        mi.llegadaubicacionpre_id = Sip::Ubicacionpre::buscar_o_agregar(
          mp[:llegada_pais_id], mp[:llegada_departamento_id],
          mp[:llegada_municipio_id], mp[:llegada_clase_id],
          mp[:llegada_lugar], mp[:llegada_sitio], mp[:llegada_tsitio_id],
          mp[:llegada_latitud], mp[:llegada_longitud]
        )
        mi.destinoubicacionpre_id = Sip::Ubicacionpre::buscar_o_agregar(
          mp[:destino_pais_id], mp[:destino_departamento_id],
          mp[:destino_municipio_id], mp[:destino_clase_id],
          mp[:destino_lugar], mp[:destino_sitio], mp[:destino_tsitio_id],
          mp[:destino_latitud], mp[:destino_longitud]
        )
        mi.save!
      end

      (caso_params[:desplazamiento_attributes] || []).each do |clave, dp|
        de = Sivel2Sjr::Desplazamiento.find(dp[:id].to_i)
        de.expulsionubicacionpre_id = Sip::Ubicacionpre::buscar_o_agregar(
          dp[:expulsion_pais_id], dp[:expulsion_departamento_id],
          dp[:expulsion_municipio_id], dp[:expulsion_clase_id],
          dp[:expulsion_lugar], dp[:expulsion_sitio], dp[:expulsion_tsitio_id],
          dp[:expulsion_latitud], dp[:expulsion_longitud]
        )
        de.llegadaubicacionpre_id = Sip::Ubicacionpre::buscar_o_agregar(
          dp[:llegada_pais_id], dp[:llegada_departamento_id],
          dp[:llegada_municipio_id], dp[:llegada_clase_id],
          dp[:llegada_lugar], dp[:llegada_sitio], dp[:llegada_tsitio_id],
          dp[:llegada_latitud], dp[:llegada_longitud]
        )
        de.destinoubicacionpre_id = Sip::Ubicacionpre::buscar_o_agregar(
          dp[:destino_pais_id], dp[:destino_departamento_id],
          dp[:destino_municipio_id], dp[:destino_clase_id],
          dp[:destino_lugar], dp[:destino_sitio], dp[:destino_tsitio_id],
          dp[:destino_latitud], dp[:destino_longitud]
        )
        de.save!
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

    def desplazamiento_params
      [
        :desplazamiento_attributes => [
          :acompestado, 
          :connacionaldeportado,
          :connacionalretorno,
          :declaracionruv_id,
          :declaro, 
          :descripcion, 
          :destino_clase_id,
          :destino_departamento_id,
          :destino_latitud,
          :destino_longitud,
          :destino_lugar,
          :destino_municipio_id,
          :destino_pais_id,
          :destino_sitio,
          :destino_tsitio_id,
          :expulsion_clase_id,
          :expulsion_departamento_id,
          :expulsion_latitud,
          :expulsion_longitud,
          :expulsion_lugar,
          :expulsion_municipio_id,
          :expulsion_pais_id,
          :expulsion_sitio,
          :expulsion_tsitio_id,
          :documentostierra,
          :establecerse,
          :fechadeclaracion,
          :fechadeclaracion_localizada,
          :fechaexpulsion, 
          :fechaexpulsion_localizada, 
          :fechallegada, 
          :fechallegada_localizada, 
          :hechosdeclarados,
          :id, 
          :id_acreditacion, 
          :id_clasifdesp, 
          :id_declaroante, 
          :id_expulsion, 
          :id_inclusion,
          :id_llegada, 
          :id_modalidadtierra,
          :id_tipodesp, 
          :inmaterialesperdidos,
          :llegada_clase_id,
          :llegada_departamento_id,
          :llegada_latitud,
          :llegada_longitud,
          :llegada_lugar,
          :llegada_municipio_id,
          :llegada_pais_id,
          :llegada_sitio,
          :llegada_tsitio_id,
          :materialesperdidos, 
          :protegiorupta, 
          :oficioantes, 
          :otrosdatos,
          :retornado,
          :reubicado, 
          :_destroy,
          :categoria_ids => [],
          :anexo_desplazamiento_attributes => [
              :fecha_localizada,
              :id, 
              :desplazamiento_id,
              :_destroy,
              :sip_anexo_attributes => [
                :adjunto, 
                :descripcion, 
                :id, 
                :_destroy
              ]
            ]
        ]
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
