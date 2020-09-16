class AgregaUbicacionpreActividad < ActiveRecord::Migration[6.0]
  def change
    add_column :cor1440_gen_actividad, :ubicacionpre_id, :integer
    add_foreign_key :cor1440_gen_actividad, :sip_ubicacionpre, column: :ubicacionpre_id
  end
end
