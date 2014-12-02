# encoding: UTF-8

Sivel2Sjr::Respuesta.class_eval do

  has_many :ayudaestado, class_name: 'Sivel2Sjr::Ayudaestado',
    :through => :ayudaestado_respuesta
  has_many :ayudaestado_respuesta,  class_name: 'Sivel2Sjr::AyudaestadoRespuesta',
    foreign_key: "id_respuesta", dependent: :destroy, validate: true
  accepts_nested_attributes_for :ayudaestado_respuesta, 
    reject_if: :all_blank, update_only: true

  has_many :derecho, class_name: "Sivel2Sjr::Derecho", 
    :through => :derecho_respuesta
  has_many :derecho_respuesta, class_name: "Sivel2Sjr::DerechoRespuesta",  
    foreign_key: "id_respuesta", dependent: :destroy, validate: true
  accepts_nested_attributes_for :derecho_respuesta, reject_if: :all_blank, 
    update_only: true

  has_many :motivosjr, class_name: "Sivel2Sjr::Motivosjr", 
    :through => :motivosjr_respuesta
  has_many :motivosjr_respuesta, class_name: "Sivel2Sjr::MotivosjrRespuesta", 
    foreign_key: "id_respuesta", dependent: :destroy
  accepts_nested_attributes_for :motivosjr_respuesta, 
    reject_if: :all_blank, update_only: true

  has_many :progestado, class_name: "Sivel2Sjr::Progestado", 
    :through => :progestado_respuesta
  has_many :progestado_respuesta, 
    class_name: "Sivel2Sjr::ProgestadoRespuesta",  
    foreign_key: "id_respuesta", dependent: :destroy, validate: true
  accepts_nested_attributes_for :progestado_respuesta, 
    reject_if: :all_blank, update_only: true

end
