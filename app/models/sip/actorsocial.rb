# encoding: UTF-8

require 'sip/concerns/models/actorsocial'

module Sip
  class Actorsocial < ActiveRecord::Base
    include Sip::Concerns::Models::Actorsocial
      belongs_to :departamento, class_name: "Sip::Departamento",
        foreign_key: "departamento_id", validate: true
      belongs_to :lineaactorsocial, class_name: "Sip::Tipoactorsocial",
        foreign_key: "lineaactorsocial_id", validate: true
      belongs_to :municipio, class_name: "Sip::Municipio",
        foreign_key: "municipio_id", validate: true
      belongs_to :tipoactorsocial, class_name: "Sip::Tipoactorsocial",
        foreign_key: "tipoactorsocial_id", validate: true
      

      validates :tipoactorsocial_id, presence: true
      validates :nit, uniqueness: true
  end
end
