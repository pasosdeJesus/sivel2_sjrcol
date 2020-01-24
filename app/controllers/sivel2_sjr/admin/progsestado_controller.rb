# encoding: UTF-8
module Sivel2Sjr
  module Admin
    class ProgsestadoController < Sip::Admin::BasicasController
      before_action :set_progestado, only: [:show, :edit, :update, :destroy]
      load_and_authorize_resource  class: Sivel2Sjr::Progestado

      def clase 
        'Sivel2Sjr::Progestado'
      end

      def atributos_index
        ['id',  'nombre' ] + 
          [ :derecho_ids =>  [] ] +
          ['observaciones', 'fechacreacion', 'fechadeshabilitacion'] 
      end

      def genclase
        return 'M'
      end

      def create
        m = Sivel2Sjr::Progestado.new(
          nombre: progestado_params[:nombre], 
          observaciones: progestado_params[:observaciones], 
          fechacreacion: progestado_params[:fechacreacion], 
          fechadeshabilitacion: progestado_params[:fechadeshabilitacion]
        )
        m.save!
        m.derecho_ids = progestado_params[:derecho_ids]
        m.save!
        redirect_to sivel2_sjr.admin_progsestado_path #'/admin/progsestado'
      end

      def set_progestado
        @basica = Sivel2Sjr::Progestado.find(params[:id])
      end

      def progestado_params
        params.require(:progestado).permit(*atributos_form)
      end

    end
  end
end
