# encoding: UTF-8

module Admin
  class UnidadesayudaController < Sip::Admin::BasicasController
    before_action :set_unidadayuda, 
      only: [:show, :edit, :update, :destroy]
    load_and_authorize_resource  class: ::Unidadayuda

    def clase 
      "::Unidadayuda"
    end

    def set_unidadayuda
      @basica = Unidadayuda.find(params[:id])
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

    def unidadayuda_params
      params.require(:unidadayuda).permit(*atributos_form)
    end

  end
end
