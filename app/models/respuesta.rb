# encoding: UTF-8
class Respuesta < ActiveRecord::Base

  # Debería ser: belongs_to :casosjr, foreign_key: "id_caso", validate: true
  belongs_to :caso, foreign_key: "id_caso", validate: true

  has_many :aslegal, :through => :aslegal_respuesta
  has_many :aslegal_respuesta,  foreign_key: "id_respuesta", 
    dependent: :destroy, validate: true
  accepts_nested_attributes_for :aslegal_respuesta, 
    reject_if: :all_blank, update_only: true

  has_many :ayudaestado, :through => :ayudaestado_respuesta
  has_many :ayudaestado_respuesta,  foreign_key: "id_respuesta", 
    dependent: :destroy, validate: true
  accepts_nested_attributes_for :ayudaestado_respuesta, 
    reject_if: :all_blank, update_only: true

  has_many :ayudasjr, :through => :ayudasjr_respuesta
  has_many :ayudasjr_respuesta,  foreign_key: "id_respuesta", 
    dependent: :destroy
  # didn't work either: accepts_nested_attributes_for :ayudasjr_respuesta, reject_if: :all_blank, update_only: true

  has_many :derecho, :through => :derecho_respuesta
  has_many :derecho_respuesta,  foreign_key: "id_respuesta", 
    dependent: :destroy, validate: true
  accepts_nested_attributes_for :derecho_respuesta, reject_if: :all_blank, 
    update_only: true

  has_many :motivosjr, :through => :motivosjr_respuesta
  has_many :motivosjr_respuesta,  foreign_key: "id_respuesta", 
    dependent: :destroy
  accepts_nested_attributes_for :motivosjr_respuesta, 
    reject_if: :all_blank, update_only: true

  has_many :progestado, :through => :progestado_respuesta
  has_many :progestado_respuesta,  foreign_key: "id_respuesta", 
    dependent: :destroy, validate: true
  accepts_nested_attributes_for :progestado_respuesta, 
    reject_if: :all_blank, update_only: true

end
