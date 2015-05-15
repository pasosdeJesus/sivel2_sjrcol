# encoding: UTF-8

require 'sivel2_sjr/concerns/models/respuesta'
module Sivel2Sjr
  class Respuesta < ActiveRecord::Base
    include Sivel2Sjr::Concerns::Models::Respuesta

    has_many :ayudaestado_respuesta, 
      class_name: "Sivel2Sjr::AyudaestadoRespuesta",  
      foreign_key: "id_respuesta", dependent: :destroy
    has_many :ayudaestado, class_name: "Sivel2Sjr::Ayudaestado", 
      :through => :ayudaestado_respuesta
  end
end
