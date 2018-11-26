# encoding: UTF-8

module Admin
  class DiscapacidadesController < Sip::Admin::BasicasController
    before_action :set_discapacidad, 
      only: [:show, :edit, :update, :destroy]
    load_and_authorize_resource  class: ::Discapacidad

    def clase 
      "::Discapacidad"
    end

    def set_discapacidad
      @basica = Discapacidad.find(params[:id])
    end

    def atributos_index
      [
        "id", 
        "nombre", 
        "observaciones", 
        "fechacreacion_localizada", 
        "habilitado"
      ]
    end

    def genclase
      'M'
    end

    def discapacidad_params
      params.require(:discapacidad).permit(*atributos_form)
    end

  end
end
