class AgregaAgresionmigracionAMigracion < ActiveRecord::Migration[6.0]
  def change
    create_table :sivel2_sjr_agremigracion_migracion, id: false do |t|
      t.integer :agremigracion_id
      t.integer :migracion_id
      t.index :agremigracion_id
      t.index :migracion_id
    end
    add_foreign_key :sivel2_sjr_agremigracion_migracion, 
      :agresionmigracion, column: :agremigracion_id
    add_foreign_key :sivel2_sjr_agremigracion_migracion, 
      :sivel2_sjr_migracion, column: :migracion_id
  end
end
