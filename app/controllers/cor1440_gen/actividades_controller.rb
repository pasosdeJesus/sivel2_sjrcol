# encoding: UTF-8

require_dependency "sivel2_sjr/concerns/controllers/actividades_controller"

module Cor1440Gen
  class ActividadesController < Heb412Gen::ModelosController

    include Sivel2Sjr::Concerns::Controllers::ActividadesController

    before_action :set_actividad, 
      only: [:show, :edit, :update, :destroy],
      exclude: [:contar, :poblacion_sexo_rangoedadac, :contar_beneficiarios]
    load_and_authorize_resource class: Cor1440Gen::Actividad

    Cor1440Gen.actividadg1 = "Funcionarias del SJR"
    Cor1440Gen.actividadg3 = "Funcionarios del SJR"

    def self.posibles_nuevaresp
      return {
        ahumanitaria: ['Asistenia humanitaria', 116],
        ojuridica: ['Orientación jurídica', 118],
        ajuridica: ['Accion Jurídica', 125],
        oservicios: ['Otros servicios y asesorias', 126]
      } 
    end

    # Retorna datos por enviar a nuevo de este controlador
    # desde javascript cuando se añade una respuesta a un caso
    def self.datos_nuevaresp(caso, controller)
      return {
        nombre: "Seguimiento/Respuesta a caso #{caso.id}",
        oficina_id: caso.casosjr.oficina_id,
        caso_id: caso.id, 
        proyecto_id: 101,
        usuario_id: controller.current_usuario.id 
      } 
    end

    def self.pf_planest_id
      10
    end
    
    def self.actividadpf_segcas_id
      62
    end

    def self.filtramas(par, ac, current_usuario)
      @busactividadtipo = param_escapa(par, 'busactividadtipo')
      if @busactividadtipo != '' then
        ac = ac.joins(:actividad_actividadtipo).where(
          "cor1440_gen_actividad_actividadtipo.actividadtipo_id = ?",
          @busactividadtipo.to_i
        ) 
      end
      return ac
    end

    def atributos_index
      [ :id,
        :fecha_localizada,
        :oficina,
        :responsable,
        :nombre,
        :proyecto,
        :actividadareas,
        :proyectofinanciero,
        :actividadpf,
        :objetivo,
        :ubicacion,
        :poblacion_hombres,
        :poblacion_mujeres,
        :poblacion_sin_sexo,
        :anexos
      ]
    end

    def atributos_show
      [ :id, 
        :nombre, 
        :fecha_localizada, 
        :lugar, 
        :oficina, 
        :proyectosfinancieros, 
        :actividadpf, 
        :proyectos,
        :actividadareas, 
        :responsable,
        :corresponsables,
        :respuestafor,
        :objetivo,
        :resultado, 
        :actorsocial,
        :poblacion,
        :anexos
      ]
    end

    def atributos_form
      atributos_show - [:id]
    end
    
    # Encabezado comun para HTML y PDF (primeras filas)
#    def encabezado_comun
#      return [ Cor1440Gen::Actividad.human_attribute_name(:id), 
#               @actividades.human_attribute_name(:fecha),
#               @actividades.human_attribute_name(:oficina),
#               @actividades.human_attribute_name(:responsable),
#               @actividades.human_attribute_name(:nombre),
#               @actividades.human_attribute_name(:actividadtipos),
#               @actividades.human_attribute_name(:proyectos),
#               @actividades.human_attribute_name(:actividadareas),
#               @actividades.human_attribute_name(:proyectosfinancieros),
#               @actividades.human_attribute_name(:objetivo),
#               @actividades.human_attribute_name(:lugar),
#              @actividades.human_attribute_name(:poblacionmujeres),
#               @actividades.human_attribute_name(:poblacionhombres)
#      ]
#    end

    # Elementos de la presentacion de una actividad
    def atributos_presenta
      return [ 
        :id, 
        :fecha, 
        :oficina, 
        :responsable,
        :nombre, 
        :actividadtipos, 
        :proyectos,
        :actividadareas, 
        :proyectosfinancieros, 
        :objetivo
      ]
    end

    # GET /actividades/1/edit
    def edit
      edit_cor1440_gen
      @listadoasistencia = true
      render layout: 'application'
    end

