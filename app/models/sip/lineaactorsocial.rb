# encoding: UTF-8

module Sip
  class Lineaactorsocial < ActiveRecord::Base
    include Sip::Basica
    has_many :actorsocial, class_name: "Sip::Actorsocial",
      foreign_key: "lineaactorsocial_id", validate: true 
  end
end
