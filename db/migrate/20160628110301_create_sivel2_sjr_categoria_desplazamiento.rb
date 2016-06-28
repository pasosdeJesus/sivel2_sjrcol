# encoding: UTF-8

class CreateSivel2SjrCategoriaDesplazamiento < ActiveRecord::Migration
  def change
    create_join_table :categoria, :desplazamiento, {
      table_name: 'sivel2_sjr_categoria_desplazamiento' 
    }
    add_foreign_key :sivel2_sjr_categoria_desplazamiento, 
      :sivel2_gen_categoria, column: :categoria_id
    add_foreign_key :sivel2_sjr_categoria_desplazamiento, 
      :sivel2_sjr_desplazamiento, column: :desplazamiento_id
  end
end
