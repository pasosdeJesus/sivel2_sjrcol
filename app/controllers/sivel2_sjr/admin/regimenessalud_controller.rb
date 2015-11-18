# encoding: UTF-8
module Sivel2Sjr
  module Admin
    class RegimenessaludController < Sip::Admin::BasicasController
      before_action :set_regimensalud, only: [:show, :edit, :update, :destroy]
      load_and_authorize_resource class: Sivel2Sjr::Regimensalud

      def clase 
        "Sivel2Sjr::Regimensalud"
      end

      def set_regimensalud
        @basica = Sivel2Sjr::Regimensalud.find(params[:id])
      end

      def regimensalud_params
        params.require(:regimensalud).permit(*atributos_form)
      end

    end
  end
end
