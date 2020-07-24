class AgregaCausaagresionAMigracion < ActiveRecord::Migration[6.0]
  def change
    create_table :sivel2_sjr_causaagresion_migracion, id: false do |t|
      t.integer :causaagresion_id
      t.integer :migracion_id
      t.index :causaagresion_id
      t.index :migracion_id
    end
    add_foreign_key :sivel2_sjr_causaagresion_migracion, 
      :causaagresion, column: :causaagresion_id
    add_foreign_key :sivel2_sjr_causaagresion_migracion, 
      :sivel2_sjr_migracion, column: :migracion_id
  end
end
