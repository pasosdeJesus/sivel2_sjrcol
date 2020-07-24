# encoding: UTF-8

module Admin
  class AgresionesmigracionController < Sip::Admin::BasicasController
    before_action :set_agresionmigracion, 
      only: [:show, :edit, :update, :destroy]
    load_and_authorize_resource  class: ::Agresionmigracion

    def clase 
      "::Agresionmigracion"
    end

    def set_agresionmigracion
      @basica = Agresionmigracion.find(params[:id])
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

    def agresionmigracion_params
      params.require(:agresionmigracion).permit(*atributos_form)
    end

  end
end
