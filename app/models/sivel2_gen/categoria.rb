# encoding: UTF-8
require 'sivel2_sjr/concerns/models/categoria'

class Sivel2Gen::Categoria < ActiveRecord::Base
  include Sivel2Sjr::Concerns::Models::Categoria
  
  has_and_belongs_to_many :desplazamiento, 
    class_name: 'Sivel2Sjr::Desplazamiento',
    foreign_key: :categoria_id, 
    association_foreign_key: "desplazamiento_id",
    join_table: 'sivel2_sjr_categoria_desplazamiento'

  has_many :causa_refugio, 
    class_name: 'Sivel2Sjr::Migracion',
    foreign_key: :causa_refugio_id

end

