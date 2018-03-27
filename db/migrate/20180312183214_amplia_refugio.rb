class AmpliaRefugio < ActiveRecord::Migration[5.1]
  def change
    add_column :sivel2_sjr_casosjr, :estatus_refugio, :string, limit: 5000
    add_column :sivel2_sjr_casosjr, :fechadecrefugio, :date
    add_column :sivel2_sjr_casosjr, :docrefugiado, :string, limit: 128
  end
end
