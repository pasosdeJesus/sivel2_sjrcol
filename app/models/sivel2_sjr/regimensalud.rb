# encoding: UTF-8
module Sivel2Sjr
  class Regimensalud < ActiveRecord::Base
    include Sip::Basica

    has_many :victimasjr, class_name: 'Sivel2Sjr::Victimasjr',
      foreign_key: "id_regimensalud", validate: true
  end
end
