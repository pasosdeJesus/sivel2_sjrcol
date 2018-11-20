# encoding: UTF-8

require 'date'
require 'sivel2_sjr/concerns/models/persona'

module Sip
  class Persona < ActiveRecord::Base
    include Sip::Modelo
    include Sivel2Sjr::Concerns::Models::Persona
  
    has_one :datosbio, class_name: 'Sip::Datosbio', 
      foreign_key: 'persona_id'
    accepts_nested_attributes_for :datosbio, reject_if: :all_blank
    validates :numerodocumento, presence: true

    attr_accessor :fechanac
    def fechanac
      return Date.new(anionac ? anionac : 1900,
                  mesnac ? mesnac : 6,
                  dianac ? dianac : 15)
    end

    def fechanac=(valc)
      val = fecha_local_estandar valc
      p = val.split('-')
      self.anionac = p[0].to_i
      self.mesnac = p[1].to_i
      self.dianac = p[2].to_i
    end

  end
end

