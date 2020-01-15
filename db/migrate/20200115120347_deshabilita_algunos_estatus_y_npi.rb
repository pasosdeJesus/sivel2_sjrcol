class DeshabilitaAlgunosEstatusYNpi < ActiveRecord::Migration[6.0]
  def up
    execute <<-SQL
      UPDATE sivel2_sjr_statusmigratorio SET
        fechadeshabilitacion='2020-01-15' WHERE id IN 
        (2, 4, 0);
      UPDATE sivel2_sjr_proteccion SET
        fechadeshabilitacion='2020-01-15' WHERE id IN 
        (2, 0);
    SQL
  end
  def down
    execute <<-SQL
      UPDATE sivel2_sjr_statusmigratorio SET
        fechadeshabilitacion=NULL WHERE id IN 
        (2, 4, 0);
      UPDATE sivel2_sjr_proteccion SET
        fechadeshabilitacion=NULL WHERE id IN 
        (2, 0);
    SQL
  end
end
