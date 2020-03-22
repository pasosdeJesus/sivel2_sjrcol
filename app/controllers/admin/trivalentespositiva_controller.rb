# encoding: UTF-8

module Admin
  class TrivalentespositivaController < Sip::Admin::BasicasController
    before_action :set_trivalentepositiva, 
      only: [:show, :edit, :update, :destroy]
    load_and_authorize_resource  class: ::Trivalentepositiva

    def clase 
      "::Trivalentepositiva"
    end

    def set_trivalentepositiva
      @basica = Trivalentepositiva.find(params[:id])
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
      'F'
    end

    def trivalentepositiva_params
      params.require(:trivalentepositiva).permit(*atributos_form)
    end

  end
end
