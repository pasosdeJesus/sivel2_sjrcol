class AgregaMigracion < ActiveRecord::Migration[5.1]
  def change
    add_column :sivel2_sjr_casosjr, :fechasalidam, :date
    add_column :sivel2_sjr_casosjr, :id_salidam, :integer
    add_column :sivel2_sjr_casosjr, :fechallegadam, :date
    add_column :sivel2_sjr_casosjr, :id_llegadam, :integer
    add_column :sivel2_sjr_casosjr, :motivom, :string, limit: 5000
    add_foreign_key :sivel2_sjr_casosjr, :sip_ubicacion, column: :id_salidam
    add_foreign_key :sivel2_sjr_casosjr, :sip_ubicacion, column: :id_llegadam
  end
end
