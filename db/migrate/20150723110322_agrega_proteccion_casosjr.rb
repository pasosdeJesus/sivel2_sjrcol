class AgregaProteccionCasosjr < ActiveRecord::Migration
  def change
    add_column :sivel2_sjr_casosjr, :id_proteccion, :integer
    add_foreign_key :sivel2_sjr_casosjr,
      :sivel2_sjr_proteccion, column: :id_proteccion
    add_column :sivel2_sjr_casosjr, :id_statusmigratorio, :integer
    add_foreign_key :sivel2_sjr_casosjr,
      :sivel2_sjr_statusmigratorio, column: :id_statusmigratorio
  end
end
