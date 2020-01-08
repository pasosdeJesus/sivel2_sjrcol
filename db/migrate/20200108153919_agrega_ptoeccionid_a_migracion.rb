class AgregaPtoeccionidAMigracion < ActiveRecord::Migration[6.0]
  def change
    add_column :sivel2_sjr_migracion, :proteccion_id, :integer
    add_foreign_key :sivel2_sjr_migracion, :sivel2_sjr_proteccion,
      column: :proteccion_id
  end
end
