# encoding: UTF-8

module Admin
  class DificultadesmigracionController < Sip::Admin::BasicasController
    before_action :set_dificultadmigracion, 
      only: [:show, :edit, :update, :destroy]
    load_and_authorize_resource  class: ::Dificultadmigracion

    def clase 
      "::Dificultadmigracion"
    end

    def set_dificultadmigracion
      @basica = Dificultadmigracion.find(params[:id])
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

    def dificultadmigracion_params
      params.require(:dificultadmigracion).permit(*atributos_form)
    end

  end
end
