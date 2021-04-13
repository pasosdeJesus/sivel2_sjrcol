# encoding: UTF-8

require 'sivel2_sjr/concerns/models/acto'

class Sivel2Gen::Acto < ActiveRecord::Base
  include Sivel2Sjr::Concerns::Models::Acto

  has_one :actosjr, class_name: 'Sivel2Sjr::Actosjr',
    foreign_key: "id_acto", dependent: :delete, inverse_of: :acto
  accepts_nested_attributes_for :actosjr

end

