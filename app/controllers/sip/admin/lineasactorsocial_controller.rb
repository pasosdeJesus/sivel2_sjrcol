# encoding: UTF-8

module Sip
  module Admin
    class LineasactorsocialController < Sip::Admin::BasicasController
      before_action :set_lineaactorsocial, 
        only: [:show, :edit, :update, :destroy]
      load_and_authorize_resource  class: Sip::Lineaactorsocial
  
      def clase 
        "Sip::Lineaactorsocial"
      end
  
      def set_lineaactorsocial
        @basica = Sip::Lineaactorsocial.find(params[:id])
      end
  
      def atributos_index
        [
          "id", 
          "nombre", 
          "observaciones", 
          "fechacreacion_localizada", 
          "habilitado"
        ]
      end
  
      def genclase
        'F'
      end
  
      def lineaactorsocial_params
        params.require(:lineaactorsocial).permit(*atributos_form)
      end
  
    end
  end
end
