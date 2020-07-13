# encoding: UTF-8

module Admin
  class ViasdeingresoController < Sip::Admin::BasicasController
    before_action :set_viadeingreso, 
      only: [:show, :edit, :update, :destroy]
    load_and_authorize_resource  class: ::Viadeingreso

    def clase 
      "::Viadeingreso"
    end

    def set_viadeingreso
      @basica = Viadeingreso.find(params[:id])
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

    def viadeingreso_params
      params.require(:viadeingreso).permit(*atributos_form)
    end

  end
end
