# encoding: UTF-8

module Sivel2Sjr
  class Accionjuridica < ActiveRecord::Base
    include Sip::Basica

    has_many :accionjuridica_respuesta, 
      class_name: 'Sivel2Sjr::AccionjuridicaRespuesta',
      foreign_key: 'accionjuridica_id'
    has_many :respuesta, 
      class_name: 'Sivel2Sjr::Respuesta',
      through: :accionjuridica_respuesta

  end
end
