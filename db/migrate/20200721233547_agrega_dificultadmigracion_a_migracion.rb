class AgregaDificultadmigracionAMigracion < ActiveRecord::Migration[6.0]
  def change
    create_table :sivel2_sjr_difmigracion_migracion, id: false do |t|
      t.integer :difmigracion_id
      t.integer :migracion_id
      t.index :difmigracion_id
      t.index :migracion_id
    end
    add_foreign_key :sivel2_sjr_difmigracion_migracion, 
      :dificultadmigracion, column: :difmigracion_id
    add_foreign_key :sivel2_sjr_difmigracion_migracion, 
      :sivel2_sjr_migracion, column: :migracion_id
  end
end
