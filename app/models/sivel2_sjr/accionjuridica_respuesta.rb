# encoding: UTF-8

module Sivel2Sjr
  class AccionjuridicaRespuesta < ActiveRecord::Base
    belongs_to :accionjuridica, class_name: 'Sivel2Sjr::Accionjuridica', 
      foreign_key: "accionjuridica_id"
    belongs_to :respuesta, class_name: 'Sivel2Sjr::Respuesta',
      foreign_key: "respuesta_id"

    validates_presence_of :accionjuridica
    validates_presence_of :respuesta

    validates_uniqueness_of :accionjuridica, scope: :respuesta_id
  end
end
