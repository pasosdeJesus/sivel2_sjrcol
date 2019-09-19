# encoding: UTF-8
require_dependency "sivel2_sjr/concerns/controllers/actividades_controller"

module Cor1440Gen
  class ActividadesController < Heb412Gen::ModelosController
    include Sivel2Sjr::Concerns::Controllers::ActividadesController

    before_action :set_actividad, 
      only: [:show, :edit, :update, :destroy],
      exclude: [:cuenta]

    Cor1440Gen.actividadg1 = "Funcionarias del SJR"
    Cor1440Gen.actividadg3 = "Funcionarios del SJR"

    def new
      new_cor1440_gen
      @registro.fecha = Date.today
      if params['usuario_id'] && 
        ::Usuario.where(id: params['usuario_id'].to_i).count == 1
        @registro.usuario_id = params['usuario_id'].to_i
      end
      if params['caso_id'] && 
        Sivel2Sjr::Casosjr.where(id_caso: params['caso_id'].to_i).count == 1
        @registro.casosjr_ids = [params['caso_id']]
      end
      @registro.proyectofinanciero_ids = [10]
      if params['nombre'] 
        @registro.nombre = params['nombre']
      end
      @registro.actividadpf_ids = []
      if params[:ahumanitaria] == "true"
        @registro.actividadpf_ids |=  [62, 116] # SEGCAS, ASHUM
      end
      if params[:ojuridica] == "true"
        @registro.actividadpf_ids |=  [62, 118] # SEGCAS, ASJUR
      end
      if params[:ajuridica] == "true"
        @registro.actividadpf_ids |=  [62, 125] # SEGCAS, ACJUR
      end
      if params[:oservicios] == "true"
        @registro.actividadpf_ids |=  [62, 126] # SEGCAS, OTSERC
      end

      redirect_to cor1440_gen.edit_actividad_path(@registro)
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
    def encabezado_comun
      return [ Cor1440Gen::Actividad.human_attribute_name(:id), 
               @actividades.human_attribute_name(:fecha),
               @actividades.human_attribute_name(:oficina),
               @actividades.human_attribute_name(:responsable),
               @actividades.human_attribute_name(:nombre),
               @actividades.human_attribute_name(:actividadtipos),
               @actividades.human_attribute_name(:proyectos),
               @actividades.human_attribute_name(:actividadareas),
               @actividades.human_attribute_name(:proyectosfinancieros),
               @actividades.human_attribute_name(:objetivo),
               @actividades.human_attribute_name(:lugar),
              @actividades.human_attribute_name(:poblacionmujeres),
               @actividades.human_attribute_name(:poblacionhombres)
      ]
    end

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

    def fila_comun(actividad)
      pobf = actividad.actividad_rangoedadac.map { |i| 
        (i.fl ? i.fl : 0) + (i.fr ? i.fr : 0)
      } 
      pobm = actividad.actividad_rangoedadac.map { |i| 
        (i.ml ? i.ml : 0) + (i.mr ? i.mr : 0)
      } 

      return [actividad.id,
              actividad.fecha , 
              actividad.oficina ? actividad.oficina.nombre : "",
              actividad.responsable ? actividad.responsable.nusuario : "",
              actividad.nombre ? actividad.nombre : "",
              actividad.actividadtipo.inject("") { |memo, i| 
                (memo == "" ? "" : memo + "; ") + i.nombre },
              actividad.proyecto.inject("") { |memo, i| 
                  (memo == "" ? "" : memo + "; ") + i.nombre },
              actividad.actividadareas.inject("") { |memo, i| 
                    (memo == "" ? "" : memo + "; ") + i.nombre },
              actividad.proyectofinanciero.inject("") { |memo, i| 
                      (memo == "" ? "" : memo + "; ") + i.nombre },
              actividad.objetivo, 
              actividad.lugar, 
              pobf.reduce(:+),
              pobm.reduce(:+)
      ]
    end

    def filtra_contar_control_acceso
      @contar_pfid = 10  # Plan Estrategico 1
    end

  end
end
