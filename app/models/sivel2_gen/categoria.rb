# encoding: UTF-8
require 'sivel2_sjr/concerns/models/categoria'

class Sivel2Gen::Categoria < ActiveRecord::Base
  include Sivel2Sjr::Concerns::Models::Categoria
  
  has_many :categoria_desplazamiento, 
    class_name: "Sivel2Sjr::CategoriaDesplazamiento",  
    foreign_key: :categoria_id, 
    dependent: :delete_all
  has_many :desplazamiento, 
    through: :categoria_desplazamiento,
    class_name: "Sivel2Sjr::Desplazamiento"

end

