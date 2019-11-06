# encoding: UTF-8

require_dependency 'sivel2_sjr/concerns/controllers/casos_controller'
require_dependency 'heb412_gen/docs_controller'

module Sivel2Sjr
  class CasosController < Heb412Gen::ModelosController

    include Sivel2Sjr::Concerns::Controllers::CasosController


    # Campos en filtro
    def campos_filtro1
      [:codigo,
       :fechaini, :fechafin, 
       :fecharecini, :fecharecfin, 
       :oficina_id, :usuario_id,
       :ultimaatencion_fechaini, :ultimaatencion_fechafin,
       :expulsion_pais_id, :expulsion_departamento_id, :expulsion_municipio_id,
       :llegada_pais_id, :llegada_departamento_id, :llegada_municipio_id,
       :nombressp, :apellidossp,
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

    def otros_params
      [
        :migracion_attributes => [
          :fechallegada,
          :fechasalida,
          :id,
          :salida_pais_id,
          :salida_departamento_id,
          :salida_municipio_id,
          :salida_clase_id,
          :se_establece_en_sitio_llegada,
          :_destroy
        ]
      ]
    end

  end
end
