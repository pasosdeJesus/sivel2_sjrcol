class AgregaUbicacionpreAMigracion < ActiveRecord::Migration[6.1]
  def change
    add_column :sivel2_sjr_migracion, :salidaubicacionpre_id, :integer
    add_foreign_key :sivel2_sjr_migracion, :sip_ubicacionpre, column: :salidaubicacionpre_id
  end
end
