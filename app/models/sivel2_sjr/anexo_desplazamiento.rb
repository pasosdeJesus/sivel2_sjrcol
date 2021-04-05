# encoding: UTF-8

module Sivel2Sjr
  class AnexoDesplazamiento < ActiveRecord::Base

    include Sip::Localizacion
    include Sip::FormatoFechaHelper

    belongs_to :desplazamiento, foreign_key: "desplazamiento_id", validate: true, 
      class_name: "Sivel2Sjr::Desplazamiento", inverse_of: :anexo_desplazamiento
    belongs_to :sip_anexo, foreign_key: "anexo_id", validate: true, 
      class_name: "Sip::Anexo"
    accepts_nested_attributes_for :sip_anexo, reject_if: :all_blank


    campofecha_localizado :fecha

    validates :desplazamiento, presence: true
    validates :sip_anexo, presence: true
    validates :fecha, presence: true
  end
end
