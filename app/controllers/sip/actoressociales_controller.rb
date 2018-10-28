# encoding: UTF-8
require_dependency "sip/concerns/controllers/actoressociales_controller"

module Sip
  class ActoressocialesController < Sip::ModelosController
    include Sip::Concerns::Controllers::ActoressocialesController
    
    def atributos_index
      [ :id, 
        :grupoper_id,
        :tipoactorsocial_id,
        { :sectoractor_ids => [] },
        :web,
        :telefono, 
        :fax,
        :pais,
        :direccion
      ]
    end

  end
end
