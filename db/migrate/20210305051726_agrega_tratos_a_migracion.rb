class AgregaTratosAMigracion < ActiveRecord::Migration[6.1]
  def change
    add_column :sivel2_sjr_migracion, :tratoauto, :string, limit: 5000
    add_column :sivel2_sjr_migracion, :tratoresi, :string, limit: 5000
  end
end
