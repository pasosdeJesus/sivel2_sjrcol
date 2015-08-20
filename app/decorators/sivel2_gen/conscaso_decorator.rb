# encoding: UTF-8

Sivel2Gen::Conscaso.class_eval do

  def self.refresca_conscaso
    if !ActiveRecord::Base.connection.table_exists? 'sivel2_gen_conscaso'
      ActiveRecord::Base.connection.execute(
        "CREATE OR REPLACE VIEW sivel2_gen_conscaso1 
        AS SELECT casosjr.id_caso as caso_id, 
        ARRAY_TO_STRING(ARRAY(SELECT nombres || ' ' || apellidos 
        FROM sip_persona AS persona
          WHERE persona.id=casosjr.contacto), ', ')
          AS contacto,
        casosjr.fecharec,
        oficina.nombre AS oficina,
        usuario.nusuario,
        caso.fecha AS fecha,
        ARRAY_TO_STRING(ARRAY(SELECT departamento.nombre || ' / ' || 
        municipio.nombre
        FROM sip_departamento AS departamento, 
          sip_municipio AS municipio, 
          sip_ubicacion AS ubicacion, 
          sivel2_sjr_desplazamiento AS desplazamiento
        WHERE desplazamiento.fechaexpulsion=caso.fecha
        AND desplazamiento.id_caso=caso.id
        AND desplazamiento.id_expulsion=ubicacion.id
        AND ubicacion.id_departamento=departamento.id
        AND ubicacion.id_municipio=municipio.id ), ', ') AS expulsion,
        ARRAY_TO_STRING(ARRAY(SELECT departamento.nombre || ' / ' || 
        municipio.nombre
        FROM sip_departamento AS departamento, 
          sip_municipio AS municipio, 
          sip_ubicacion AS ubicacion, 
          sivel2_sjr_desplazamiento AS desplazamiento
        WHERE desplazamiento.fechaexpulsion=caso.fecha
        AND desplazamiento.id_caso=caso.id
        AND desplazamiento.id_llegada=ubicacion.id
        AND ubicacion.id_departamento=departamento.id
        AND ubicacion.id_municipio=municipio.id ), ', ') AS llegada,
        ARRAY_TO_STRING(ARRAY(SELECT fechaatencion 
        FROM sivel2_sjr_respuesta AS respuesta
          WHERE respuesta.id_caso=casosjr.id_caso 
          ORDER BY fechaatencion DESC LIMIT 1), ', ')
          AS ultimafechaatencion,
        caso.memo AS memo
        FROM sivel2_sjr_casosjr AS casosjr, sivel2_gen_caso AS caso, 
        sip_oficina AS oficina, usuario
        WHERE casosjr.id_caso = caso.id
          AND oficina.id=casosjr.oficina_id
          AND usuario.id = casosjr.asesor
      ")
      ActiveRecord::Base.connection.execute(
        "CREATE MATERIALIZED VIEW sivel2_gen_conscaso 
        AS SELECT caso_id, contacto, fecharec, oficina, 
          nusuario, fecha, expulsion, llegada,
          ultimafechaatencion, memo,
          to_tsvector('spanish', unaccent(caso_id || ' ' || contacto || 
            ' ' || replace(cast(fecharec AS varchar), '-', ' ') || 
            ' ' || oficina || ' ' || nusuario || ' ' || 
            replace(cast(fecha AS varchar), '-', ' ') || ' ' ||
            expulsion  || ' ' || llegada || ' ' || 
            replace(cast(ultimafechaatencion AS varchar), '-', ' ')
            || ' ' || memo )) as q
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
