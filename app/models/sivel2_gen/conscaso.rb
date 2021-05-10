# encoding: UTF-8

require 'sivel2_sjr/concerns/models/conscaso'

class Sivel2Gen::Conscaso < ActiveRecord::Base
  include Sivel2Sjr::Concerns::Models::Conscaso

   scope :filtro_expulsion_pais_id, lambda { |id|
    where('caso_id IN (SELECT caso_id FROM public.emblematica 
          WHERE emblematica.expulsionpais_id = ?)', id)
  }

  scope :filtro_expulsion_departamento_id, lambda { |id|
    where('caso_id IN (SELECT caso_id FROM public.emblematica 
          WHERE emblematica.expulsiondepartamento_id = ?)', id)
  }

  scope :filtro_expulsion_municipio_id, lambda { |id|
    where('caso_id IN (SELECT caso_id FROM public.emblematica 
          WHERE emblematica.expulsionmunicipio_id = ?)', id)
  }

  scope :filtro_llegada_pais_id, lambda { |id|
    where('caso_id IN (SELECT caso_id FROM public.emblematica 
          WHERE emblematica.llegadapais_id = ?)', id)
  }

  scope :filtro_llegada_departamento_id, lambda { |id|
    where('caso_id IN (SELECT caso_id FROM public.emblematica 
          WHERE emblematica.llegadadepartamento_id = ?)', id)
  }

  scope :filtro_llegada_municipio_id, lambda { |id|
    where('caso_id IN (SELECT caso_id FROM public.emblematica 
          WHERE emblematica.llegadamunicipio_id = ?)', id)
  }

  scope :filtro_numerodocumento, lambda { |a|
    joins('JOIN sivel2_gen_victima ON sivel2_gen_victima.id_caso='+
          'sivel2_gen_conscaso.caso_id').joins('JOIN sip_persona ON '+
          'sivel2_gen_victima.id_persona = sip_persona.id')
      .where('sip_persona.numerodocumento=?', a)
  }

  scope :filtro_tdocumento, lambda { |a|
    joins('JOIN sivel2_gen_victima ON sivel2_gen_victima.id_caso='+
          'sivel2_gen_conscaso.caso_id').joins('JOIN sip_persona ON '+
          'sivel2_gen_victima.id_persona = sip_persona.id')
      .where('sip_persona.tdocumento_id=?', a.to_i)
  }


  def self.refresca_conscaso
    if !ActiveRecord::Base.connection.data_source_exists? 'sivel2_sjr_ultimaatencion_aux'
      ActiveRecord::Base.connection.execute(
        "CREATE OR REPLACE VIEW sivel2_sjr_ultimaatencion_aux AS 
           SELECT ac1.casosjr_id AS caso_id, a1.fecha, a1.id AS actividad_id
           FROM  public.sivel2_sjr_actividad_casosjr AS ac1
             LEFT JOIN public.cor1440_gen_actividad AS a1 ON ac1.actividad_id=a1.id
             WHERE (ac1.casosjr_id, a1.fecha, a1.id) IN
           (SELECT ac2.casosjr_id, a2.fecha, a2.id AS actividad_id
             FROM public.sivel2_sjr_actividad_casosjr AS ac2
             JOIN public.cor1440_gen_actividad AS a2 ON ac2.actividad_id=a2.id
             WHERE ac2.casosjr_id=ac1.casosjr_id
             ORDER BY 2 DESC, 3 DESC LIMIT 1);"
      )
    end
    if !ActiveRecord::Base.connection.data_source_exists? 'sivel2_sjr_ultimaatencion'
      ActiveRecord::Base.connection.execute(
        "CREATE OR REPLACE VIEW sivel2_sjr_ultimaatencion AS 
           SELECT casosjr.id_caso AS caso_id, 
             a.id AS actividad_id,
             a.fecha AS fecha, 
             a.objetivo, 
             a.resultado,
             sip_edad_de_fechanac_fecharef(contacto.anionac, contacto.mesnac, 
               contacto.dianac, CAST(EXTRACT(YEAR FROM a.fecha) AS INTEGER),
               CAST(EXTRACT(MONTH FROM a.fecha) AS INTEGER),
               CAST(EXTRACT(DAY FROM a.fecha) AS INTEGER) ) AS contacto_edad
             FROM sivel2_sjr_ultimaatencion_aux AS uaux 
             JOIN public.cor1440_gen_actividad AS a ON uaux.actividad_id=a.id 
             JOIN public.sivel2_sjr_casosjr AS casosjr ON 
               uaux.caso_id=casosjr.id_caso 
             JOIN public.sip_persona AS contacto ON
               contacto.id=casosjr.contacto_id"
      )
    end

    if !ActiveRecord::Base.connection.data_source_exists? 'sivel2_gen_conscaso'
      ActiveRecord::Base.connection.execute(
        "CREATE OR REPLACE VIEW emblematica1
        AS SELECT *
        FROM ((SELECT 
          caso.id AS caso_id,
          caso.fecha,
          'desplazamiento' AS despomigracion,
          desplazamiento.id AS despomigracion_id,
          ubicacionpreex.id AS expulsionubicacionpre_id,
          paisex.id AS expulsionpais_id,
          paisex.nombre AS expulsionpais,
          departamentoex.id AS expulsiondepartamento_id,
          departamentoex.nombre AS expulsiondepartamento,
          municipioex.id AS expulsionmunicipio_id,
          municipioex.nombre AS expulsionmunicipio,
          COALESCE(municipioex.nombre, '') || ' / ' ||
            COALESCE(departamentoex.nombre, '') || ' / ' ||
            COALESCE(paisex.nombre, '') AS expulsionubicacionpre,
          ubicacionprel.id AS llegadaubicacionpre_id,
          paisl.id AS llegadapais_id,
          paisl.nombre AS llegadapais,
          departamentol.id AS llegadadepartamento_id,
          departamentol.nombre AS llegadadepartamento,
          municipiol.id AS llegadamunicipio_id,
          municipiol.nombre AS llegadamunicipio,
          COALESCE(municipiol.nombre, '') || ' / ' ||
            COALESCE(departamentol.nombre, '') || ' / ' ||
            COALESCE(paisl.nombre, '') AS llegadaubicacionpre
          FROM public.sivel2_sjr_desplazamiento AS desplazamiento
          JOIN sivel2_gen_caso AS caso ON
            desplazamiento.id_caso=caso.id
            AND desplazamiento.fechaexpulsion=caso.fecha
          LEFT JOIN public.sip_ubicacionpre AS ubicacionpreex
            ON ubicacionpreex.id=desplazamiento.expulsionubicacionpre_id
          LEFT JOIN public.sip_pais AS paisex
            ON ubicacionpreex.pais_id=paisex.id
          LEFT JOIN public.sip_departamento AS departamentoex
            ON ubicacionpreex.departamento_id=departamentoex.id
          LEFT JOIN public.sip_municipio AS municipioex
            ON ubicacionpreex.municipio_id=municipioex.id
          LEFT JOIN public.sip_ubicacionpre AS ubicacionprel
            ON ubicacionprel.id=desplazamiento.llegadaubicacionpre_id
          LEFT JOIN public.sip_pais AS paisl
            ON ubicacionprel.pais_id=paisl.id
          LEFT JOIN public.sip_departamento AS departamentol
            ON ubicacionprel.departamento_id=departamentol.id
          LEFT JOIN public.sip_municipio AS municipiol
            ON ubicacionprel.municipio_id=municipiol.id
          ORDER BY desplazamiento.id
          ) UNION
          (SELECT 
          caso.id AS caso_id,
          caso.fecha,
          'migracion' AS despomigracion,
          migracion.id AS despomigracion_id,
          ubicacionpres.id AS expulsionubicacionpre_id,
          paiss.id AS expulsionpais_id,
          paiss.nombre AS expulsionpais,
          departamentos.id AS expulsiondepartamento_id,
          departamentos.nombre AS expulsiondepartamento,
          municipios.id AS expulsionmunicipio_id,
          municipios.nombre AS expulsionmunicipio,
          COALESCE(municipios.nombre, '') || ' / ' ||
            COALESCE(departamentos.nombre, '') || ' / ' ||
            COALESCE(paiss.nombre, '') AS expulsionubicacionpre,
          ubicacionprel.id AS llegadaubicacionpre_id,
          paisl.id AS llegadapais_id,
          paisl.nombre AS llegadapais,
          departamentol.id AS llegadadepartamento_id,
          departamentol.nombre AS llegadadepartamento,
          municipiol.id AS llegadamunicipio_id,
          municipiol.nombre AS llegadamunicipio,
          COALESCE(municipiol.nombre, '') || ' / ' ||
            COALESCE(departamentol.nombre, '') || ' / ' ||
            COALESCE(paisl.nombre, '') AS llegadaubicacionpre
          FROM public.sivel2_sjr_migracion AS migracion
          JOIN sivel2_gen_caso AS caso ON
            migracion.caso_id=caso.id
            AND migracion.fechasalida=caso.fecha
          LEFT JOIN public.sip_ubicacionpre AS ubicacionpres
            ON ubicacionpres.id=migracion.salidaubicacionpre_id
          LEFT JOIN public.sip_pais AS paiss
            ON ubicacionpres.pais_id=paiss.id
          LEFT JOIN public.sip_departamento AS departamentos
            ON ubicacionpres.departamento_id=departamentos.id
          LEFT JOIN public.sip_municipio AS municipios
            ON ubicacionpres.municipio_id=municipios.id
          LEFT JOIN public.sip_ubicacionpre AS ubicacionprel
            ON ubicacionprel.id=migracion.llegadaubicacionpre_id
          LEFT JOIN public.sip_pais AS paisl
            ON ubicacionprel.pais_id=paisl.id
          LEFT JOIN public.sip_departamento AS departamentol
            ON ubicacionprel.departamento_id=departamentol.id
          LEFT JOIN public.sip_municipio AS municipiol
            ON ubicacionprel.municipio_id=municipiol.id
          ORDER BY migracion.id
          ) 
          ) AS sub
        ORDER BY caso_id
      ")
      ActiveRecord::Base.connection.execute(
        "CREATE OR REPLACE VIEW emblematica
        AS SELECT 
          caso.id AS caso_id,
          caso.fecha,
          (SELECT despomigracion FROM emblematica1 WHERE caso_id=caso.id LIMIT 1) AS despomigracion,
          (SELECT despomigracion_id FROM emblematica1 WHERE caso_id=caso.id LIMIT 1) AS despomigracion_id,
          (SELECT expulsionubicacionpre_id FROM emblematica1 WHERE caso_id=caso.id LIMIT 1) AS expulsionubicacionpre_id,
          (SELECT expulsionpais_id FROM emblematica1 WHERE caso_id=caso.id LIMIT 1) AS expulsionpais_id,
          (SELECT expulsionpais FROM emblematica1 WHERE caso_id=caso.id LIMIT 1) AS expulsionpais,
          (SELECT expulsiondepartamento_id FROM emblematica1 WHERE caso_id=caso.id LIMIT 1) AS expulsiondepartamento_id,
          (SELECT expulsiondepartamento FROM emblematica1 WHERE caso_id=caso.id LIMIT 1) AS expulsiondepartamento,
          (SELECT expulsionmunicipio_id FROM emblematica1 WHERE caso_id=caso.id LIMIT 1) AS expulsionmunicipio_id,
          (SELECT expulsionmunicipio FROM emblematica1 WHERE caso_id=caso.id LIMIT 1) AS expulsionmunicipio,
          (SELECT expulsionubicacionpre FROM emblematica1 WHERE caso_id=caso.id LIMIT 1) AS expulsionubicacionpre,
          (SELECT llegadaubicacionpre_id FROM emblematica1 WHERE caso_id=caso.id LIMIT 1) AS llegadaubicacionpre_id,
          (SELECT llegadapais_id FROM emblematica1 WHERE caso_id=caso.id LIMIT 1) AS llegadapais_id,
          (SELECT llegadapais FROM emblematica1 WHERE caso_id=caso.id LIMIT 1) AS llegadapais,
          (SELECT llegadadepartamento_id FROM emblematica1 WHERE caso_id=caso.id LIMIT 1) AS llegadadepartamento_id,
          (SELECT llegadadepartamento FROM emblematica1 WHERE caso_id=caso.id LIMIT 1) AS llegadadepartamento,
          (SELECT llegadamunicipio_id FROM emblematica1 WHERE caso_id=caso.id LIMIT 1) AS llegadamunicipio_id,
          (SELECT llegadamunicipio FROM emblematica1 WHERE caso_id=caso.id LIMIT 1) AS llegadamunicipio,
          (SELECT llegadaubicacionpre FROM emblematica1 WHERE caso_id=caso.id LIMIT 1) AS llegadaubicacionpre
          FROM sivel2_gen_caso AS caso
        ")

      ActiveRecord::Base.connection.execute(
        "CREATE OR REPLACE VIEW sivel2_gen_conscaso1 
        AS SELECT casosjr.id_caso AS caso_id, 
        (contacto.nombres || ' ' || contacto.apellidos) AS contacto,
        ultimaatencion.fecha AS ultimaatencion_fecha,
        casosjr.fecharec,
        oficina.nombre AS oficina,
        usuario.nusuario,
        caso.fecha AS fecha,
        (SELECT expulsionubicacionpre FROM 
          emblematica WHERE emblematica.caso_id=caso.id LIMIT 1) AS expulsion,
        (SELECT llegadaubicacionpre FROM 
          emblematica WHERE emblematica.caso_id=caso.id LIMIT 1) AS llegada,
        caso.memo AS memo
        FROM public.sivel2_sjr_casosjr AS casosjr 
          JOIN public.sivel2_gen_caso AS caso ON casosjr.id_caso = caso.id 
          JOIN public.sip_oficina AS oficina ON oficina.id=casosjr.oficina_id
          JOIN public.usuario ON usuario.id = casosjr.asesor
          JOIN public.sip_persona AS contacto ON contacto.id=casosjr.contacto_id
          JOIN public.sivel2_gen_victima AS vcontacto ON 
            vcontacto.id_persona = contacto.id AND vcontacto.id_caso = caso.id
          LEFT JOIN public.sivel2_sjr_ultimaatencion AS ultimaatencion ON
            ultimaatencion.caso_id = caso.id
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

