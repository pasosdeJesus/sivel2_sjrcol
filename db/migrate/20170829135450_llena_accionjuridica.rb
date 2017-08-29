class LlenaAccionjuridica < ActiveRecord::Migration[5.1]
  def up
    execute <<-SQL
      INSERT INTO sivel2_sjr_accionjuridica (id, nombre, fechacreacion, created_at, updated_at)
        VALUES (0, 'SIN INFORMACIÓN', '2017-08-29', '2017-08-29', '2017-08-29');

      INSERT INTO sivel2_sjr_accionjuridica (id, nombre, fechacreacion, created_at, updated_at)
        VALUES (1, 'ACCIÓN LEGAL', '2017-08-29', '2017-08-29', '2017-08-29');

      INSERT INTO sivel2_sjr_accionjuridica (id, nombre, fechacreacion, created_at, updated_at)
        VALUES (2, 'ACCIONES DE EXIGIBILIDAD DE DERECHOS ANTE CUALQUIER ORGANISMO', '2017-08-29', '2017-08-29', '2017-08-29');

      INSERT INTO sivel2_sjr_accionjuridica (id, nombre, fechacreacion, created_at, updated_at)
        VALUES (3, 'CAMBIO DE DOMICILIO PERMANENTE', '2017-08-29', '2017-08-29', '2017-08-29');
        
      INSERT INTO sivel2_sjr_accionjuridica (id, nombre, fechacreacion, created_at, updated_at)
        VALUES (4, 'DERECHO DE PETICION', '2017-08-29', '2017-08-29', '2017-08-29');
        
      INSERT INTO sivel2_sjr_accionjuridica (id, nombre, fechacreacion, created_at, updated_at)
        VALUES (5, 'GESTIONES PARA TRÁMITES DE DOCUMENTACIÓN ANTE CNR Y SAIME', '2017-08-29', '2017-08-29', '2017-08-29');
        
      INSERT INTO sivel2_sjr_accionjuridica (id, nombre, fechacreacion, created_at, updated_at)
        VALUES (6, 'GESTIÓN DE OTROS TRÁMITES LEGALES VARIOS', '2017-08-29', '2017-08-29', '2017-08-29');
        
      INSERT INTO sivel2_sjr_accionjuridica (id, nombre, fechacreacion, created_at, updated_at)
        VALUES (7, 'NOTIFICACIONES DE TRASLADO TEMPORAL', '2017-08-29', '2017-08-29', '2017-08-29');
        
      INSERT INTO sivel2_sjr_accionjuridica (id, nombre, fechacreacion, created_at, updated_at)
        VALUES (8, 'PERMISO DE TRABAJO', '2017-08-29', '2017-08-29', '2017-08-29');
        
      INSERT INTO sivel2_sjr_accionjuridica (id, nombre, fechacreacion, created_at, updated_at)
        VALUES (9, 'REDACCIÓN RECURSO DE RECONSIDERACIÓN', '2017-08-29', '2017-08-29', '2017-08-29');
        
      INSERT INTO sivel2_sjr_accionjuridica (id, nombre, fechacreacion, created_at, updated_at)
        VALUES (10, 'REMISIÓN DE CASOS', '2017-08-29', '2017-08-29', '2017-08-29');
        
      INSERT INTO sivel2_sjr_accionjuridica (id, nombre, fechacreacion, created_at, updated_at)
        VALUES (11, 'RENUNCIA AL PROCEDIMIENTO DE SOLICITUD DE REFUGIO: TIPO Y MOTIVOS ', '2017-08-29', '2017-08-29', '2017-08-29');
        
      INSERT INTO sivel2_sjr_accionjuridica (id, nombre, fechacreacion, created_at, updated_at)
        VALUES (12, 'TRATA Y TRÁFICO ', '2017-08-29', '2017-08-29', '2017-08-29');
        
      INSERT INTO sivel2_sjr_accionjuridica (id, nombre, fechacreacion, created_at, updated_at)
        VALUES (13, 'TUTELA ALIMENTACIÓN', '2017-08-29', '2017-08-29', '2017-08-29');
        
      INSERT INTO sivel2_sjr_accionjuridica (id, nombre, fechacreacion, created_at, updated_at)
        VALUES (14, 'ACCIONES POPULARES Y OTRAS', '2017-08-29', '2017-08-29', '2017-08-29');

      INSERT INTO sivel2_sjr_accionjuridica (id, nombre, fechacreacion, created_at, updated_at)
        VALUES (15, 'ACCIÓN DE CUMPLIMIENTO', '2017-08-29', '2017-08-29', '2017-08-29');
      
      INSERT INTO sivel2_sjr_accionjuridica (id, nombre, fechacreacion, created_at, updated_at)
        VALUES (16, 'APELACIÓN', '2017-08-29', '2017-08-29', '2017-08-29');
      
      INSERT INTO sivel2_sjr_accionjuridica (id, nombre, fechacreacion, created_at, updated_at)
        VALUES (17, 'APELACIÓN', '2017-08-29', '2017-08-29', '2017-08-29');
      
      INSERT INTO sivel2_sjr_accionjuridica (id, nombre, fechacreacion, created_at, updated_at)
        VALUES (18, 'DESACATO', '2017-08-29', '2017-08-29', '2017-08-29');

      INSERT INTO sivel2_sjr_accionjuridica (id, nombre, fechacreacion, created_at, updated_at)
        VALUES (19, 'IMPUGNACIÓN', '2017-08-29', '2017-08-29', '2017-08-29');

      INSERT INTO sivel2_sjr_accionjuridica (id, nombre, fechacreacion, created_at, updated_at)
        VALUES (20, 'QUEJA', '2017-08-29', '2017-08-29', '2017-08-29');

      INSERT INTO sivel2_sjr_accionjuridica (id, nombre, fechacreacion, created_at, updated_at)
        VALUES (21, 'RECURSO DE REPOSICION Y EN SUBSIDIO DE APELACION', '2017-08-29', '2017-08-29', '2017-08-29');
    SQL
  end
  def down
    execute <<-SQL
      DELETE FROM sivel2_sjr_accionjuridica WHERE id<='13';
    SQL
  end
end
