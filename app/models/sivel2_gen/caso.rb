# encoding: UTF-8

require 'sivel2_sjr/concerns/models/caso'
class Sivel2Gen::Caso < ActiveRecord::Base
  include Sivel2Sjr::Concerns::Models::Caso

  has_many :migracion, class_name: 'Sivel2Sjr::Migracion',
    foreign_key: "caso_id", validate: true, dependent: :destroy
  accepts_nested_attributes_for :migracion, allow_destroy: true, 
    reject_if: :all_blank
end

