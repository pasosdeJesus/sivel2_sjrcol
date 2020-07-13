# encoding: UTF-8

module Admin
  class CausasmigracionController < Sip::Admin::BasicasController
    before_action :set_causamigracion, 
      only: [:show, :edit, :update, :destroy]
    load_and_authorize_resource  class: ::Causamigracion

    def clase 
      "::Causamigracion"
    end

    def set_causamigracion
      @basica = Causamigracion.find(params[:id])
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

    def causamigracion_params
      params.require(:causamigracion).permit(*atributos_form)
    end

  end
end
