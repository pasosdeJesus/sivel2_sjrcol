class ActualizaNombreRefugiado < ActiveRecord::Migration[6.0]
  def up
    execute <<-SQL
UPDATE sivel2_sjr_proteccion SET nombre = 'REFUGIADO' WHERE ID=8;
    SQL
  end
end
