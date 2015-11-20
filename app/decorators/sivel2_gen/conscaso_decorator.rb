# encoding: UTF-8

Sivel2Gen::Conscaso.class_eval do

  scope :filtro_expulsion_pais_id, lambda { |id|
    where('(caso_id, fecha) IN (SELECT sip_ubicacion.id_caso, 
          sivel2_sjr_desplazamiento.fechaexpulsion FROM
          sivel2_sjr_desplazamiento JOIN sip_ubicacion 
          ON sivel2_sjr_desplazamiento.id_expulsion=sip_ubicacion.id
          AND sivel2_sjr_desplazamiento.id_caso=sip_ubicacion.id_caso
          WHERE sip_ubicacion.id_pais = ?)', id)
  }

  scope :filtro_expulsion_departamento_id, lambda { |id|
    where('(caso_id, fecha) IN (SELECT sip_ubicacion.id_caso,
          sivel2_sjr_desplazamiento.fechaexpulsion FROM
          sivel2_sjr_desplazamiento JOIN sip_ubicacion 
          ON sivel2_sjr_desplazamiento.id_expulsion=sip_ubicacion.id
          AND sivel2_sjr_desplazamiento.id_caso=sip_ubicacion.id_caso
          WHERE sip_ubicacion.id_departamento = ?)', id)
  }

  scope :filtro_expulsion_municipio_id, lambda { |id|
    where('(caso_id, fecha) IN (SELECT sip_ubicacion.id_caso,
          sivel2_sjr_desplazamiento.fechaexpulsion FROM
          sivel2_sjr_desplazamiento JOIN sip_ubicacion 
          ON sivel2_sjr_desplazamiento.id_expulsion=sip_ubicacion.id
          AND sivel2_sjr_desplazamiento.id_caso=sip_ubicacion.id_caso
          WHERE sip_ubicacion.id_municipio = ?)', id)
  }

  scope :filtro_llegada_pais_id, lambda { |id|
    where('(caso_id, fecha) IN (SELECT sip_ubicacion.id_caso,
          sivel2_sjr_desplazamiento.fechaexpulsion FROM
          sivel2_sjr_desplazamiento JOIN sip_ubicacion 
          ON sivel2_sjr_desplazamiento.id_llegada=sip_ubicacion.id
          AND sivel2_sjr_desplazamiento.id_caso=sip_ubicacion.id_caso
          WHERE sip_ubicacion.id_pais = ?)', id)
  }

  scope :filtro_llegada_departamento_id, lambda { |id|
    where('(caso_id, fecha) IN (SELECT sip_ubicacion.id_caso,
          sivel2_sjr_desplazamiento.fechaexpulsion FROM
          sivel2_sjr_desplazamiento JOIN sip_ubicacion 
          ON sivel2_sjr_desplazamiento.id_llegada=sip_ubicacion.id
          AND sivel2_sjr_desplazamiento.id_caso=sip_ubicacion.id_caso
          WHERE sip_ubicacion.id_departamento = ?)', id)
  }

  scope :filtro_llegada_municipio_id, lambda { |id|
    where('(caso_id, fecha) IN (SELECT sip_ubicacion.id_caso,
          sivel2_sjr_desplazamiento.fechaexpulsion FROM
          sivel2_sjr_desplazamiento JOIN sip_ubicacion 
          ON sivel2_sjr_desplazamiento.id_llegada=sip_ubicacion.id
          AND sivel2_sjr_desplazamiento.id_caso=sip_ubicacion.id_caso
          WHERE sip_ubicacion.id_municipio = ?)', id)
  }

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
        ARRAY_TO_STRING(ARRAY(SELECT supracategoria.id_tviolencia || ':' || 
          categoria.supracategoria_id || ':' || categoria.id || ' ' ||
          categoria.nombre FROM sivel2_gen_categoria AS categoria, 
          sivel2_gen_supracategoria AS supracategoria,
          sivel2_gen_acto AS acto
          WHERE categoria.id=acto.id_categoria
          AND supracategoria.id=categoria.supracategoria_id
          AND acto.id_caso=caso.id), ', ')
        AS tipificacion,
        ARRAY_TO_STRING(ARRAY(SELECT nombres || ' ' || apellidos 
          FROM sip_persona AS persona, 
          sivel2_gen_victima AS victima WHERE persona.id=victima.id_persona 
          AND victima.id_caso=caso.id), ', ')
        AS victimas, 
        ARRAY_TO_STRING(ARRAY(SELECT departamento.nombre ||  ' / ' 
          || municipio.nombre 
          FROM sip_ubicacion AS ubicacion 
					LEFT JOIN sip_departamento AS departamento 
						ON (ubicacion.id_departamento = departamento.id)
        	LEFT JOIN sip_municipio AS municipio 
						ON (ubicacion.id_municipio=municipio.id)
          WHERE ubicacion.id_caso=caso.id), ', ')
        AS ubicaciones, 
        ARRAY_TO_STRING(ARRAY(SELECT nombre 
          FROM sivel2_gen_presponsable AS presponsable, 
          sivel2_gen_caso_presponsable AS caso_presponsable
          WHERE presponsable.id=caso_presponsable.id_presponsable
          AND caso_presponsable.id_caso=caso.id), ', ')
        AS presponsables, 
        casosjr.memo1612 as memo1612,
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
          ultimafechaatencion, tipificacion, victimas, presponsables, 
          ubicaciones, memo1612, memo,
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
