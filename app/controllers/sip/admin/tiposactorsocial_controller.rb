# encoding: UTF-8

module Sip
  module Admin
    class TiposactorsocialController < Sip::Admin::BasicasController
      before_action :set_tipoactorsocial, 
        only: [:show, :edit, :update, :destroy]
      load_and_authorize_resource  class: Sip::Tipoactorsocial

      def clase 
        "Sip::Tipoactorsocial"
      end

      def set_tipoactorsocial
        @basica = Sip::Tipoactorsocial.find(params[:id])
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
        'M'
      end

      def tipoactorsocial_params
        params.require(:tipoactorsocial).permit(*atributos_form)
      end

    end
  end
end
