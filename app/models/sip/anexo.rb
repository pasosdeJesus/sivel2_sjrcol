# encoding: UTF-8

require 'sivel2_gen/concerns/models/anexo'

module Sip
  class Anexo < ActiveRecord::Base
    include Sivel2Gen::Concerns::Models::Anexo

          has_many :anexo_victima, foreign_key: "anexo_id", 
            validate: true, class_name: 'Sivel2Gen::AnexoVictima'
          has_many :victima, class_name: 'Sivel2Gen::Victima',
            through: :anexo_victima
  end
end
