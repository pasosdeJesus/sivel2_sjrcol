class AgregaCausaagresionenpaisAMigracion < ActiveRecord::Migration[6.0]
  def change
    create_table :sivel2_sjr_causaagrpais_migracion, id: false do |t|
      t.integer :causaagrpais_id
      t.integer :migracion_id
      t.index :causaagrpais_id
      t.index :migracion_id
    end
    add_foreign_key :sivel2_sjr_causaagrpais_migracion, 
      :causaagresion, column: :causaagrpais_id
    add_foreign_key :sivel2_sjr_causaagrpais_migracion, 
      :sivel2_sjr_migracion, column: :migracion_id
  end
end
