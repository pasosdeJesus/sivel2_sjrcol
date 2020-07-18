class AgregaCausamigracionAMigracion < ActiveRecord::Migration[6.0]
  def change
    add_column :sivel2_sjr_migracion, :causamigracion_id, :integer
    add_foreign_key :sivel2_sjr_migracion, :causamigracion, column: :causamigracion_id
  end
end
