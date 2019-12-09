class AgregaSalvoNpiASivel2SjrMigracion < ActiveRecord::Migration[6.0]
  def change
    add_column :sivel2_sjr_migracion, :salvoNpi, :string, limit: 127
  end
end
