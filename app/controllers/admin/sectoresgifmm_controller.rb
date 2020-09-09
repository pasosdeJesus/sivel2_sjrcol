# encoding: UTF-8

module Admin
  class SectoresgifmmController < Sip::Admin::BasicasController
    before_action :set_sectorgifmm, 
      only: [:show, :edit, :update, :destroy]
    load_and_authorize_resource  class: ::Sectorgifmm

    def clase 
      "::Sectorgifmm"
    end

    def set_sectorgifmm
      @basica = Sectorgifmm.find(params[:id])
    end

    def atributos_index
      [
        :id, 
        :nombre, 
        :observaciones, 
        :fechacreacion_localizada, 
        :habilitado
      ]
    end

    def genclase
      'M'
    end

    def sectorgifmm_params
      params.require(:sectorgifmm).permit(*atributos_form)
    end

  end
end
