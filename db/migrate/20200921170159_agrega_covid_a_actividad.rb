class AgregaCovidAActividad < ActiveRecord::Migration[6.0]
  def change
    add_column :cor1440_gen_actividad, :covid, :boolean
  end
end
