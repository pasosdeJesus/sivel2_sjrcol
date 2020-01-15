# encoding: UTF-8

require 'sivel2_sjr/concerns/models/conscaso'

class Sivel2Gen::Conscaso < ActiveRecord::Base
  include Sivel2Sjr::Concerns::Models::Conscaso

  scope :filtro_numerodocumento, lambda { |a|
    joins(:casosjr).joins(:persona).
      where('sivel2_sjr_casosjr.contacto_id = sip_persona.id ' +
            'AND sip_persona.numerodocumento ILIKE \'%' +
            ActiveRecord::Base.connection.quote_string(a) + '%\'')
  }

  scope :filtro_tdocumento, lambda { |a|
    joins(:casosjr).joins(:persona).
      where('sivel2_sjr_casosjr.contacto_id = sip_persona.id ' +
            'AND sip_persona.tdocumento ILIKE \'%' +
            ActiveRecord::Base.connection.quote_string(a) + '%\'')
  }

  scope :filtro_expulsion_pais_id, lambda { |id|
    where('(caso_id, fecha) IN (SELECT sip_ubicacion.id_caso, 
          sivel2_sjr_desplazamiento.fechaexpulsion FROM
          public.sivel2_sjr_desplazamiento JOIN public.sip_ubicacion 
          ON sivel2_sjr_desplazamiento.id_expulsion=sip_ubicacion.id
          AND sivel2_sjr_desplazamiento.id_caso=sip_ubicacion.id_caso
          WHERE sip_ubicacion.id_pais = ?)', id)
  }

  scope :filtro_expulsion_departamento_id, lambda { |id|
    where('(caso_id, fecha) IN (SELECT sip_ubicacion.id_caso,
          sivel2_sjr_desplazamiento.fechaexpulsion FROM
          public.sivel2_sjr_desplazamiento JOIN public.sip_ubicacion 
          ON sivel2_sjr_desplazamiento.id_expulsion=sip_ubicacion.id
          AND sivel2_sjr_desplazamiento.id_caso=sip_ubicacion.id_caso
          WHERE sip_ubicacion.id_departamento = ?)', id)
  }

  scope :filtro_expulsion_municipio_id, lambda { |id|
    where('(caso_id, fecha) IN (SELECT sip_ubicacion.id_caso,
          sivel2_sjr_desplazamiento.fechaexpulsion FROM
          public.sivel2_sjr_desplazamiento JOIN public.sip_ubicacion 
          ON sivel2_sjr_desplazamiento.id_expulsion=sip_ubicacion.id
          AND sivel2_sjr_desplazamiento.id_caso=sip_ubicacion.id_caso
          WHERE sip_ubicacion.id_municipio = ?)', id)
  }

  scope :filtro_llegada_pais_id, lambda { |id|
    where('(caso_id, fecha) IN (SELECT sip_ubicacion.id_caso,
          sivel2_sjr_desplazamiento.fechaexpulsion FROM
          public.sivel2_sjr_desplazamiento JOIN public.sip_ubicacion 
          ON sivel2_sjr_desplazamiento.id_llegada=sip_ubicacion.id
          AND sivel2_sjr_desplazamiento.id_caso=sip_ubicacion.id_caso
          WHERE sip_ubicacion.id_pais = ?)', id)
  }

  scope :filtro_llegada_departamento_id, lambda { |id|
    where('(caso_id, fecha) IN (SELECT sip_ubicacion.id_caso,
          sivel2_sjr_desplazamiento.fechaexpulsion FROM
          public.sivel2_sjr_desplazamiento JOIN public.sip_ubicacion 
          ON sivel2_sjr_desplazamiento.id_llegada=sip_ubicacion.id
          AND sivel2_sjr_desplazamiento.id_caso=sip_ubicacion.id_caso
          WHERE sip_ubicacion.id_departamento = ?)', id)
  }

  scope :filtro_llegada_municipio_id, lambda { |id|
    where('(caso_id, fecha) IN (SELECT sip_ubicacion.id_caso,
          sivel2_sjr_desplazamiento.fechaexpulsion FROM
          public.sivel2_sjr_desplazamiento JOIN public.sip_ubicacion 
          ON sivel2_sjr_desplazamiento.id_llegada=sip_ubicacion.id
          AND sivel2_sjr_desplazamiento.id_caso=sip_ubicacion.id_caso
          WHERE sip_ubicacion.id_municipio = ?)', id)
  }

  def self.refresca_conscaso
    if !ActiveRecord::Base.connection.data_source_exists? 'sivel2_sjr_ultimaatencion'
      ActiveRecord::Base.connection.execute(
        "CREATE OR REPLACE VIEW sivel2_sjr_ultimaatencion AS 
        (SELECT respuesta.id_caso, respuesta.id, respuesta.fechaatencion, respuesta.descatencion, respuesta.detallemotivo, 
         respuesta.detalleal, respuesta.detallear,
        CASE WHEN contacto.anionac IS NULL THEN NULL
          WHEN contacto.mesnac IS NULL OR contacto.dianac IS NULL THEN 
            CAST(EXTRACT(YEAR FROM fechaatencion)-contacto.anionac AS INTEGER)
          WHEN contacto.mesnac < EXTRACT(MONTH FROM fechaatencion) THEN
            CAST(EXTRACT(YEAR FROM fechaatencion)-contacto.anionac AS INTEGER)
          WHEN contacto.mesnac > EXTRACT(MONTH FROM fechaatencion) THEN
            CAST(EXTRACT(YEAR FROM fechaatencion)-contacto.anionac-1 AS INTEGER)
          WHEN contacto.dianac > EXTRACT(DAY FROM fechaatencion) THEN
            CAST(EXTRACT(YEAR FROM fechaatencion)-contacto.anionac-1 AS INTEGER)
          ELSE 
            CAST(EXTRACT(YEAR FROM fechaatencion)-contacto.anionac AS INTEGER)
        END AS contacto_edad
  FROM public.sivel2_sjr_respuesta AS respuesta JOIN public.sivel2_sjr_casosjr AS casosjr ON respuesta.id_caso=casosjr.id_caso
  JOIN sip_persona as contacto ON contacto.id=casosjr.contacto_id
         WHERE (respuesta.id_caso, fechaatencion) in 
        (SELECT id_caso, MAX(fechaatencion)
         FROM public.sivel2_sjr_respuesta GROUP BY 1));")
    end
    if !ActiveRecord::Base.connection.data_source_exists? 'sivel2_gen_conscaso'
      ActiveRecord::Base.connection.execute(
        "CREATE OR REPLACE VIEW sivel2_gen_conscaso1 
        AS SELECT casosjr.id_caso as caso_id, 
        (contacto.nombres || ' ' || contacto.apellidos) AS contacto,
        ultimaatencion.fechaatencion AS ultimaatencion_fecha,
        casosjr.fecharec,
        oficina.nombre AS oficina,
        usuario.nusuario,
        caso.fecha AS fecha,
        ARRAY_TO_STRING(ARRAY(SELECT departamento.nombre || ' / ' || 
        municipio.nombre
        FROM public.sip_departamento AS departamento, 
          public.sip_municipio AS municipio, 
          public.sip_ubicacion AS ubicacion, 
          public.sivel2_sjr_desplazamiento AS desplazamiento
        WHERE desplazamiento.fechaexpulsion=caso.fecha
        AND desplazamiento.id_caso=caso.id
        AND desplazamiento.id_expulsion=ubicacion.id
        AND ubicacion.id_departamento=departamento.id
        AND ubicacion.id_municipio=municipio.id ), ', ') AS expulsion,
        ARRAY_TO_STRING(ARRAY(SELECT departamento.nombre || ' / ' || 
        municipio.nombre
        FROM public.sip_departamento AS departamento, 
          public.sip_municipio AS municipio, 
          public.sip_ubicacion AS ubicacion, 
          public.sivel2_sjr_desplazamiento AS desplazamiento
        WHERE desplazamiento.fechaexpulsion=caso.fecha
        AND desplazamiento.id_caso=caso.id
        AND desplazamiento.id_llegada=ubicacion.id
        AND ubicacion.id_departamento=departamento.id
        AND ubicacion.id_municipio=municipio.id ), ', ') AS llegada,
        caso.memo AS memo
        FROM public.sivel2_sjr_casosjr AS casosjr 
          JOIN public.sivel2_gen_caso AS caso ON casosjr.id_caso = caso.id 
          JOIN public.sip_oficina AS oficina ON oficina.id=casosjr.oficina_id
          JOIN public.usuario ON usuario.id = casosjr.asesor
          JOIN public.sip_persona AS contacto ON contacto.id=casosjr.contacto_id
          JOIN public.sivel2_gen_victima AS vcontacto ON 
            vcontacto.id_persona = contacto.id AND vcontacto.id_caso = caso.id
          LEFT JOIN public.sivel2_sjr_ultimaatencion AS ultimaatencion ON
            ultimaatencion.id_caso = caso.id
      ")
      ActiveRecord::Base.connection.execute(
        "CREATE MATERIALIZED VIEW sivel2_gen_conscaso 
        AS SELECT caso_id, contacto, 
          fecharec, oficina, nusuario, fecha, expulsion, llegada,
          ultimaatencion_fecha,
          memo, to_tsvector('spanish', unaccent(caso_id || ' ' || contacto || 
            ' ' || replace(cast(fecharec AS varchar), '-', ' ') || 
            ' ' || oficina || ' ' || nusuario || ' ' || 
            replace(cast(fecha AS varchar), '-', ' ') || ' ' ||
            expulsion  || ' ' || llegada || ' ' || 
            replace(cast(ultimaatencion_fecha AS varchar), '-', ' ')
            || ' ' || memo )) as q
        FROM public.sivel2_gen_conscaso1"
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

