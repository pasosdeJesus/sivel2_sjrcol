# encoding: UTF-8
require_dependency "sip/concerns/controllers/actoressociales_controller"

module Sip
  class ActoressocialesController < Heb412Gen::ModelosController
    include Sip::Concerns::Controllers::ActoressocialesController
    
    def atributos_index
      [ :id, 
        :grupoper_id,
        :tipoactorsocial_id,
        { :sectoractor_ids => [] },
        :lineaactorsocial_id,
        :email,
        :web,
        :telefono, 
        :fax,
        :pais,
        :departamento,
        :municipio,
        :direccion,
        :nit,
        :habilitado
      ]
    end

    def actorsocial_params
      params.require(:actorsocial).permit(
        atributos_form - [:grupoper] +
        [ :departamento_id,
          :municipio_id,
          :pais_id,
          :grupoper_attributes => [
            :id,
            :nombre,
            :anotaciones ]
      ]) 
    end

    def vistas_manejadas
      ['Actorsocial']
    end

  end
end
