# encoding: UTF-8

module Admin
  class IndicadoresgifmmController < Sip::Admin::BasicasController
    before_action :set_indicadorgifmm, 
      only: [:show, :edit, :update, :destroy]
    load_and_authorize_resource  class: ::Indicadorgifmm

    def clase 
      "::Indicadorgifmm"
    end

    def set_indicadorgifmm
      @basica = Indicadorgifmm.find(params[:id])
    end

    def atributos_index
      [
        :id, 
        :nombre,
        :sectorgifmm_id, 
        :observaciones, 
        :fechacreacion_localizada, 
        :habilitado
      ]
    end

    def genclase
      'M'
    end

    def indicadorgifmm_params
      params.require(:indicadorgifmm).permit(*atributos_form)
    end

  end
end
