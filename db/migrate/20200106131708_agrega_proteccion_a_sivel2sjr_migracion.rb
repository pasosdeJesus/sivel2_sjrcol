class AgregaProteccionASivel2sjrMigracion < ActiveRecord::Migration[6.0]
  def change
    add_column :sivel2_sjr_migracion, :proteccion, :string
  end
end