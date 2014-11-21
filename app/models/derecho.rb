# encoding: UTF-8
class Derecho < ActiveRecord::Base
  include Basica

  has_many :aslegal, class_name: 'Aslegal', foreign_key: "derecho_id"
  has_many :ayudaestado, class_name: 'Ayudaestado', foreign_key: "derecho_id"
  has_many :ayudasjr, class_name: 'Ayudasjr', foreign_key: "derecho_id"
	has_many :derecho_respuesta, class_name: 'DerechoRespuesta',  
    foreign_key: "id_derecho", validate: true, dependent: :destroy
	has_many :derecho_procesosjr, foreign_key: "id_derecho", validate: true
  has_many :motivosjr, class_name: 'Motivosjr', foreign_key: "derecho_id"
  has_many :progestado, class_name: 'Progestado', foreign_key: "derecho_id"
  has_many :respuesta, :through => :derecho_respuesta

  validates :nombre, presence: true, allow_blank: false
  validates :fechacreacion, presence: true, allow_blank: false
end
