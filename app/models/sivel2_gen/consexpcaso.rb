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

  def presenta(atr)
    casosjr = Sivel2Sjr::Casosjr.find(caso_id)
    contacto =  Sip::Persona.find(casosjr.contacto_id)
    victimac = Sivel2Gen::Victima.where(id_persona: contacto.id)[0]
    victimasjrc = Sivel2Sjr::Victimasjr.where(id_victima: victimac.id)[0]
    ## 5 Victimas
    cpersonasimple = [
         'nombres', 'apellidos', 'sexo', 'anionac', 'mesnac', 'dianac',
         'numerodocumento']
    cpersonadoble = ['tdocumento', 'pais', 'departamento', 'municipio', 'clase']
    cvictimasimple = [ 'orientacionsexual']
    cvictimadoble = [ 'etnia', 'profesion', 'organizacion', 
                      'filiacion', 'vinculoestado']
    cvictimasjrbool = [
         'cabezafamilia', 'tienesisben', 'asisteescuela',
         'actualtrabajando']
    cvictimasjrdoble = [
         'maternidad', 'estadocivil', 'discapacidad', 'rolfamilia', 
         'regimensalud', 'escolaridad']
    ccasosjr = ['comosupo', 'consentimientosjr', 'consentimientobd']
    especiales = ['actividadoficio', 'numeroanexos', 'numeroanexosconsen']

    m = /familiar(.*)$/.match(atr.to_s)
    if m
      numero = m[1].split("_")[0]
      campo = m[1].split("_")[1]
      victimasf = Sivel2Gen::Victima.where(id_caso: caso_id).where.not(id_persona: contacto.id)
      if !victimasf.empty?
        victimaf = victimasf[numero.to_i-1]
        if victimaf
          personaf = Sip::Persona.find(victimaf.id_persona)
          victimasjrf = Sivel2Sjr::Victimasjr.where(id_victima: victimaf.id)[0]
          if cpersonasimple.include? campo
            return personaf.send(campo)
          end
          if cpersonadoble.include? campo
            return personaf.send(campo).nombre if personaf.send(campo)
          end
          if cvictimasimple.include? campo
            return victimaf.send(campo)
          end
          if cvictimadoble.include? campo
            return victimaf.send(campo).nombre if victimaf.send(campo)
          end
          if cvictimasjrdoble.include? campo
            return victimasjrf.send(campo).nombre if victimasjrf.send(campo)
          end
          if cvictimasjrbool.include? campo
            if victimasjrf.send(campo)
              return "Si"
            else 
              return victimasjrf.send(campo).nil? ? "No responde" : "No"
            end
          end
          if especiales.include? campo
            case campo.to_s
            when 'actividadoficio'
              return Sivel2Gen::Actividadoficio.find(victimasjrf.id_actividadoficio).nombre if victimasjrf.id_actividadoficio
            when 'numeroanexos'
              return Sivel2Gen::AnexoVictima.where(victima_id: victimaf.id).where.not(tipoanexo_id: 11).count.to_s
            when 'numeroanexosconsen'
              return Sivel2Gen::AnexoVictima.where(victima_id: victimaf.id, tipoanexo_id: 11).count.to_s
            end
          end
        end
      end
    end
    case atr.to_s
    when 'contacto_anionac'
      contacto.anionac
    when 'contacto_mesnac'
      contacto.mesnac
    when 'contacto_dianac'
      contacto.dianac
    when 'contacto_tdocumento'
      contacto.tdocumento.nombre if contacto.tdocumento
    when 'contacto_numerodocumento'
      contacto.numerodocumento
    when 'contacto_pais'
      contacto.pais.nombre if contacto.pais
    when 'contacto_departamento'
      contacto.departamento.nombre if contacto.departamento
    when 'contacto_municipio'
      contacto.municipio.nombre if contacto.municipio
    when 'contacto_clase'
      contacto.clase.nombre if contacto.clase
    when 'telefono'
      casosjr.telefono
    when 'direccion'
      casosjr.direccion
    when 'contacto_numeroanexos'
      Sivel2Gen::AnexoVictima.where(victima_id: victimac.id).where.not(tipoanexo_id: 11).count.to_s
    when 'contacto_numeroanexosconsen'
      Sivel2Gen::AnexoVictima.where(victima_id: victimac.id, tipoanexo_id: 11).count.to_s
    when 'contacto_etnia'
      victimac.etnia.nombre
    when 'contacto_orientacionsexual'
      victimac.orientacionsexual
    when 'contacto_maternidad'
      victimasjrc.maternidad.nombre
    when 'contacto_estadocivil'
      victimasjrc.estadocivil.nombre
    when 'contacto_discapacidad'
      victimasjrc.discapacidad.nombre
    when 'contacto_cabezafamilia'
      if victimasjrc.cabezafamilia
        "Si"
      else 
        victimasjrc.cabezafamilia.nil? ? "No responde" : "No"
      end
    when 'contacto_rolfamilia'
      victimasjrc.rolfamilia.nombre
    when 'contacto_tienesisben'
      if victimasjrc.tienesisben
        "Si"
      else 
        victimasjrc.tienesisben.nil? ? "No responde" : "No"
      end
    when 'contacto_regimensalud'
      victimasjrc.regimensalud.nombre
    when 'contacto_asisteescuela'
      if victimasjrc.asisteescuela
        "Si"
      else 
        victimasjrc.asisteescuela.nil? ? "No responde" : "No"
      end
    when 'contacto_escolaridad'
      victimasjrc.escolaridad.nombre
    when 'contacto_actualtrabajando'
      if victimasjrc.actualtrabajando
        "Si"
      else 
        victimasjrc.actualtrabajando.nil? ? "No responde" : "No"
      end
    when 'contacto_profesion'
      victimac.profesion.nombre
    when 'contacto_actividadoficio'
      Sivel2Gen::Actividadoficio.find(victimasjrc.id_actividadoficio).nombre
    when 'contacto_filiacion'
      victimac.filiacion.nombre
    when 'contacto_organizacion'
      victimac.organizacion.nombre
    when 'contacto_vinculoestado'
      victimac.vinculoestado.nombre
    when 'contacto_comosupo'
      casosjr.comosupo.nombre
    when 'contacto_consentimientosjr'
      casosjr.concentimientosjr ? "Si" : "No"
    when 'contacto_consentimientobd'
      casosjr.concentimientobd ? "Si" : "No"
    else
      if respond_to?(atr)
        send(atr)
      else
        "Atributo no definido #{atr}"
      end
    end
  end
  
  def self.porsjrc
    "porsjrc"
  end

end # module ClassMethods



