# encoding: UTF-8

module Admin
  class PerfilesmigracionController < Sip::Admin::BasicasController
    before_action :set_perfilmigracion, 
      only: [:show, :edit, :update, :destroy]
    load_and_authorize_resource  class: ::Perfilmigracion

    def clase 
      "::Perfilmigracion"
    end

    def set_perfilmigracion
      @basica = Perfilmigracion.find(params[:id])
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

    def perfilmigracion_params
      params.require(:perfilmigracion).permit(*atributos_form)
    end

  end
end
