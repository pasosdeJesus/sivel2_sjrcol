class CreateProteccion < ActiveRecord::Migration
  def up
    create_table :proteccion do |t|
      t.string :nombre, limit: 100
      t.date :fechacreacion
      t.date :fechadeshabilitacion
      t.timestamps
    end
    execute "ALTER SEQUENCE proteccion_id_seq RENAME TO proteccion_seq"
    execute <<-SQL
INSERT INTO proteccion (id, nombre, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (0, 'SIN INFORMACIÓN', '2014-02-16', NULL, NULL, NULL);
INSERT INTO proteccion (id, nombre, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (1, 'SOLICITANTE DE REFUGIO', '2014-02-16', NULL, NULL, NULL);
INSERT INTO proteccion (id, nombre, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (2, 'PROTECCIÓN TEMPORAL HUMANITARIA', '2014-02-16', NULL, NULL, NULL);
INSERT INTO proteccion (id, nombre, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (3, 'TRATA Y TRÁFICO', '2014-02-16', NULL, NULL, NULL);
INSERT INTO proteccion (id, nombre, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (4, 'NO RECONOCIDOS', '2014-02-16', NULL, NULL, NULL);
INSERT INTO proteccion (id, nombre, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (5, 'NO ESPECÍFICA', '2014-02-16', NULL, NULL, NULL);
INSERT INTO proteccion (id, nombre, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (6, 'PERSONA CON NECESIDAD DE PROTECCIÓN TEMPORAL', '2014-02-16', NULL, NULL, NULL);
INSERT INTO proteccion (id, nombre, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (7, 'OTRO', '2014-02-16', NULL, NULL, NULL);
INSERT INTO proteccion (id, nombre, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (8, 'PERSONA EN SITUACIÓN DE REFUGIO', '2014-03-10', NULL, NULL, NULL);
    SQL
  end

  def down
    drop_table :proteccion
  end
end
