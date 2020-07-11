# encoding: UTF-8

require_dependency 'sivel2_sjr/concerns/controllers/casos_controller'
require_dependency 'heb412_gen/docs_controller'

module Sivel2Sjr
  class CasosController < Heb412Gen::ModelosController

    include Sivel2Sjr::Concerns::Controllers::CasosController

    before_action :set_caso, only: [:show, :edit, :update, :destroy],
      exclude: [:poblacion_sexo_rangoedadac]
    load_and_authorize_resource class: Sivel2Gen::Caso

    def vistas_manejadas
      ['Caso']
    end

    # Campos en filtro
    def campos_filtro1
      [:codigo,
       :fechaini, :fechafin, 
       :fecharecini, :fecharecfin, 
       :oficina_id, :usuario_id,
       :ultimaatencion_fechaini, :ultimaatencion_fechafin,
       :expulsion_pais_id, :expulsion_departamento_id, :expulsion_municipio_id,
       :llegada_pais_id, :llegada_departamento_id, :llegada_municipio_id,
       :nombressp, :apellidossp, :tdocumento, :numerodocumento,
       :nombres, :apellidos, :sexo, :rangoedad_id, 
       :categoria_id,
       :descripcion
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
      [ :actualtrabajando ]
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
          :causaRefugio_id,
          :destino_clase_id,
          :destino_departamento_id,
          :destino_municipio_id,
          :destino_pais_id,
          :fechallegada,
          :fechaNpi,
          :fechaPep,
          :fechasalida,
          :id,
          :llegada_clase_id,
          :llegada_departamento_id,
          :llegada_municipio_id,
          :llegada_pais_id,
          :migracontactopre_id,
          :observacionesref,
          :pep,
          :perfilmigracion_id,
          :proteccion_id,
          :salida_pais_id,
          :salida_departamento_id,
          :salida_municipio_id,
          :salida_clase_id,
          :salvoNpi,
          :se_establece_en_sitio_llegada,
          :statusmigratorio_id,
          :viadeingreso_id,
          :_destroy
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
      ce = Sivel2Gen::Consexpcaso.crea_consexpcaso(cc, nil)
      @registro = @basica = Sivel2Gen::Consexpcaso.
        where(caso_id: params[:id]).take
    end

  end
end
