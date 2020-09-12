# encoding: UTF-8

module Admin
  class ModalidadesentregaController < Sip::Admin::BasicasController
    before_action :set_modalidadentrega, 
      only: [:show, :edit, :update, :destroy]
    load_and_authorize_resource  class: ::Modalidadentrega

    def clase 
      "::Modalidadentrega"
    end

    def set_modalidadentrega
      @basica = Modalidadentrega.find(params[:id])
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

    def modalidadentrega_params
      params.require(:modalidadentrega).permit(*atributos_form)
    end

  end
end
