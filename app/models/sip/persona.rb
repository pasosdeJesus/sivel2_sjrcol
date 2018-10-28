# encoding: UTF-8

require 'sivel2_sjr/concerns/models/persona'

module Sip
  class Persona < ActiveRecord::Base
    include Sip::Modelo
    include Sivel2Sjr::Concerns::Models::Persona
  
    has_one :datosbio, class_name: 'Sip::Datosbio', 
      foreign_key: 'persona_id'
    accepts_nested_attributes_for :datosbio, reject_if: :all_blank

  end
end

