# encoding: UTF-8
module Sivel2Sjr
  module Admin
    class ClasifdespsController < Sip::Admin::BasicasController
      before_action :set_clasifdesp, only: [:show, :edit, :update, :destroy]
      load_and_authorize_resource class: Sivel2Sjr::Clasifdesp

      def clase 
        "Sivel2Sjr::Clasifdesp"
      end

      def set_clasifdesp
        @basica = Sivel2Sjr::Clasifdesp.find(params[:id])
      end

      # Lista blanca de parametros
      def clasifdesp_params
        params.require(:clasifdesp).permit(*atributos_form)
      end

    end
  end
end
