# encoding: UTF-8

require_dependency 'sivel2_sjr/concerns/controllers/casos_controller'
require_dependency 'heb412_gen/docs_controller'

module Sivel2Sjr
  class CasosController < ApplicationController

    include Sivel2Sjr::Concerns::Controllers::CasosController

    def inicializa_index
      @plantillas = Heb412Gen::Doc.where(
        vista: 'Listado de casos').select('nombremenu, id').map { 
          |c| [c.nombremenu, c.id] } 
    end

    def presenta_index
      # Presentación
      respond_to do |format|
        format.html { 
            render layout: 'application' 
        }
        format.js { 
          if params[:filtro] && params[:filtro]['dispresenta'].to_i > 0 &&
            params[:filtro]['dispresenta'].to_i > 0 &&
            !Heb412Gen::Doc.find(params[:filtro]['dispresenta']).nil?
            pl = Heb412Gen::Doc.find(params[:filtro]['dispresenta'])
            byebug
            ::Heb412Gen::DocsController.llena_plantilla_multiple_fd(pl, @conscaso)
          else
            render 'sivel2_gen/casos/filtro' 
          end
        }
      end
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

    # Tipo de reporte Resolución 1612
    def filtro_particular(conscaso, params_filtro)
      if (params_filtro['dispresenta'] == 'tabla1612') 
        @incluir =  [
          'casoid', 'tipificacion', 'victimas', 'fecha', 
          'ubicaciones', 'presponsables', 'memo', 'memo1612'
        ]
        conscaso = conscaso.where('caso_id in (SELECT id_caso 
                                        FROM sivel2_gen_acto
                                        WHERE id_categoria = 75)')
      end
      return conscaso
    end
  end
end
