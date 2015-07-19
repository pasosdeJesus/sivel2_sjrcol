class ActualizaBasicas < ActiveRecord::Migration
  def up
    execute <<-SQL
INSERT INTO cor1440_gen_actividadtipo (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (1, 'ORGANIZACIÓN DE ACTIVIDAD DE FORMACIÓN', '', '2015-04-17', NULL, '2015-04-17 21:47:31.920052', '2015-04-17 21:47:31.920052');
INSERT INTO cor1440_gen_actividadtipo (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (10, 'ORGANIZACIÓN DE CAMPAÑA', '', '2015-04-18', NULL, '2015-04-18 10:58:02.08154', '2015-04-18 10:58:02.08154');
INSERT INTO cor1440_gen_actividadtipo (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (11, 'MISIÓN HUMANITARIA', '', '2015-04-18', NULL, '2015-04-18 10:58:22.231407', '2015-04-18 10:58:22.231407');
INSERT INTO cor1440_gen_actividadtipo (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (12, 'SEGUIMIENTO A CASO', '', '2015-04-18', NULL, '2015-04-18 10:58:52.741712', '2015-04-18 10:58:52.741712');
INSERT INTO cor1440_gen_actividadtipo (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (13, 'SEGUIMIENTO A PLANEACIÓN,', '', '2015-04-18', NULL, '2015-04-18 10:59:06.40352', '2015-04-18 10:59:06.40352');
INSERT INTO cor1440_gen_actividadtipo (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (14, 'SEGUIMIENTO A PROYECTO', '', '2015-04-18', NULL, '2015-04-18 10:59:21.721801', '2015-04-18 10:59:21.721801');
INSERT INTO cor1440_gen_actividadtipo (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (15, 'VISITA TÉCNICA', '', '2015-04-18', NULL, '2015-04-18 10:59:42.391942', '2015-04-18 10:59:42.391942');
INSERT INTO cor1440_gen_actividadtipo (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (2, 'PARTICIPACIÓN EN ACTIVIDAD DE FORMACIÓN', '', '2015-04-17', NULL, '2015-04-17 21:52:35.802212', '2015-04-17 21:52:35.802212');
INSERT INTO cor1440_gen_actividadtipo (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (3, 'PARTICIPACIÓN EN REUNIÓN', '', '2015-04-17', NULL, '2015-04-17 21:52:48.803678', '2015-04-17 21:52:48.803678');
INSERT INTO cor1440_gen_actividadtipo (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (4, 'PARTICIPACIÓN EN REUNIÓN ESTRATÉGICA', '', '2015-04-17', NULL, '2015-04-17 21:53:01.021493', '2015-04-17 21:53:01.021493');
INSERT INTO cor1440_gen_actividadtipo (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (5, 'PRESENTACIÓN DE PONENCIA EN EVENTO', '', '2015-04-17', NULL, '2015-04-17 21:53:13.22205', '2015-04-17 21:53:13.22205');
INSERT INTO cor1440_gen_actividadtipo (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (6, 'MONITOREO, SUPERVISIÓN, EVALUACIÓN', '', '2015-04-17', NULL, '2015-04-17 21:53:26.363204', '2015-04-18 11:01:13.499746');
INSERT INTO cor1440_gen_actividadtipo (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (7, 'ORGANIZACIÓN DE EVENTO', '', '2015-04-18', NULL, '2015-04-18 10:54:24.247319', '2015-04-18 10:54:24.247319');
INSERT INTO cor1440_gen_actividadtipo (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (8, 'RESPUESTA A SOLICITUD DE INFORMACIÓN', '', '2015-04-18', NULL, '2015-04-18 10:56:01.181889', '2015-04-18 11:00:33.221088');
INSERT INTO cor1440_gen_actividadtipo (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (9, 'ORGANIZACIÓN DE ACTIVIDAD CULTURAL/ARTÍSTICA', '', '2015-04-18', NULL, '2015-04-18 10:57:38.55163', '2015-04-18 11:00:02.131731');
INSERT INTO cor1440_gen_actividadtipo (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (16, 'ATENCIÒN A CASO NUEVO', '', '2015-04-18', NULL, '2015-04-18 10:57:38.55163', '2015-04-18 11:00:02.131731');
INSERT INTO cor1440_gen_actividadtipo (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (17, 'ACCIÓN COLECTIVA', '', '2015-04-18', NULL, '2015-04-18 10:57:38.55163', '2015-04-18 11:00:02.131731');
INSERT INTO cor1440_gen_actividadtipo (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (18, 'ATENCIÓN JURÍDICA', '', '2015-04-18', NULL, '2015-04-18 10:57:38.55163', '2015-04-18 11:00:02.131731');
INSERT INTO cor1440_gen_actividadtipo (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (19, 'INFORMACIÒN Y ORIENTACIÓN', '', '2015-04-18', NULL, '2015-04-18 10:57:38.55163', '2015-04-18 11:00:02.131731');
INSERT INTO cor1440_gen_actividadtipo (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (20, 'ATENCIÓN PSICOSOCIAL', '', '2015-04-18', NULL, '2015-04-18 10:57:38.55163', '2015-04-18 11:00:02.131731');
    SQL
  end
  def down
    execute <<-SQL
DELETE FROM cor1440_gen_actividadtipo;
    SQL
  end
end
