# encoding: UTF-8

require 'sip/concerns/models/actorsocial'

module Sip
  class Actorsocial < ActiveRecord::Base
    include Sip::Concerns::Models::Actorsocial
      belongs_to :tipoactorsocial, class_name: "Sip::Tipoactorsocial",
        foreign_key: "tipoactorsocial_id", validate: true
  end
end
