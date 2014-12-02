# encoding: UTF-8

Sivel2Sjr::Aslegal.class_eval do

  belongs_to :derecho

  validates :derecho_id, presence: true, allow_blank: false
end
