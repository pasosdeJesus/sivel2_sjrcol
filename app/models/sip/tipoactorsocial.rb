# encoding: UTF-8

module Sip
  class Tipoactorsocial < ActiveRecord::Base
    include Sip::Basica
    has_many :actorsocial, class_name: "Sip::Actorsocial",
      foreign_key: "tipoactorsocial_id", validate: true
  end
end
