class AgregaAutoridadrefugioAMigracion < ActiveRecord::Migration[6.0]
  def change
    add_column :sivel2_sjr_migracion, :autoridadrefugio_id, :integer
    add_foreign_key :sivel2_sjr_migracion, :autoridadrefugio, column: :autoridadrefugio_id
  end
end
