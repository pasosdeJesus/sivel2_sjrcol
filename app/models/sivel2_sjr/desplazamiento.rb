# encoding: UTF-8
require 'sivel2_sjr/concerns/models/desplazamiento'

class Sivel2Sjr::Desplazamiento < ActiveRecord::Base
  include Sivel2Sjr::Concerns::Models::Desplazamiento
  
  has_and_belongs_to_many :categoria, 
    class_name: 'Sivel2Gen::Categoria',
    foreign_key: :desplazamiento_id, 
    association_foreign_key: 'categoria_id',
    join_table: 'sivel2_sjr_categoria_desplazamiento'

  validates :tipodesp, presence: true
end

