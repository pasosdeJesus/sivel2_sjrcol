# encoding: UTF-8

require 'sivel2_sjr/concerns/models/respuesta'

module Sivel2Sjr
  class Respuesta < ActiveRecord::Base
    include Sivel2Sjr::Concerns::Models::Respuesta

    has_many :ayudaestado_respuesta, 
            class_name: "Sivel2Sjr::AyudaestadoRespuesta",  
            foreign_key: "id_respuesta", validate: true,
            dependent: :delete_all
    accepts_nested_attributes_for :ayudaestado_respuesta, 
            reject_if: :all_blank, update_only: true
    has_many :ayudaestado, class_name: "Sivel2Sjr::Ayudaestado", 
            :through => :ayudaestado_respuesta


    has_many :derecho_respuesta, class_name: "Sivel2Sjr::DerechoRespuesta",  
            foreign_key: "id_respuesta", dependent: :delete_all, validate: true
    accepts_nested_attributes_for :derecho_respuesta, reject_if: :all_blank, 
            update_only: true
    has_many :derecho, class_name: "Sivel2Sjr::Derecho", 
            :through => :derecho_respuesta

    has_many :motivosjr_respuesta, class_name: "Sivel2Sjr::MotivosjrRespuesta", 
            foreign_key: "id_respuesta", dependent: :delete_all
    accepts_nested_attributes_for :motivosjr_respuesta, 
            reject_if: :all_blank, update_only: true
    has_many :motivosjr, class_name: "Sivel2Sjr::Motivosjr", 
            :through => :motivosjr_respuesta

    has_many :progestado_respuesta, 
            class_name: "Sivel2Sjr::ProgestadoRespuesta",  
            foreign_key: "id_respuesta", dependent: :delete_all, validate: true
    accepts_nested_attributes_for :progestado_respuesta, 
            reject_if: :all_blank, update_only: true
    has_many :progestado, class_name: "Sivel2Sjr::Progestado", 
            :through => :progestado_respuesta

    validates :fechaatencion, uniqueness: {
      scope: :id_caso,
      message: 'En un caso no puede repetirse fecha de atención'
    }
  end
end
