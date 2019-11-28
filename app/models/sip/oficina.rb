# encoding: UTF-8

require 'sivel2_sjr/concerns/models/oficina'

class Sip::Oficina < ActiveRecord::Base
  include Sivel2Sjr::Concerns::Models::Oficina
  belongs_to :pais, class_name: 'Sip::Pais', foreign_key: 'pais_id', optional: true
  belongs_to :departamento, class_name: 'Sip::Departamento', 
    foreign_key: 'departamento_id', optional: true
  belongs_to :municipio, class_name: 'Sip::Municipio', 
    foreign_key: 'municipio_id', optional: true
  belongs_to :clase, class_name: 'Sip::Clase', foreign_key: 'clase_id', optional: true

end

