# encoding: UTF-8

require 'date'
require 'sivel2_sjr/concerns/models/persona'

module Sip
  class Persona < ActiveRecord::Base
    include Sip::Modelo
    include Sivel2Sjr::Concerns::Models::Persona
 
    has_many :detallefinanciero_persona,
      dependent: :delete_all,
      class_name: '::DetallefinancieroPersona',
      foreign_key: 'persona_id'

    has_many :detallefinanciero,
      class_name: '::Detallefinanciero', 
      through: 'detallefinanciero_persona'

    has_one :datosbio, class_name: 'Sip::Datosbio', 
      foreign_key: 'persona_id', dependent: :delete
    accepts_nested_attributes_for :datosbio, reject_if: :all_blank

    validates :numerodocumento, :allow_blank => true, uniqueness: {message: "Documento de identidad ya registrado"}

    attr_accessor :fechanac
    def fechanac
      return Date.new(anionac && anionac > 0 ? anionac : 1900,
                  mesnac && mesnac > 0 && mesnac < 13 ? mesnac : 6,
                  dianac && dianac > 0 && dianac < 32 ? dianac : 15)
    end

    def fechanac=(valc)
      val = fecha_local_estandar valc
      p = val.split('-')
      self.anionac = p[0].to_i
      self.mesnac = p[1].to_i
      self.dianac = p[2].to_i
    end

    # Debe corresponder con la funcion @jrs_persona_presenta_nombre de 
    # app/assets/javascripts/actividad.js.coffee
    def presenta_nombre
      ip = numerodocumento ? numerodocumento : ''
      if tdocumento && tdocumento.sigla
        ip = tdocumento.sigla + ":" + ip
      end
      r = nombres + " " + apellidos + 
        " (" + ip + ")"
      return r
    end

  end
end

