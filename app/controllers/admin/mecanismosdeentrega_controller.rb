# encoding: UTF-8

module Admin
  class MecanismosdeentregaController < Sip::Admin::BasicasController
    before_action :set_mecanismodeentrega, 
      only: [:show, :edit, :update, :destroy]
    load_and_authorize_resource  class: ::Mecanismodeentrega

    def clase 
      "::Mecanismodeentrega"
    end

    def set_mecanismodeentrega
      @basica = Mecanismodeentrega.find(params[:id])
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

    def mecanismodeentrega_params
      params.require(:mecanismodeentrega).permit(*atributos_form)
    end

  end
end
