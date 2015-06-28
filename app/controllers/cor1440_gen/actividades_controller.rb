# encoding: UTF-8
require_dependency "cor1440_gen/concerns/controllers/actividades_controller"

module Cor1440Gen
  class ActividadesController < ApplicationController
    include Cor1440Gen::Concerns::Controllers::ActividadesController


    # Encabezado comun para HTML y PDF (primeras filas)
    def encabezado_comun
      return [ Cor1440Gen::Actividad.human_attribute_name(:id), 
        @actividades.human_attribute_name(:fecha),
        @actividades.human_attribute_name(:oficina),
        @actividades.human_attribute_name(:nombre),
        'Subáreas',
        @actividades.human_attribute_name(:tipos),
        @actividades.human_attribute_name(:objetivo),
        @actividades.human_attribute_name(:proyectos),
        @actividades.human_attribute_name(:poblacion),
      ]
    end

  end
end
