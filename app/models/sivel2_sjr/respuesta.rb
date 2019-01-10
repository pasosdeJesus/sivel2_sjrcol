# encoding: UTF-8

require 'sivel2_sjr/concerns/models/respuesta'

module Sivel2Sjr
  class Respuesta < ActiveRecord::Base
    include Sivel2Sjr::Concerns::Models::Respuesta

    #accepts_nested_attributes_for :ayudaestado_respuesta, 
    #        reject_if: :all_blank, update_only: true
    has_and_belongs_to_many :ayudaestado, 
      class_name: 'Sivel2Sjr::Ayudaestado', 
      foreign_key: 'id_respuesta', 
      validate: true,
      association_foreign_key: 'id_ayudaestado',
      join_table: 'sivel2_sjr_ayudaestado_respuesta'  

    has_many :accionjuridica_respuesta, 
            class_name: "Sivel2Sjr::AccionjuridicaRespuesta",  
            foreign_key: "respuesta_id", validate: true,
            dependent: :delete_all
    accepts_nested_attributes_for :accionjuridica_respuesta, 
            reject_if: :all_blank, allow_destroy: true
    has_many :accionjuridica, class_name: "Sivel2Sjr::Accionjuridica", 
            :through => :accionjuridica_respuesta

    #accepts_nested_attributes_for :derecho_respuesta, reject_if: :all_blank, 
    #        update_only: true
    has_and_belongs_to_many :derecho, 
      class_name: "Sivel2Sjr::Derecho", 
      foreign_key: "id_respuesta", 
      validate: true,
      association_foreign_key: 'id_derecho',
      join_table: 'sivel2_sjr_derecho_respuesta'

    #accepts_nested_attributes_for :motivosjr_respuesta, 
    #        reject_if: :all_blank, update_only: true
    has_and_belongs_to_many :motivosjr, 
      class_name: 'Sivel2Sjr::Motivosjr', 
      foreign_key: 'id_respuesta', 
      association_foreign_key: 'id_motivosjr',
      join_table: 'sivel2_sjr_motivosjr_respuesta'

    #accepts_nested_attributes_for :progestado_respuesta, 
    #        reject_if: :all_blank, update_only: true
    has_and_belongs_to_many :progestado, 
      class_name: 'Sivel2Sjr::Progestado', 
      foreign_key: 'id_respuesta', 
      validate: true,
      association_foreign_key: 'id_progestado',
      join_table: 'sivel2_sjr_progestado_respuesta'

    validates :fechaatencion, uniqueness: {
      scope: :id_caso,
      message: 'En un caso no puede repetirse fecha de atención'
    }
  end
end
