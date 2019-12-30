class AgregaStatusmigratorioMigracion < ActiveRecord::Migration[6.0]
  def change

    add_column :sivel2_sjr_migracion, :statusmigratorio_id, :integer
    add_foreign_key :sivel2_sjr_migracion, :sivel2_sjr_statusmigratorio, 
      column: :statusmigratorio_id
  end
end
