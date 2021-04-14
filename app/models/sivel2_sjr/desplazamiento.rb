# encoding: UTF-8
require 'sivel2_sjr/concerns/models/desplazamiento'

class Sivel2Sjr::Desplazamiento < ActiveRecord::Base
  include Sivel2Sjr::Concerns::Models::Desplazamiento

  accesores_ubicacionpre :destino
  
  accesores_ubicacionpre :llegada
  
  accesores_ubicacionpre :expulsion

  has_and_belongs_to_many :categoria, 
    class_name: 'Sivel2Gen::Categoria',
    foreign_key: :desplazamiento_id, 
    association_foreign_key: 'categoria_id',
    join_table: 'sivel2_sjr_categoria_desplazamiento'

  belongs_to :declaracionruv,
    class_name: 'Declaracionruv', 
    foreign_key: "declaracionruv_id", 
    optional: true
  has_many :anexo_desplazamiento, foreign_key: 'desplazamiento_id', 
    validate: true, dependent: :destroy, 
    class_name: 'Sivel2Sjr::AnexoDesplazamiento',
    inverse_of: :desplazamiento
  accepts_nested_attributes_for :anexo_desplazamiento, allow_destroy: true, 
    reject_if: :all_blank
  has_many :sip_anexo, :through => :anexo_desplazamiento, 
    class_name: 'Sip::Anexo'
  accepts_nested_attributes_for :sip_anexo,  reject_if: :all_blank

  validates :tipodesp, presence: true

end

