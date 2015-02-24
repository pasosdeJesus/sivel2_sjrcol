class Agregaaslegal < ActiveRecord::Migration
  def up
    execute <<-SQL
INSERT INTO sivel2_sjr_aslegal (id, nombre, fechacreacion, fechadeshabilitacion, created_at, updated_at, derecho_id) VALUES (0, 'SIN INFORMACIÓN', '2014-02-14', NULL, NULL, NULL, NULL);
INSERT INTO sivel2_sjr_aslegal (id, nombre, fechacreacion, fechadeshabilitacion, created_at, updated_at, derecho_id) VALUES (1, 'RENUNCIA AL PROCEDIMIENTO DE SOLICITUD DE REFUGIO: TIPO Y MOTIVOS', '2014-02-14', NULL, NULL, '2014-08-04 14:29:09.190492', NULL);
INSERT INTO sivel2_sjr_aslegal (id, nombre, fechacreacion, fechadeshabilitacion, created_at, updated_at, derecho_id) VALUES (10, 'ASESORÍA SOBRE TRÁMITES DE NATURALIZACIÓN', '2014-02-14', NULL, NULL, '2014-08-04 14:27:04.064535', NULL);
INSERT INTO sivel2_sjr_aslegal (id, nombre, fechacreacion, fechadeshabilitacion, created_at, updated_at, derecho_id) VALUES (11, 'APERTURA EXPEDIENTE SOLICITUD DE REFUGIO', '2014-02-14', NULL, NULL, '2014-08-04 14:26:02.056113', NULL);
INSERT INTO sivel2_sjr_aslegal (id, nombre, fechacreacion, fechadeshabilitacion, created_at, updated_at, derecho_id) VALUES (12, 'INFORMACIÓN DERECHOS, DEBERES Y CONDICIÓN PROCEDIMIENTO DE REFUGIO', '2014-02-14', NULL, NULL, '2014-08-04 14:28:13.313206', NULL);
INSERT INTO sivel2_sjr_aslegal (id, nombre, fechacreacion, fechadeshabilitacion, created_at, updated_at, derecho_id) VALUES (13, 'GESTIONES PARA TRÁMITES DE DOCUMENTACIÓN ANTE CNR Y SAIME', '2014-02-14', NULL, NULL, '2014-08-04 14:27:31.736931', NULL);
INSERT INTO sivel2_sjr_aslegal (id, nombre, fechacreacion, fechadeshabilitacion, created_at, updated_at, derecho_id) VALUES (14, 'PERMISO DE TRABAJO', '2014-02-14', NULL, NULL, '2014-08-04 14:28:40.275613', NULL);
INSERT INTO sivel2_sjr_aslegal (id, nombre, fechacreacion, fechadeshabilitacion, created_at, updated_at, derecho_id) VALUES (16, 'ACCIONES DE EXIGIBILIDAD DE DERECHOS ANTE CUALQUIER ORGANISMO', '2014-02-14', NULL, NULL, '2014-08-04 14:25:38.610317', NULL);
INSERT INTO sivel2_sjr_aslegal (id, nombre, fechacreacion, fechadeshabilitacion, created_at, updated_at, derecho_id) VALUES (17, 'TRATA Y TRÁFICO', '2014-02-14', NULL, NULL, '2014-08-04 14:29:54.891343', NULL);
INSERT INTO sivel2_sjr_aslegal (id, nombre, fechacreacion, fechadeshabilitacion, created_at, updated_at, derecho_id) VALUES (2, 'ASESORÍA DECISIÓN REFUGIO NEGATIVA', '2014-02-14', NULL, NULL, '2014-08-04 14:26:26.746522', NULL);
INSERT INTO sivel2_sjr_aslegal (id, nombre, fechacreacion, fechadeshabilitacion, created_at, updated_at, derecho_id) VALUES (4, 'CAMBIO DE DOMICILIO PERMANENTE', '2014-02-14', NULL, NULL, '2014-08-04 14:27:19.07573', NULL);
INSERT INTO sivel2_sjr_aslegal (id, nombre, fechacreacion, fechadeshabilitacion, created_at, updated_at, derecho_id) VALUES (5, 'NOTIFICACIONES DE TRASLADO TEMPORAL', '2014-02-14', NULL, NULL, '2014-08-04 14:28:24.132981', NULL);
INSERT INTO sivel2_sjr_aslegal (id, nombre, fechacreacion, fechadeshabilitacion, created_at, updated_at, derecho_id) VALUES (6, 'REMISIÓN DE CASOS', '2014-02-14', NULL, NULL, '2014-08-04 14:29:41.030037', NULL);
INSERT INTO sivel2_sjr_aslegal (id, nombre, fechacreacion, fechadeshabilitacion, created_at, updated_at, derecho_id) VALUES (7, 'ASESORÍA DECISIÓN REFUGIO POSITIVA', '2014-02-14', NULL, NULL, '2014-08-04 14:26:47.864887', NULL);
INSERT INTO sivel2_sjr_aslegal (id, nombre, fechacreacion, fechadeshabilitacion, created_at, updated_at, derecho_id) VALUES (8, 'REDACCIÓN RECURSO DE RECONSIDERACIÓN', '2014-02-14', NULL, NULL, '2014-08-04 14:29:27.012877', NULL);
INSERT INTO sivel2_sjr_aslegal (id, nombre, fechacreacion, fechadeshabilitacion, created_at, updated_at, derecho_id) VALUES (9, 'GESTIÓN DE OTROS TRÁMITES LEGALES VARIOS', '2014-02-14', NULL, NULL, '2014-08-04 14:28:00.09363', NULL);
INSERT INTO sivel2_sjr_aslegal (id, nombre, fechacreacion, fechadeshabilitacion, created_at, updated_at, derecho_id) VALUES (3, 'TUTELA ALIMENTACIÓN', '2014-10-08', NULL, '2014-10-08 23:48:22.656315', '2014-10-08 23:48:22.656315', 11);
    SQL
  end

  def down
    execute <<-SQL
    DELETE FROM sivel2_sjr_aslegal;
    SQL
  end
end
