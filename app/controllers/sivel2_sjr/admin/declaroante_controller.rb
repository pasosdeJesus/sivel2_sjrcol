# encoding: UTF-8
module Sivel2Sjr
  module Admin
    class DeclaroanteController < Sivel2Gen::Admin::BasicasController
      before_action :set_declaroante, only: [:show, :edit, :update, :destroy]
      load_and_authorize_resource class: Sivel2Sjr::Declaroante

      def clase 
        "Sivel2Sjr::Declaroante"
      end

      def atributos_index
        ["id",  "nombre" ] + 
          [ :derecho_ids =>  [] ] +
          ["fechacreacion", "fechadeshabilitacion"] 
      end

      # Use callbacks to share common setup or constraints between actions.
      def set_declaroante
        @basica = Sivel2Sjr::Declaroante.find(params[:id])
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def declaroante_params
        params.require(:declaroante).permit(*atributos_form)
      end

    end
  end
end
