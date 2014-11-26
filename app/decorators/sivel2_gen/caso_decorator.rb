# encoding: UTF-8

Sivel2Gen::Caso.class_eval do

  puts "OJO en decorador de caso definiendo refresca_conscaso"
  def self.refresca_conscaso
    if !ActiveRecord::Base.connection.table_exists? 'sivel2_gen_conscaso'
      ActiveRecord::Base.connection.execute(
        "CREATE OR REPLACE VIEW sivel2_gen_conscaso1 
        AS SELECT casosjr.id_caso as caso_id, 
        ARRAY_TO_STRING(ARRAY(SELECT nombres || ' ' || apellidos 
        FROM sivel2_gen_persona AS persona
          WHERE persona.id=casosjr.contacto), ', ')
          AS contacto_nombre, 
        casosjr.fecharec,
        regionsjr.nombre AS regionsjr_nombre,
        usuario.nusuario,
        caso.fecha AS caso_fecha,
        ARRAY_TO_STRING(ARRAY(SELECT departamento.nombre || '/' || 
        municipio.nombre
        FROM sivel2_gen_departamento AS departamento, 
          sivel2_gen_municipio AS municipio, 
          sivel2_gen_ubicacion AS ubicacion, 
          sivel2_sjr_desplazamiento AS desplazamiento
        WHERE desplazamiento.fechaexpulsion=caso.fecha
        AND desplazamiento.id_caso=caso.id
        AND desplazamiento.id_expulsion=ubicacion.id
        AND ubicacion.id_pais = departamento.id_pais
        AND ubicacion.id_departamento=departamento.id
        AND ubicacion.id_pais = municipio.id_pais
        AND ubicacion.id_departamento=municipio.id_departamento
        AND ubicacion.id_municipio=municipio.id ), ', ') AS expulsion,
        ARRAY_TO_STRING(ARRAY(SELECT departamento.nombre || '/' || 
        municipio.nombre
        FROM sivel2_gen_departamento AS departamento, 
          sivel2_gen_municipio AS municipio, 
          sivel2_gen_ubicacion AS ubicacion, 
          sivel2_sjr_desplazamiento AS desplazamiento
        WHERE desplazamiento.fechaexpulsion=caso.fecha
        AND desplazamiento.id_caso=caso.id
        AND desplazamiento.id_llegada=ubicacion.id
        AND ubicacion.id_pais = departamento.id_pais
        AND ubicacion.id_departamento=departamento.id
        AND ubicacion.id_departamento=municipio.id_departamento
        AND ubicacion.id_pais = municipio.id_pais
        AND ubicacion.id_municipio=municipio.id ), ', ') AS llegada,
        ARRAY_TO_STRING(ARRAY(SELECT fechaatencion 
        FROM sivel2_sjr_respuesta AS respuesta
          WHERE respuesta.id_caso=casosjr.id_caso 
          ORDER BY fechaatencion DESC LIMIT 1), ', ')
          AS respuesta_ultimafechaatencion,
        caso.memo AS caso_memo
        FROM sivel2_sjr_casosjr AS casosjr, sivel2_gen_caso AS caso, 
        sivel2_gen_regionsjr AS regionsjr, usuario
        WHERE casosjr.id_caso = caso.id
          AND regionsjr.id=casosjr.id_regionsjr
          AND usuario.id = casosjr.asesor
      ")
      ActiveRecord::Base.connection.execute(
        "CREATE MATERIALIZED VIEW sivel2_gen_conscaso 
        AS SELECT caso_id, contacto_nombre, fecharec, regionsjr_nombre, 
          nusuario, caso_fecha, expulsion, llegada,
          respuesta_ultimafechaatencion, caso_memo,
          to_tsvector('spanish', unaccent(caso_id || ' ' || contacto_nombre || 
            ' ' || replace(cast(fecharec AS varchar), '-', ' ') || 
            ' ' || regionsjr_nombre || ' ' || nusuario || ' ' || 
            replace(cast(caso_fecha AS varchar), '-', ' ') || ' ' ||
            expulsion  || ' ' || llegada || ' ' || 
            replace(cast(respuesta_ultimafechaatencion AS varchar), '-', ' ')
            || ' ' || caso_memo )) as q
        FROM sivel2_gen_conscaso1"
      );
      ActiveRecord::Base.connection.execute(
        "CREATE INDEX busca_conscaso ON sivel2_gen_conscaso USING gin(q);"
      )
    else
      ActiveRecord::Base.connection.execute(
        "REFRESH MATERIALIZED VIEW sivel2_gen_conscaso"
      )
    end
  end

  def self.porsjrc
    "porsjrc"
  end

end
