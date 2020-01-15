# encoding: UTF-8
module Sivel2Sjr
  module Admin
    class ProgsestadoController < Sip::Admin::BasicasController
      before_action :set_progestado, only: [:show, :edit, :update, :destroy]
      load_and_authorize_resource  class: Sivel2Sjr::Progestado

      def clase 
        "Sivel2Sjr::Progestado"
      end

      def atributos_index
        ["id",  "nombre" ] + 
          [ :derecho_ids =>  [] ] +
          ["observaciones", "fechacreacion", "fechadeshabilitacion"] 
      end

      def genclase
        return 'M'
      end

      def create
        m = Sivel2Sjr::Progestado.create(id: progestado_params[:id], nombre: progestado_params[:nombre], observaciones: progestado_params[:observaciones], fechacreacion: progestado_params[:fechacreacion], fechadeshabilitacion: progestado_params[:fechadeshabilitacion])
        
        n = Sivel2Sjr::ProgestadoDerecho.create(progestado_id: m.id, derecho_id: progestado_params[:derecho_ids])
        redirect_to "/admin/progsestado"
      end  
      # Use callbacks to share common setup or constraints between actions.
      def set_progestado
        @basica = Sivel2Sjr::Progestado.find(params[:id])
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def progestado_params
        params.require(:progestado).permit(*atributos_form)
      end

    end
  end
end
