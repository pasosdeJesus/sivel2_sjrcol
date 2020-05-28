# encoding: UTF-8

require 'sivel2_gen/concerns/models/victima'

class Sivel2Sjr::Victima < ActiveRecord::Base
  include Sivel2Gen::Concerns::Models::Victima

  has_many :anexo_victima, foreign_key: 'id_victima', validate: true, dependent: :destroy, class_name: 'Sivel2Gen::AnexoVictima',
    inverse_of: :victima
  has_many :sip_anexo, :through => :anexo_victima, 
    class_name: 'Sip::Anexo'

  accepts_nested_attributes_for :anexo_victima, reject_if: :all_blank,
    update_only: true

end
