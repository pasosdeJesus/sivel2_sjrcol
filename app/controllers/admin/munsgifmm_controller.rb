module Admin
  class MunsgifmmController < Sip::Admin::BasicasController
    before_action :set_mungifmm, 
      only: [:show, :edit, :update, :destroy]
    load_and_authorize_resource  class: ::Mungifmm

    def clase 
      "::Mungifmm"
    end

    def set_mungifmm
      @basica = Mungifmm.find(params[:id])
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

    def mungifmm_params
      params.require(:mungifmm).permit(*atributos_form)
    end

  end
end
