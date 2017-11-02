class Homologajur < ActiveRecord::Migration[5.1]
  def up
    execute <<-SQL
      -- ACCIONES DE EXIGIBILIDAD DE DERECHOS ANTE CUALQUIER ORGANISMO
      INSERT INTO sivel2_sjr_accionjuridica_respuesta (accionjuridica_id,
        respuesta_id) (SELECT 2, id_respuesta FROM 
          sivel2_sjr_aslegal_respuesta WHERE id_aslegal = '16');
      UPDATE sivel2_sjr_aslegal SET fechadeshabilitacion='2017-10-10' 
        WHERE id='16';
      -- ACCION LEGAL  
      INSERT INTO sivel2_sjr_accionjuridica_respuesta (accionjuridica_id,
        respuesta_id) (SELECT 1, id_respuesta FROM 
          sivel2_sjr_aslegal_respuesta WHERE id_aslegal = '103');
      UPDATE sivel2_sjr_aslegal SET fechadeshabilitacion='2017-10-10' 
        WHERE id='103';
      -- CAMBIO DE DOMICILIO PERMANENTE
      INSERT INTO sivel2_sjr_accionjuridica_respuesta (accionjuridica_id,
        respuesta_id) (SELECT 3, id_respuesta FROM 
          sivel2_sjr_aslegal_respuesta WHERE id_aslegal = '4');
      UPDATE sivel2_sjr_aslegal SET fechadeshabilitacion='2017-10-10' 
        WHERE id='4';
      -- DERECHO DE PETICION
      INSERT INTO sivel2_sjr_accionjuridica_respuesta (accionjuridica_id,
        respuesta_id) (SELECT 4, id_respuesta FROM 
          sivel2_sjr_aslegal_respuesta WHERE id_aslegal = '101');
      UPDATE sivel2_sjr_aslegal SET fechadeshabilitacion='2017-10-10' 
        WHERE id='101';
      -- GESTIONES PARA TRÁMITES DE DOCUMENTACIÓN ANTE CNR Y SAIME
      INSERT INTO sivel2_sjr_accionjuridica_respuesta (accionjuridica_id,
        respuesta_id) (SELECT 5, id_respuesta FROM 
          sivel2_sjr_aslegal_respuesta WHERE id_aslegal = '13');
      UPDATE sivel2_sjr_aslegal SET fechadeshabilitacion='2017-10-10' 
        WHERE id='13';
      -- GESTIÓN DE OTROS TRÁMITES LEGALES VARIOS
      INSERT INTO sivel2_sjr_accionjuridica_respuesta (accionjuridica_id,
        respuesta_id) (SELECT 6, id_respuesta FROM 
          sivel2_sjr_aslegal_respuesta WHERE id_aslegal = '9');
      UPDATE sivel2_sjr_aslegal SET fechadeshabilitacion='2017-10-10' 
        WHERE id='9';
      -- NOTIFICACIONES DE TRASLADO TEMPORAL
      INSERT INTO sivel2_sjr_accionjuridica_respuesta (accionjuridica_id,
        respuesta_id) (SELECT 7, id_respuesta FROM 
          sivel2_sjr_aslegal_respuesta WHERE id_aslegal = '5');
      UPDATE sivel2_sjr_aslegal SET fechadeshabilitacion='2017-10-10' 
        WHERE id='5';
      -- PERMISO DE TRABAJO
      INSERT INTO sivel2_sjr_accionjuridica_respuesta (accionjuridica_id,
        respuesta_id) (SELECT 8, id_respuesta FROM 
          sivel2_sjr_aslegal_respuesta WHERE id_aslegal = '14');
      UPDATE sivel2_sjr_aslegal SET fechadeshabilitacion='2017-10-10' 
        WHERE id='14';
      -- REDACCIÓN RECURSO DE RECONSIDERACIÓN
      INSERT INTO sivel2_sjr_accionjuridica_respuesta (accionjuridica_id,
        respuesta_id) (SELECT 9, id_respuesta FROM 
          sivel2_sjr_aslegal_respuesta WHERE id_aslegal = '8');
      UPDATE sivel2_sjr_aslegal SET fechadeshabilitacion='2017-10-10' 
        WHERE id='8';
      -- REMISIÓN DE CASOS
      INSERT INTO sivel2_sjr_accionjuridica_respuesta (accionjuridica_id,
        respuesta_id) (SELECT 10, id_respuesta FROM 
          sivel2_sjr_aslegal_respuesta WHERE id_aslegal = '6');
      UPDATE sivel2_sjr_aslegal SET fechadeshabilitacion='2017-10-10' 
        WHERE id='6';
      -- RENUNCIA AL PROCEDIMIENTO DE SOLICITUD DE REFUGIO: TIPO Y MOTIVOS
      INSERT INTO sivel2_sjr_accionjuridica_respuesta (accionjuridica_id,
        respuesta_id) (SELECT 11, id_respuesta FROM 
          sivel2_sjr_aslegal_respuesta WHERE id_aslegal = '1');
      UPDATE sivel2_sjr_aslegal SET fechadeshabilitacion='2017-10-10' 
        WHERE id='1';
      -- TRATA Y TRÁFICO
      INSERT INTO sivel2_sjr_accionjuridica_respuesta (accionjuridica_id,
        respuesta_id) (SELECT 12, id_respuesta FROM 
          sivel2_sjr_aslegal_respuesta WHERE id_aslegal = '17');
      UPDATE sivel2_sjr_aslegal SET fechadeshabilitacion='2017-10-10' 
        WHERE id='17';
    SQL
  end
  
  def down
    execute <<-SQL
      UPDATE sivel2_sjr_aslegal SET fechadeshabilitacion=NULL 
        WHERE id IN (1,4,5,6,8,9,13,14,16,17,101,103);
    SQL
  end
end
