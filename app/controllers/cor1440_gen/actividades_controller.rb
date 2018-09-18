# encoding: UTF-8
require_dependency "cor1440_gen/concerns/controllers/actividades_controller"

module Cor1440Gen
  class ActividadesController < Heb412Gen::ModelosController
    include Cor1440Gen::Concerns::Controllers::ActividadesController

    Cor1440Gen.actividadg1 = "Funcionarias del SJR"
    Cor1440Gen.actividadg3 = "Funcionarios del SJR"

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
        :valorcampoact,
        :objetivo,
        :resultado, 
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

    def vector_a_registro(a, ac)

      pob = ac.actividad_rangoedadac.map { |i| 
        (i.ml ? i.ml : 0) + (i.mr ? i.mr : 0) +
          (i.fl ? i.fl : 0) + (i.fr ? i.fr : 0)
      } 
      return {
        id: a[0],
        fecha: a[1],
        oficina: a[2],
        responsable: a[3],
        nombre: a[4],
        tipos_de_actividad: a[5],
        areas: a[6],
        subareas: a[7],
        convenios_financieros: a[8],
        objetivo: a[9],
        lugar: a[10],
        poblacionmujeres: a[11],
        poblacionhombres: a[12],
        poblacion: pob.reduce(:+),
        observaciones: ac.observaciones,
        resultado: ac.resultado,
        creacion: ac.created_at,
        actualizacion: ac.updated_at,
        corresponsables: ac.usuario.inject("") { |memo, i| 
          (memo == "" ? "" : memo + "; ") + i.nusuario },
      }
    end

  end
end
