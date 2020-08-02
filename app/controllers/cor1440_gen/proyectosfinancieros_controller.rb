# encoding: UTF-8

require_dependency 'sivel2_sjr/concerns/controllers/proyectosfinancieros_controller'

module Cor1440Gen
  class ProyectosfinancierosController < Heb412Gen::ModelosController
    
    include Sivel2Sjr::Concerns::Controllers::ProyectosfinancierosController

    load_and_authorize_resource  class: Cor1440Gen::Proyectofinanciero,
      only: [:new, :create, :destroy, :edit, :update, :index, :show,
             :objetivospf]

  end
end
