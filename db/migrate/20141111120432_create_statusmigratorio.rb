class CreateStatusmigratorio < ActiveRecord::Migration
  def up
    create_table :statusmigratorio do |t|
      t.string :nombre, limit: 100
      t.date :fechacreacion
      t.date :fechadeshabilitacion
      t.timestamps
    end
    execute "ALTER SEQUENCE statusmigratorio_id_seq RENAME TO statusmigratorio_seq"
    execute <<-SQL
INSERT INTO statusmigratorio (id, nombre, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (0, 'SIN INFORMACIÓN', '2014-02-16', NULL, NULL, NULL);
INSERT INTO statusmigratorio (id, nombre, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (1, 'MIGRANTE', '2014-02-16', NULL, NULL, NULL);
INSERT INTO statusmigratorio (id, nombre, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (2, 'REFUGIADO', '2014-02-16', NULL, NULL, NULL);
INSERT INTO statusmigratorio (id, nombre, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (4, 'APÁTRIDA', '2014-02-16', NULL, NULL, NULL);
INSERT INTO statusmigratorio (id, nombre, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (5, 'NACIONAL POR NACIMIENTO', '2014-03-10', NULL, NULL, NULL);
INSERT INTO statusmigratorio (id, nombre, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (6, 'NACIONAL POR NATURALIZACIÓN', '2014-03-10', NULL, NULL, NULL);
    SQL
  end

  def down
    drop_table :statusmigratorio
  end
end
