# encoding: UTF-8
require 'sivel2_sjr/concerns/models/desplazamiento'

class Sivel2Sjr::Desplazamiento < ActiveRecord::Base
  include Sivel2Sjr::Concerns::Models::Desplazamiento
  
  has_many :categoria_desplazamiento, 
    class_name: "Sivel2Sjr::CategoriaDesplazamiento",  
    foreign_key: :desplazamiento_id, 
    dependent: :delete_all
  has_many :categoria, 
    through: :categoria_desplazamiento,
    class_name: "Sivel2Gen::Categoria"

end

