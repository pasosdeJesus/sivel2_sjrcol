# encoding: UTF-8

module Admin
  class AutoridadesrefugioController < Sip::Admin::BasicasController
    before_action :set_autoridadrefugio, 
      only: [:show, :edit, :update, :destroy]
    load_and_authorize_resource  class: ::Autoridadrefugio

    def clase 
      "::Autoridadrefugio"
    end

    def set_autoridadrefugio
      @basica = Autoridadrefugio.find(params[:id])
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

    def autoridadrefugio_params
      params.require(:autoridadrefugio).permit(*atributos_form)
    end

  end
end
