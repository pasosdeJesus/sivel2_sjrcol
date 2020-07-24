# encoding: UTF-8

module Admin
  class CausasagresionController < Sip::Admin::BasicasController
    before_action :set_causaagresion, 
      only: [:show, :edit, :update, :destroy]
    load_and_authorize_resource  class: ::Causaagresion

    def clase 
      "::Causaagresion"
    end

    def set_causaagresion
      @basica = Causaagresion.find(params[:id])
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

    def causaagresion_params
      params.require(:causaagresion).permit(*atributos_form)
    end

  end
end
