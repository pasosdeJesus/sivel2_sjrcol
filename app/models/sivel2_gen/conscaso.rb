# encoding: UTF-8

require 'sivel2_sjr/concerns/models/conscaso'

class Sivel2Gen::Conscaso < ActiveRecord::Base
  include Sivel2Sjr::Concerns::Models::Conscaso
  
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
    if !ActiveRecord::Base.connection.data_source_exists? 'sivel2_sjr_ultimaatencion'
      ActiveRecord::Base.connection.execute(
        "CREATE OR REPLACE VIEW sivel2_sjr_ultimaatencion AS 
        (SELECT id_caso, id, fechaatencion, descatencion, detallemotivo, 
         detalleal, detallear FROM sivel2_sjr_respuesta 
         WHERE (id_caso, fechaatencion) in (SELECT id_caso, MIN(fechaatencion)
         FROM sivel2_sjr_respuesta GROUP BY 1));")
    end
    if !ActiveRecord::Base.connection.data_source_exists? 'sivel2_gen_conscaso'
      ActiveRecord::Base.connection.execute(
        "CREATE OR REPLACE VIEW sivel2_gen_conscaso1 
        AS SELECT casosjr.id_caso as caso_id, 
        (contacto.nombres || ' ' || contacto.apellidos) AS contacto,
        contacto.nombres AS contacto_nombres,
        contacto.apellidos AS contacto_apellidos,
        (COALESCE(tdocumento.sigla, '') || ' ' || contacto.numerodocumento) 
          AS contacto_identificacion,
        contacto.sexo AS contacto_sexo,
        COALESCE(etnia.nombre, '') AS contacto_etnia,
        CASE WHEN contacto.anionac IS NULL THEN NULL
          WHEN contacto.mesnac IS NULL OR contacto.dianac IS NULL THEN 
            EXTRACT(YEAR FROM ultimaatencion.fechaatencion)-contacto.anionac
          WHEN contacto.mesnac < EXTRACT(MONTH FROM ultimaatencion.fechaatencion) THEN
            EXTRACT(YEAR FROM ultimaatencion.fechaatencion)-contacto.anionac
          WHEN contacto.mesnac > EXTRACT(MONTH FROM ultimaatencion.fechaatencion) THEN
            EXTRACT(YEAR FROM ultimaatencion.fechaatencion)-contacto.anionac-1
          WHEN contacto.dianac > EXTRACT(DAY FROM ultimaatencion.fechaatencion) THEN
            EXTRACT(YEAR FROM ultimaatencion.fechaatencion)-contacto.anionac-1
          ELSE 
            EXTRACT(YEAR FROM ultimaatencion.fechaatencion)-contacto.anionac
        END AS contacto_edad_ultimaatencion,
        EXTRACT(MONTH FROM ultimaatencion.fechaatencion) AS ultimaatencion_mes,
        ultimaatencion.fechaatencion AS ultimaatencion_fecha,
        (SELECT COUNT(*) FROM 
          sivel2_gen_victima AS victima JOIN sip_persona ON
            sip_persona.id=victima.id_persona
          WHERE victima.id_caso=caso.id AND sip_persona.sexo='M' 
          AND id_rangoedad='7') AS beneficiarios_0_5,
        (SELECT COUNT(*) FROM 
          sivel2_gen_victima AS victima JOIN sip_persona ON
            sip_persona.id=victima.id_persona
          WHERE victima.id_caso=caso.id AND sip_persona.sexo='M' 
          AND id_rangoedad='8') AS beneficiarios_6_12,
        (SELECT COUNT(*) FROM 
          sivel2_gen_victima AS victima JOIN sip_persona ON
            sip_persona.id=victima.id_persona
          WHERE victima.id_caso=caso.id AND sip_persona.sexo='M' 
          AND id_rangoedad='9') AS beneficiarios_13_17,
        (SELECT COUNT(*) FROM 
          sivel2_gen_victima AS victima JOIN sip_persona ON
            sip_persona.id=victima.id_persona
          WHERE victima.id_caso=caso.id AND sip_persona.sexo='M' 
          AND id_rangoedad='10') AS beneficiarios_18_26,
        (SELECT COUNT(*) FROM 
          sivel2_gen_victima AS victima JOIN sip_persona ON
            sip_persona.id=victima.id_persona
          WHERE victima.id_caso=caso.id AND sip_persona.sexo='M' 
          AND id_rangoedad='10') AS beneficiarios_27_59,
        (SELECT COUNT(*) FROM 
          sivel2_gen_victima AS victima JOIN sip_persona ON
            sip_persona.id=victima.id_persona
          WHERE victima.id_caso=caso.id AND sip_persona.sexo='M' 
          AND id_rangoedad='10') AS beneficiarios_60_,

        (SELECT COUNT(*) FROM 
          sivel2_gen_victima AS victima JOIN sip_persona ON
            sip_persona.id=victima.id_persona
          WHERE victima.id_caso=caso.id AND sip_persona.sexo='F' 
          AND id_rangoedad='7') AS beneficiarias_0_5,
        (SELECT COUNT(*) FROM 
          sivel2_gen_victima AS victima JOIN sip_persona ON
            sip_persona.id=victima.id_persona
          WHERE victima.id_caso=caso.id AND sip_persona.sexo='F' 
          AND id_rangoedad='8') AS beneficiarias_6_12,
        (SELECT COUNT(*) FROM 
          sivel2_gen_victima AS victima JOIN sip_persona ON
            sip_persona.id=victima.id_persona
          WHERE victima.id_caso=caso.id AND sip_persona.sexo='F' 
          AND id_rangoedad='9') AS beneficiarias_13_17,
        (SELECT COUNT(*) FROM 
          sivel2_gen_victima AS victima JOIN sip_persona ON
            sip_persona.id=victima.id_persona
          WHERE victima.id_caso=caso.id AND sip_persona.sexo='F' 
          AND id_rangoedad='10') AS beneficiarias_18_26,
        (SELECT COUNT(*) FROM 
          sivel2_gen_victima AS victima JOIN sip_persona ON
            sip_persona.id=victima.id_persona
          WHERE victima.id_caso=caso.id AND sip_persona.sexo='F' 
          AND id_rangoedad='10') AS beneficiarias_27_59,
        (SELECT COUNT(*) FROM 
          sivel2_gen_victima AS victima JOIN sip_persona ON
            sip_persona.id=victima.id_persona
          WHERE victima.id_caso=caso.id AND sip_persona.sexo='F' 
          AND id_rangoedad='10') AS beneficiarias_60_,

        ARRAY_TO_STRING(ARRAY(SELECT nombre FROM sivel2_sjr_derecho 
          JOIN sivel2_sjr_derecho_respuesta ON id_derecho=sivel2_sjr_derecho.id
          WHERE id_respuesta=ultimaatencion.id), ', ')
          AS ultimaatencion_derechosvul,
        ARRAY_TO_STRING(ARRAY(SELECT nombre FROM sivel2_sjr_ayudasjr
          JOIN sivel2_sjr_ayudasjr_respuesta ON id_ayudasjr=sivel2_sjr_ayudasjr.id
          WHERE id_respuesta=ultimaatencion.id), ', ') || 
          ' ' || ultimaatencion.detallear AS ultimaatencion_as_humanitaria,
        ARRAY_TO_STRING(ARRAY(SELECT nombre FROM sivel2_sjr_aslegal
          JOIN sivel2_sjr_aslegal_respuesta ON id_aslegal=sivel2_sjr_aslegal.id
          WHERE id_respuesta=ultimaatencion.id), ', ') || 
          ' ' || ultimaatencion.detalleal AS ultimaatencion_as_juridica,
        ARRAY_TO_STRING(ARRAY(SELECT nombre FROM sivel2_sjr_motivosjr
          JOIN sivel2_sjr_motivosjr_respuesta ON id_motivosjr=sivel2_sjr_motivosjr.id
          WHERE id_respuesta=ultimaatencion.id), ', ') || 
          ' ' || ultimaatencion.detallemotivo AS ultimaatencion_otros_ser_as,
        ultimaatencion.descatencion AS ultimaatencion_descripcion_at,
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
        FROM sivel2_sjr_casosjr AS casosjr 
          JOIN sivel2_gen_caso AS caso ON casosjr.id_caso = caso.id 
          JOIN sip_oficina AS oficina ON oficina.id=casosjr.oficina_id
          JOIN usuario ON usuario.id = casosjr.asesor
          JOIN sip_persona as contacto ON contacto.id=casosjr.contacto
          LEFT JOIN sip_tdocumento AS tdocumento ON 
            tdocumento.id=contacto.tdocumento_id
          JOIN sivel2_gen_victima AS vcontacto ON 
            vcontacto.id_persona = contacto.id AND vcontacto.id_caso = caso.id
          LEFT JOIN sivel2_gen_etnia AS etnia ON
            vcontacto.id_etnia=etnia.id
          LEFT JOIN sivel2_sjr_ultimaatencion AS ultimaatencion ON
            ultimaatencion.id_caso = caso.id
      ")
      ActiveRecord::Base.connection.execute(
        "CREATE MATERIALIZED VIEW sivel2_gen_conscaso 
        AS SELECT caso_id, contacto, 
          contacto_nombres, contacto_apellidos, contacto_identificacion, 
          contacto_sexo, contacto_edad_ultimaatencion, contacto_etnia,
          beneficiarios_0_5, beneficiarios_6_12,
          beneficiarios_13_17, beneficiarios_18_26,
          beneficiarios_27_59, beneficiarios_60_,
          beneficiarias_0_5, beneficiarias_6_12,
          beneficiarias_13_17, beneficiarias_18_26,
          beneficiarias_27_59, beneficiarias_60_,
          ultimaatencion_derechosvul, ultimaatencion_as_humanitaria,
          ultimaatencion_as_juridica, ultimaatencion_otros_ser_as, 
          ultimaatencion_descripcion_at,
          fecharec, oficina, nusuario, fecha, expulsion, llegada,
          ultimaatencion_mes, ultimaatencion_fecha, tipificacion, victimas, presponsables, 
          ubicaciones, memo1612, memo,
          to_tsvector('spanish', unaccent(caso_id || ' ' || contacto || 
            ' ' || replace(cast(fecharec AS varchar), '-', ' ') || 
            ' ' || oficina || ' ' || nusuario || ' ' || 
            replace(cast(fecha AS varchar), '-', ' ') || ' ' ||
            expulsion  || ' ' || llegada || ' ' || 
            replace(cast(ultimaatencion_fecha AS varchar), '-', ' ')
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

