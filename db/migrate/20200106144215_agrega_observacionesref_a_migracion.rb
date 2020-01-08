class AgregaObservacionesrefAMigracion < ActiveRecord::Migration[6.0]
  def change
    add_column :sivel2_sjr_migracion, :observacionesref, :string, limit: 5000 
  end
end
