# encoding: UTF-8

require 'sal7711_gen/concerns/controllers/articulos_controller'

module Sal7711Gen
  class ArticulosController < ApplicationController
 
    include Sal7711Gen::Concerns::Controllers::ArticulosController    


    def articulo_params
      params.require(:articulo).permit(
        :departamento_id, 
        :municipio_id, 
        :fuenteprensa_id, 
        :fecha, 
        :pagina,
        :url,
        :texto,
        {:categoriaprensa_ids => []},
        {:anexo_attributes => [
          :id, :fecha, :descripcion, :archivo, :adjunto, :_destroy
        ]}
      )
    end

  end
end
