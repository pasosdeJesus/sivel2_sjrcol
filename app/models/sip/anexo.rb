# encoding: UTF-8

require 'sivel2_gen/concerns/models/anexo'

module Sip
  class Anexo < ActiveRecord::Base
    include Sivel2Gen::Concerns::Models::Anexo

          has_many :anexo_victima, foreign_key: "anexo_id", 
            validate: true, class_name: 'Sivel2Gen::AnexoVictima'
          has_many :victima, class_name: 'Sivel2Gen::Victima',
            through: :anexo_victima
          has_many :anexo_desplazamiento, foreign_key: "anexo_id", 
            validate: true, class_name: 'Sivel2Sjr::AnexoDesplazamiento'
          has_many :desplazamiento, class_name: 'Sivel2Sjr::Desplazamiento',
            through: :anexo_desplazamiento
  end
end
