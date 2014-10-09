# encoding: UTF-8
class Aslegal < ActiveRecord::Base
  extend Basica

  belongs_to :derecho
	has_many :aslegal_respuesta, class_name: 'AslegalRespuesta', 
    foreign_key: "id_aslegal", validate: true, dependent: :destroy
  has_many :respuesta, :through => :aslegal_respuesta

  validates :derecho_id, presence: true, allow_blank: false
  validates :nombre, presence: true, allow_blank: false
  validates :fechacreacion, presence: true, allow_blank: false
end
