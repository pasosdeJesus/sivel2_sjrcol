class EliminaProteccionMigracion < ActiveRecord::Migration[6.0]
  def change
    remove_column :sivel2_sjr_migracion, :proteccion, :string
  end
end
