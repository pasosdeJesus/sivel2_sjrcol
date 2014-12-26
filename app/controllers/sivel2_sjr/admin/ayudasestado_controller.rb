# encoding: UTF-8
module Sivel2Sjr
  module Admin
    class AyudasestadoController < Sivel2Gen::Admin::BasicasController
      before_action :set_ayudaestado, only: [:show, :edit, :update, :destroy]
      load_and_authorize_resource class: Sivel2Sjr::Ayudaestado

      def clase 
        "Sivel2Sjr::Ayudaestado"
      end

      def atributos_index
        ["id",  "nombre" ] + 
          [ :derecho_ids =>  [] ] +
          ["fechacreacion", "fechadeshabilitacion"] 
      end

      def set_ayudaestado
        @basica = Sivel2Sjr::Ayudaestado.find(params[:id])
      end

      # Lista blanca de parametros
      def ayudaestado_params
        params.require(:ayudaestado).permit(*atributos_form)
      end

    end
  end
end
