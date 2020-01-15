class OrtografiaYMezclasNpi < ActiveRecord::Migration[6.0]
  def up
    execute <<-SQL
      --Mezcla 2 en 6
      UPDATE sivel2_sjr_migracion SET 
        proteccion_id=6 WHERE proteccion_id=2;
      -- Ortografia
      UPDATE sivel2_sjr_proteccion SET
        nombre='APÁTRIDA' where nombre='APATRIDA';
      UPDATE sivel2_sjr_proteccion SET
        nombre='APÁTRIDA' where nombre='APATRIDA';
      UPDATE sivel2_sjr_proteccion SET
        nombre='EN RIESGO DE APÁTRIDA' where nombre='EN RIESGO DE APATRIDA';

    SQL
  end
  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
