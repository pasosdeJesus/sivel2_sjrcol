# encoding: UTF-8
require_dependency "cor1440_gen/concerns/controllers/actividades_controller"

module Cor1440Gen
  class ActividadesController < ApplicationController
    include Cor1440Gen::Concerns::Controllers::ActividadesController

    Cor1440Gen.actividadg1 = "Funcionarias del SJR"
    Cor1440Gen.actividadg3 = "Funcionarios del SJR"

    def self.filtramas(par, ac)
        return ac
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

  end
end
