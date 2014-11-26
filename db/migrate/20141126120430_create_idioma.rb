class CreateIdioma < ActiveRecord::Migration
  def up
    create_table :sivel2_sjr_idioma do |t|
      t.string :nombre, limit: 100
      t.date :fechacreacion
      t.date :fechadeshabilitacion
      t.timestamps
    end
    execute "ALTER SEQUENCE sivel2_sjr_idioma_id_seq RENAME TO idioma_seq"
    execute <<-EOF
INSERT INTO sivel2_sjr_idioma (id, nombre, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (0, 'SIN INFORMACIÓN', '2014-02-18', NULL, NULL, NULL);
INSERT INTO sivel2_sjr_idioma (id, nombre, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (1, 'ESPAÑOL', '2014-02-18', NULL, NULL, NULL);
INSERT INTO sivel2_sjr_idioma (id, nombre, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (10, 'OTRO', '2014-02-18', NULL, NULL, NULL);
INSERT INTO sivel2_sjr_idioma (id, nombre, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (2, 'INGLÉS', '2014-02-18', NULL, NULL, NULL);
INSERT INTO sivel2_sjr_idioma (id, nombre, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (3, 'FRANCÉS', '2014-02-18', NULL, NULL, NULL);
INSERT INTO sivel2_sjr_idioma (id, nombre, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (4, 'ARABE', '2014-02-18', NULL, NULL, NULL);
INSERT INTO sivel2_sjr_idioma (id, nombre, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (5, 'ALEMÁN', '2014-02-18', NULL, NULL, NULL);
INSERT INTO sivel2_sjr_idioma (id, nombre, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (6, 'PORTUGUES', '2014-02-18', NULL, NULL, NULL);
INSERT INTO sivel2_sjr_idioma (id, nombre, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (7, 'JAPONES', '2014-02-18', NULL, NULL, NULL);
INSERT INTO sivel2_sjr_idioma (id, nombre, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (8, 'CHINO', '2014-02-18', NULL, NULL, NULL);
INSERT INTO sivel2_sjr_idioma (id, nombre, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (9, 'AFRIKAN', '2014-02-18', NULL, NULL, NULL);


    EOF
  end

  def down
    drop_table :sivel2_sjr_idioma
  end
end
