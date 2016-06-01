# encoding: UTF-8

require 'sal7711_gen/concerns/controllers/buscar_controller'

module Sal7711Gen
  class BuscarController < ApplicationController
 
    include Sal7711Gen::Concerns::Controllers::BuscarController    

    def orden_articulos
      "fecha DESC"
    end

  end
end
