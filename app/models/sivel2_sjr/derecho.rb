# encoding: UTF-8

require 'sivel2_sjr/concerns/models/derecho'

class Sivel2Sjr::Derecho < ActiveRecord::Base
  include Sivel2Sjr::Concerns::Models::Derecho

  has_many :ayudaestado_derecho, class_name: 'Sivel2Sjr::AyudaestadoDerecho', foreign_key: "derecho_id"
  has_many :ayudasjr_derecho, class_name: 'Sivel2Sjr::AyudasjrDerecho', foreign_key: "derecho_id"
  has_many :motivosjr_derecho, class_name: 'Sivel2Sjr::MotivosjrDerecho', foreign_key: "derecho_id"
  has_many :progestado_derecho, class_name: 'Sivel2Sjr::ProgestadoDerecho', foreign_key: "derecho_id"
  has_many :respuesta, :through => :derecho_respuesta

end
