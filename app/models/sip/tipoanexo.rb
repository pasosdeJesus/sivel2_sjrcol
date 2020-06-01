# encoding: UTF-8

require 'sivel2_gen/concerns/models/anexo'

module Sip
  class Tipoanexo < ActiveRecord::Base
    include Sip::Basica
    
    has_many :anexo_victima, foreign_key: "tipoanexo_id", 
      validate: true, class_name: 'Sivel2Gen::AnexoVictima'
    has_many :victima, class_name: 'Sivel2Gen::Victima',
      through: :anexo_victima
  end
end
