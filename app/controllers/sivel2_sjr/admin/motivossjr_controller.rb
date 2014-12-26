# encoding: UTF-8
module Sivel2Sjr
  module Admin
    class MotivossjrController < Sivel2Gen::Admin::BasicasController
      before_action :set_motivosjr, only: [:show, :edit, :update, :destroy]
      load_and_authorize_resource class: Sivel2Sjr::Motivosjr

      def clase 
        "Sivel2Sjr::Motivosjr"
      end

      def atributos_index
        ["id",  "nombre" ] + 
          [ :derecho_ids =>  [] ] +
          ["fechacreacion", "fechadeshabilitacion"] 
      end

      # Use callbacks to share common setup or constraints between actions.
      def set_motivosjr
        @basica = Sivel2Sjr::Motivosjr.find(params[:id])
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def motivosjr_params
        params.require(:motivosjr).permit(*atributos_form)
      end

    end
  end
end
