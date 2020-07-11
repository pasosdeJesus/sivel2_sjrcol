class AgregaViadeingresoAMigracion < ActiveRecord::Migration[6.0]
  def change
    add_column :sivel2_sjr_migracion, :viadeingreso_id, :integer
    add_foreign_key :sivel2_sjr_migracion, :viadeingreso, column: :viadeingreso_id
  end
end
