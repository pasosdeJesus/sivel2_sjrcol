class AgregacamposStatusmigratorio < ActiveRecord::Migration[6.0]
  def up
    execute <<-SQL
INSERT INTO sivel2_sjr_statusmigratorio (id, nombre, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (7, 'IRREGULAR', '2020-01-05', NULL, NULL, NULL);
INSERT INTO sivel2_sjr_statusmigratorio (id, nombre, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (8, 'EN PROCESO DE REGULARIZACIÓN', '2020-01-05', NULL, NULL, NULL);
UPDATE sivel2_sjr_statusmigratorio SET nombre = 'REGULAR MIGRANTE' WHERE ID=1;
UPDATE sivel2_sjr_statusmigratorio SET nombre = 'REGULAR NACIONAL POR NACIMIENTO' WHERE ID=5;
UPDATE sivel2_sjr_statusmigratorio SET nombre = 'REGULAR NACIONAL POR NATURALIZACIÓN' WHERE ID=6;
    SQL
  end
end