#    def fila_comun(actividad)
#      pobf = actividad.actividad_rangoedadac.map { |i| 
#        (i.fl ? i.fl : 0) + (i.fr ? i.fr : 0)
#      } 
#      pobm = actividad.actividad_rangoedadac.map { |i| 
#        (i.ml ? i.ml : 0) + (i.mr ? i.mr : 0)
#      } 
#
#      return [actividad.id,
#              actividad.fecha , 
#              actividad.oficina ? actividad.oficina.nombre : "",
#              actividad.responsable ? actividad.responsable.nusuario : "",
#              actividad.nombre ? actividad.nombre : "",
#              actividad.actividadtipo.inject("") { |memo, i| 
#                (memo == "" ? "" : memo + "; ") + i.nombre },
#              actividad.proyecto.inject("") { |memo, i| 
#                  (memo == "" ? "" : memo + "; ") + i.nombre },
#              actividad.actividadareas.inject("") { |memo, i| 
#                    (memo == "" ? "" : memo + "; ") + i.nombre },
#              actividad.proyectofinanciero.inject("") { |memo, i| 
#                      (memo == "" ? "" : memo + "; ") + i.nombre },
#              actividad.objetivo, 
#              actividad.lugar, 
#              pobf.reduce(:+),
#              pobm.reduce(:+)
#      ]
#    end

    def filtra_contar_control_acceso
      @contar_pfid = 10  # Plan Estrategico 1
    end

    # Sobrecarga de modelos_controller para sanear parámetros
    # Pero usaremos para sanear datos cuando hay nuevas
    # filas en listado de asistencia
    def filtra_contenido_params
      if !params || !params[:actividad] || 
          !params[:actividad][:asistencia_attributes]
        return
      end
      params[:actividad][:asistencia_attributes].each do |l, v|
        if Cor1440Gen::Asistencia.where(id: v[:id].to_i).count == 0 ||
            !v[:persona_attributes] || 
            !v[:persona_attributes][:id] || v[:persona_attributes][:id] == '' ||
            Sip::Persona.where(id: v[:persona_attributes][:id].to_i).count == 0
          next
        end
        asi = Cor1440Gen::Asistencia.find(v[:id].to_i)
        per = Sip::Persona.find(v[:persona_attributes][:id].to_i)
        if asi.persona_id != per.id && per.nombres = 'N' && per.apellidos = 'N'
          # Era nueva asistencia cuya nueva persona se remplazó tras 
          # autocompletar. Dejar asignada la remplazada y borrar la vacia
          op = asi.persona
          asi.persona_id = per.id
          asi.save
          op.destroy
        end
      end
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

    # Responde a requerimiento AJAX generado por cocoon creando una
    # nueva persona como nuevo asistente para la actividad que recibe 
    # por parámetro  params[:actividad_id].  
    # Pone valores simples en los campos requeridos
    # Como crea personas que podrían ser remplazadas por otras por 
    # autocompletación debería ejecutarse con periodicidad un proceso que
    # elimine todas las personas de nombres N, apellidos N, sexo N, que
    # no este en listado de asistencia ni en casos
    def nueva_asistencia
      authorize! :new, Sip::Persona
      if params[:actividad_id].nil?
        resp_error 'Falta parámetro actividad_id'
        return
      end
      puts "** cuenta: " +Cor1440Gen::Actividad.where(id: params[:actividad_id].to_i).count.to_s
      if Cor1440Gen::Actividad.where(id: params[:actividad_id].to_i).count == 0
        reps_error 'No se encontró actividad ' + 
          params[:actividad_id].to_i.to_s
        return
      end
      act = Cor1440Gen::Actividad.find(params[:actividad_id].to_i)
      @persona = Sip::Persona.create(
        nombres: 'N',
        apellidos: 'N',
        sexo: 'S'
      )
      if !@persona.save
        resp_error 'No pudo crear persona' 
        return
      end
      @asistencia = Cor1440Gen::Asistencia.create(
        actividad_id: act.id,
        persona_id: @persona.id
      )
      if !@asistencia.save
        resp_error 'No pudo crear asistencia' 
        @persona.destroy
        return
      end
      res = {
        'asistencia': @asistencia.id.to_s,
        'persona': @persona.id.to_s
      }.to_json
      respond_to do |format|
        format.js { render text: res }
        format.json { render json: res,
                      status: :created }
        format.html { render inline: res }
      end
    end # def nueva_asistencia

    def lista_params
      lista_params_sivel2_sjr + [:ubicacionpre_id, :covid] + [ 
        :detallefinanciero_attributes => [
          'cantidad',
          'convenioactividad',
          'frecuenciaentrega_id',
          'id',
          'mecanismodeentrega_id',
          'modalidadentrega_id',
          'numeromeses',
          'numeroasistencia'
        ] + [persona_ids: []] + [
          'tipotransferencia_id',
          'unidadayuda_id',
          'valorunitario',
          'valortotal',
          '_destroy'
        ]
      ]
    end

    def actividad_params
      params.require(:actividad).permit(lista_params)
    end

  end
end
