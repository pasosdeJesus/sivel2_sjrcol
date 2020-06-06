module Sip
  module Admin
    class TiposanexoController < Sip::Admin::BasicasController
      before_action :set_tipoanexo, 
        only: [:show, :edit, :update, :destroy]
      load_and_authorize_resource  class: Sip::Tipoanexo

      def clase 
        "Sip::Tipoanexo"
      end

      def set_tipoanexo
        @basica = Sip::Tipoanexo.find(params[:id])
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

      def tipoanexo_params
        params.require(:tipoanexo).permit(*atributos_form)
      end

    end
  end
end
