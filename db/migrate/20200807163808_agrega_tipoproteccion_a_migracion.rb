class AgregaTipoproteccionAMigracion < ActiveRecord::Migration[6.0]
  def change
    add_column :sivel2_sjr_migracion, :tipoproteccion_id, :integer
    add_foreign_key :sivel2_sjr_migracion, :tipoproteccion, column: :tipoproteccion_id
  end
end
