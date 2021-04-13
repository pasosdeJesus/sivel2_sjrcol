require 'sivel2_sjr/concerns/controllers/inclusiones_controller'

module Sivel2Sjr
  module Admin
    class InclusionesController < Sip::Admin::BasicasController
      before_action :set_inclusion, only: [:show, :edit, :update, :destroy]
      load_and_authorize_resource class: Sivel2Sjr::Inclusion

      include Sivel2Sjr::Concerns::Controllers::InclusionesController

      def atributos_index
        [:id,
         :nombre,
         :observaciones,
         :pospres,
         :fechacreacion_localizada,
         :habilitado
        ]
      end

    end
  end
end
