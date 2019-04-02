# encoding: UTF-8

require 'sivel2_sjr/concerns/models/consexpcaso'

class Sivel2Gen::Consexpcaso < ActiveRecord::Base
  include Sivel2Sjr::Concerns::Models::Consexpcaso
  
  def self.consulta_consexpcaso
        "SELECT conscaso.caso_id,
        conscaso.fecharec AS fecharecepcion,
        conscaso.nusuario AS asesor,
        conscaso.oficina,
        conscaso.fecha AS fechadespemb,
        conscaso.expulsion,
        conscaso.llegada,
        conscaso.memo AS descripcion,
        CAST(EXTRACT(MONTH FROM ultimaatencion.fechaatencion) AS INTEGER) AS ultimaatencion_mes,
        conscaso.ultimaatencion_fecha,
        conscaso.contacto,
        contacto.nombres AS contacto_nombres,
        contacto.apellidos AS contacto_apellidos,
        (COALESCE(tdocumento.sigla, '') || ' ' || contacto.numerodocumento) 
          AS contacto_identificacion,
        contacto.sexo AS contacto_sexo,
        COALESCE(etnia.nombre, '') AS contacto_etnia,
        ultimaatencion.contacto_edad AS contacto_edad_ultimaatencion,
        (SELECT rango FROM public.sivel2_gen_rangoedad 
          WHERE fechadeshabilitacion IS NULL 
          AND limiteinferior<=ultimaatencion.contacto_edad AND 
          ultimaatencion.contacto_edad<=limitesuperior LIMIT 1) 
        AS contacto_rangoedad_ultimaatencion,
        (SELECT COUNT(*) FROM 
          public.sivel2_gen_victima AS victima JOIN public.sip_persona ON
            sip_persona.id=victima.id_persona
          WHERE victima.id_caso=caso.id AND sip_persona.sexo='M' 
          AND id_rangoedad='7') AS beneficiarios_0_5,
        (SELECT COUNT(*) FROM 
          public.sivel2_gen_victima AS victima JOIN public.sip_persona ON
            sip_persona.id=victima.id_persona
          WHERE victima.id_caso=caso.id AND sip_persona.sexo='M' 
          AND id_rangoedad='8') AS beneficiarios_6_12,
        (SELECT COUNT(*) FROM 
          public.sivel2_gen_victima AS victima JOIN public.sip_persona ON
            sip_persona.id=victima.id_persona
          WHERE victima.id_caso=caso.id AND sip_persona.sexo='M' 
          AND id_rangoedad='9') AS beneficiarios_13_17,
        (SELECT COUNT(*) FROM 
          public.sivel2_gen_victima AS victima JOIN public.sip_persona ON
            sip_persona.id=victima.id_persona
          WHERE victima.id_caso=caso.id AND sip_persona.sexo='M' 
          AND id_rangoedad='10') AS beneficiarios_18_26,
        (SELECT COUNT(*) FROM 
          public.sivel2_gen_victima AS victima JOIN public.sip_persona ON
            sip_persona.id=victima.id_persona
          WHERE victima.id_caso=caso.id AND sip_persona.sexo='M' 
          AND id_rangoedad='10') AS beneficiarios_27_59,
        (SELECT COUNT(*) FROM 
          public.sivel2_gen_victima AS victima JOIN public.sip_persona ON
            sip_persona.id=victima.id_persona
          WHERE victima.id_caso=caso.id AND sip_persona.sexo='M' 
          AND id_rangoedad='10') AS beneficiarios_60_,

        (SELECT COUNT(*) FROM 
          public.sivel2_gen_victima AS victima JOIN public.sip_persona ON
            sip_persona.id=victima.id_persona
          WHERE victima.id_caso=caso.id AND sip_persona.sexo='F' 
          AND id_rangoedad='7') AS beneficiarias_0_5,
        (SELECT COUNT(*) FROM 
          public.sivel2_gen_victima AS victima JOIN public.sip_persona ON
            sip_persona.id=victima.id_persona
          WHERE victima.id_caso=caso.id AND sip_persona.sexo='F' 
          AND id_rangoedad='8') AS beneficiarias_6_12,
        (SELECT COUNT(*) FROM 
          public.sivel2_gen_victima AS victima JOIN public.sip_persona ON
            sip_persona.id=victima.id_persona
          WHERE victima.id_caso=caso.id AND sip_persona.sexo='F' 
          AND id_rangoedad='9') AS beneficiarias_13_17,
        (SELECT COUNT(*) FROM 
          public.sivel2_gen_victima AS victima JOIN public.sip_persona ON
            sip_persona.id=victima.id_persona
          WHERE victima.id_caso=caso.id AND sip_persona.sexo='F' 
          AND id_rangoedad='10') AS beneficiarias_18_26,
        (SELECT COUNT(*) FROM 
          public.sivel2_gen_victima AS victima JOIN public.sip_persona ON
            sip_persona.id=victima.id_persona
          WHERE victima.id_caso=caso.id AND sip_persona.sexo='F' 
          AND id_rangoedad='10') AS beneficiarias_27_59,
        (SELECT COUNT(*) FROM 
          public.sivel2_gen_victima AS victima JOIN public.sip_persona ON
            sip_persona.id=victima.id_persona
          WHERE victima.id_caso=caso.id AND sip_persona.sexo='F' 
          AND id_rangoedad='10') AS beneficiarias_60_,

        ARRAY_TO_STRING(ARRAY(SELECT nombre FROM public.sivel2_sjr_derecho 
          JOIN public.sivel2_sjr_derecho_respuesta ON id_derecho=sivel2_sjr_derecho.id
          WHERE id_respuesta=ultimaatencion.id), ', ')
          AS ultimaatencion_derechosvul,
        ARRAY_TO_STRING(ARRAY(SELECT nombre FROM public.sivel2_sjr_ayudasjr
          JOIN public.sivel2_sjr_ayudasjr_respuesta ON id_ayudasjr=sivel2_sjr_ayudasjr.id
          WHERE id_respuesta=ultimaatencion.id), ', ') || 
          ' ' || ultimaatencion.detallear AS ultimaatencion_as_humanitaria,
        ARRAY_TO_STRING(ARRAY(SELECT nombre FROM public.sivel2_sjr_aslegal
          JOIN public.sivel2_sjr_aslegal_respuesta ON id_aslegal=sivel2_sjr_aslegal.id
          WHERE id_respuesta=ultimaatencion.id), ', ') || 
          ' ' || ultimaatencion.detalleal AS ultimaatencion_as_juridica,
        ARRAY_TO_STRING(ARRAY(SELECT nombre FROM public.sivel2_sjr_motivosjr
          JOIN public.sivel2_sjr_motivosjr_respuesta ON id_motivosjr=sivel2_sjr_motivosjr.id
          WHERE id_respuesta=ultimaatencion.id), ', ') || 
          ' ' || ultimaatencion.detallemotivo AS ultimaatencion_otros_ser_as,
        ultimaatencion.descatencion AS ultimaatencion_descripcion_at,
        ARRAY_TO_STRING(ARRAY(SELECT supracategoria.id_tviolencia || ':' || 
          categoria.supracategoria_id || ':' || categoria.id || ' ' ||
          categoria.nombre FROM public.sivel2_gen_categoria AS categoria, 
          public.sivel2_gen_supracategoria AS supracategoria,
          public.sivel2_gen_acto AS acto
          WHERE categoria.id=acto.id_categoria
          AND supracategoria.id=categoria.supracategoria_id
          AND acto.id_caso=caso.id), ', ')
        AS tipificacion,
        ARRAY_TO_STRING(ARRAY(SELECT nombres || ' ' || apellidos 
          FROM public.sip_persona AS persona, 
          public.sivel2_gen_victima AS victima WHERE persona.id=victima.id_persona 
          AND victima.id_caso=caso.id), ', ')
        AS victimas, 
        ARRAY_TO_STRING(ARRAY(SELECT departamento.nombre ||  ' / ' 
          || municipio.nombre 
          FROM public.sip_ubicacion AS ubicacion 
					LEFT JOIN public.sip_departamento AS departamento 
						ON (ubicacion.id_departamento = departamento.id)
        	LEFT JOIN public.sip_municipio AS municipio 
						ON (ubicacion.id_municipio=municipio.id)
          WHERE ubicacion.id_caso=caso.id), ', ')
        AS ubicaciones, 
        ARRAY_TO_STRING(ARRAY(SELECT nombre 
          FROM public.sivel2_gen_presponsable AS presponsable, 
          public.sivel2_gen_caso_presponsable AS caso_presponsable
          WHERE presponsable.id=caso_presponsable.id_presponsable
          AND caso_presponsable.id_caso=caso.id), ', ')
        AS presponsables, 
        casosjr.memo1612 as memo1612
        FROM public.sivel2_gen_conscaso AS conscaso
        JOIN public.sivel2_sjr_casosjr AS casosjr ON casosjr.id_caso=conscaso.caso_id
        JOIN public.sivel2_gen_caso AS caso ON casosjr.id_caso = caso.id 
        JOIN public.sip_oficina AS oficina ON oficina.id=casosjr.oficina_id
        JOIN public.usuario ON usuario.id = casosjr.asesor
        JOIN public.sip_persona as contacto ON contacto.id=casosjr.contacto_id
        LEFT JOIN public.sip_tdocumento AS tdocumento ON 
            tdocumento.id=contacto.tdocumento_id
        JOIN public.sivel2_gen_victima AS vcontacto ON 
            vcontacto.id_persona = contacto.id AND vcontacto.id_caso = caso.id
        LEFT JOIN public.sivel2_gen_etnia AS etnia ON
            vcontacto.id_etnia=etnia.id
        LEFT JOIN public.sivel2_sjr_ultimaatencion AS ultimaatencion ON
            ultimaatencion.id_caso = caso.id
      "
  end
  
  def self.porsjrc
    "porsjrc"
  end

end

