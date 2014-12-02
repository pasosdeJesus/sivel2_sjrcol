# encoding: UTF-8
Sivel2Sjr::Derecho.class_eval do

  has_many :aslegal, class_name: 'Sivel2Sjr::Aslegal', foreign_key: "derecho_id"
  has_many :ayudaestado, class_name: 'Sivel2Sjr::Ayudaestado', foreign_key: "derecho_id"
  has_many :ayudasjr, class_name: 'Sivel2Sjr::Ayudasjr', foreign_key: "derecho_id"
  has_many :motivosjr, class_name: 'Sivel2Sjr::Motivosjr', foreign_key: "derecho_id"
  has_many :progestado, class_name: 'Sivel2Sjr::Progestado', foreign_key: "derecho_id"
  has_many :respuesta, :through => :derecho_respuesta

end
