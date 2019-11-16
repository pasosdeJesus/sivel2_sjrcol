# encoding: UTF-8

module Admin
  class MigracontactospreController < Sip::Admin::BasicasController
    before_action :set_migracontactopre, 
      only: [:show, :edit, :update, :destroy]
    load_and_authorize_resource  class: ::Migracontactopre

    def clase 
      "::Migracontactopre"
    end

    def set_migracontactopre
      @basica = Migracontactopre.find(params[:id])
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

    def migracontactopre_params
      params.require(:migracontactopre).permit(*atributos_form)
    end

  end
end
