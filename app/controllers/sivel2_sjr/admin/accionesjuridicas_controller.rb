# encoding: UTF-8

module Sivel2Sjr
  module Admin
    class AccionesjuridicasController < Sip::Admin::BasicasController
      before_action :set_accionjuridica, 
        only: [:show, :edit, :update, :destroy]
      load_and_authorize_resource  class: Sivel2Sjr::Accionjuridica
  
      def clase 
        "Sivel2Sjr::Accionjuridica"
      end
  
      def set_accionjuridica
        @basica = Sivel2Sjr::Accionjuridica.find(params[:id])
      end
  
      def atributos_index
        [
          "id", "nombre", "observaciones", "fechacreacion", 
          "fechadeshabilitacion"
        ]
      end
  
      def genclase
        'F'
      end
  
      def accionjuridica_params
        params.require(:accionjuridica).permit(*atributos_form)
      end
  
    end
  end
end
