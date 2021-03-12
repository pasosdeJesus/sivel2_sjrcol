class AgregaUbicacionpreALlegmigracion < ActiveRecord::Migration[6.1]
  def change
    add_column :sivel2_sjr_migracion, :llegadaubicacionpre_id, :integer
    add_foreign_key :sivel2_sjr_migracion, :sip_ubicacionpre, column: :llegadaubicacionpre_id
  end
end
