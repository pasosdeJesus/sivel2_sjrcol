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
        CAST(EXTRACT(MONTH FROM ultimaatencion.fecha) AS INTEGER) AS ultimaatencion_mes,
        conscaso.ultimaatencion_fecha,
        conscaso.contacto,
        contacto.nombres AS contacto_nombres,
        contacto.apellidos AS contacto_apellidos,
        (COALESCE(tdocumento.sigla, '') || ' ' || contacto.numerodocumento) 
          AS contacto_identificacion,
        contacto.sexo AS contacto_sexo,
        sip_edad_de_fechanac_fecharef(
          contacto.anionac, contacto.mesnac, contacto.dianac, 
          CAST(EXTRACT(YEAR FROM conscaso.fecharec) AS INTEGER),
          CAST(EXTRACT(MONTH FROM conscaso.fecharec) AS INTEGER),
          CAST(EXTRACT(DAY FROM conscaso.fecharec) AS INTEGER))
          AS contacto_edad_fecharec,
        (SELECT rango FROM public.sivel2_gen_rangoedad 
          WHERE fechadeshabilitacion IS NULL 
          AND limiteinferior<=
            sip_edad_de_fechanac_fecharef(
            contacto.anionac, contacto.mesnac, contacto.dianac, 
            CAST(EXTRACT(YEAR FROM conscaso.fecharec) AS INTEGER),
            CAST(EXTRACT(MONTH FROM conscaso.fecharec) AS INTEGER),
            CAST(EXTRACT(DAY FROM conscaso.fecharec) AS INTEGER))
          AND limitesuperior>=
            sip_edad_de_fechanac_fecharef(
            contacto.anionac, contacto.mesnac, contacto.dianac, 
            CAST(EXTRACT(YEAR FROM conscaso.fecharec) AS INTEGER),
            CAST(EXTRACT(MONTH FROM conscaso.fecharec) AS INTEGER),
            CAST(EXTRACT(DAY FROM conscaso.fecharec) AS INTEGER))
          LIMIT 1) AS contacto_rangoedad_fecharec,
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
          AND id_rangoedad='11') AS beneficiarios_27_59,
        (SELECT COUNT(*) FROM 
          public.sivel2_gen_victima AS victima JOIN public.sip_persona ON
            sip_persona.id=victima.id_persona
          WHERE victima.id_caso=caso.id AND sip_persona.sexo='M' 
          AND id_rangoedad='12') AS beneficiarios_60_,
        (SELECT COUNT(*) FROM 
          public.sivel2_gen_victima AS victima JOIN public.sip_persona ON
            sip_persona.id=victima.id_persona
          WHERE victima.id_caso=caso.id AND sip_persona.sexo='M' 
          AND id_rangoedad='6') AS beneficiarios_se,

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
          AND id_rangoedad='11') AS beneficiarias_27_59,
        (SELECT COUNT(*) FROM 
          public.sivel2_gen_victima AS victima JOIN public.sip_persona ON
            sip_persona.id=victima.id_persona
          WHERE victima.id_caso=caso.id AND sip_persona.sexo='F' 
          AND id_rangoedad='12') AS beneficiarias_60_,
        (SELECT COUNT(*) FROM 
          public.sivel2_gen_victima AS victima JOIN public.sip_persona ON
            sip_persona.id=victima.id_persona
          WHERE victima.id_caso=caso.id AND sip_persona.sexo='F' 
          AND id_rangoedad='6') AS beneficiarias_se,

        (SELECT COUNT(*) FROM 
          public.sivel2_gen_victima AS victima JOIN public.sip_persona ON
            sip_persona.id=victima.id_persona
          WHERE victima.id_caso=caso.id AND sip_persona.sexo='S' 
          AND id_rangoedad='7') AS beneficiarios_ss_0_5,
        (SELECT COUNT(*) FROM 
          public.sivel2_gen_victima AS victima JOIN public.sip_persona ON
            sip_persona.id=victima.id_persona
          WHERE victima.id_caso=caso.id AND sip_persona.sexo='S' 
          AND id_rangoedad='8') AS beneficiarios_ss_6_12,
        (SELECT COUNT(*) FROM 
          public.sivel2_gen_victima AS victima JOIN public.sip_persona ON
            sip_persona.id=victima.id_persona
          WHERE victima.id_caso=caso.id AND sip_persona.sexo='S' 
          AND id_rangoedad='9') AS beneficiarios_ss_13_17,
        (SELECT COUNT(*) FROM 
          public.sivel2_gen_victima AS victima JOIN public.sip_persona ON
            sip_persona.id=victima.id_persona
          WHERE victima.id_caso=caso.id AND sip_persona.sexo='S' 
          AND id_rangoedad='10') AS beneficiarios_ss_18_26,
        (SELECT COUNT(*) FROM 
          public.sivel2_gen_victima AS victima JOIN public.sip_persona ON
            sip_persona.id=victima.id_persona
          WHERE victima.id_caso=caso.id AND sip_persona.sexo='S' 
          AND id_rangoedad='11') AS beneficiarios_ss_27_59,
        (SELECT COUNT(*) FROM 
          public.sivel2_gen_victima AS victima JOIN public.sip_persona ON
            sip_persona.id=victima.id_persona
          WHERE victima.id_caso=caso.id AND sip_persona.sexo='S' 
          AND id_rangoedad='12') AS beneficiarios_ss_60_,
        (SELECT COUNT(*) FROM 
          public.sivel2_gen_victima AS victima JOIN public.sip_persona ON
            sip_persona.id=victima.id_persona
          WHERE victima.id_caso=caso.id AND sip_persona.sexo='S' 
          AND id_rangoedad='6') AS beneficiarios_ss_se,

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
        casosjr.memo1612 as memo1612,
        ultimaatencion.actividad_id AS ultimaatencion_actividad_id
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
            ultimaatencion.caso_id = caso.id
      "
  end


  def resp_ultimaatencion(formulario_id, campo_id)
    ultatencion = Cor1440Gen::Actividad.
      where(id: ultimaatencion_actividad_id).take
    if !ultatencion
      return "Problema no existe actividad #{ultimaatencion_actividad_id}"
    end
    r =  Mr519Gen::ApplicationHelper.presenta_valor(
      ultatencion, formulario_id, campo_id)
    r ? r : ''
  end

  # Retorna cantidad de víctimas del caso caso_id
  # que tienen el sexo dado con edad entre inf y sup para la fecha
  # de la actividad con id actividad_id.
  # Caso especiales: 
  #   * si inf es nil peor sup no busca víctimas hasta de sup años
  #   * si inf no es nil pero sup es nil búsca víctimas desde inf años
  #   * si tanto inf como sup son nil busca víctimas sin edad
  #
  # Caso especial si inf y sup son nil busca víctimas sin edad
  def self.poblacion_ultimaatencion(caso_id, actividad_id, sexo, inf, sup)
    ultatencion = Cor1440Gen::Actividad.
      where(id: actividad_id).take
    if !ultatencion
      return "Problema no existe actividad #{actividad_id}"
    end

    cond_edad = ''
    if inf && inf >= 0
      cond_edad += " AND ua_edad>='#{inf}'"
    end
    if sup && sup >= 0
      cond_edad += " AND ua_edad<='#{sup}'"
    end
    if !inf && !sup
      cond_edad += " AND ua_edad IS NULL"
    end

    r=Sivel2Gen::Victima.connection.execute("
        SELECT COUNT(*) FROM (
          SELECT v.id, sip_edad_de_fechanac_fecharef(
            p.anionac, p.mesnac, p.dianac,
            '#{ultatencion.fecha.year}',
            '#{ultatencion.fecha.month}',
            '#{ultatencion.fecha.day}') AS ua_edad 
          FROM public.sivel2_gen_victima AS v
          JOIN public.sip_persona AS p ON p.id=v.id_persona
          WHERE v.id_caso='#{caso_id}' AND 
           p.sexo='#{sexo}') AS sub
        WHERE TRUE=TRUE 
        #{cond_edad}")
    return   r[0]['count'].to_i
  end


  def presenta(atr)
    casosjr = Sivel2Sjr::Casosjr.find(caso_id)
    contacto =  Sip::Persona.find(casosjr.contacto_id)
    victimac = Sivel2Gen::Victima.where(id_persona: contacto.id)[0]
    victimasjrc = Sivel2Sjr::Victimasjr.where(id_victima: victimac.id)[0]

    ## 3 primeras ubicaciones
    cubidob = ['pais', 'departamento', 'municipio', 'clase', 'tsitio']
    cubisim = ['longitud', 'latitud', 'sitio', 'lugar']
    cubi = /ubicacion(.*)$/.match(atr.to_s)
    ubicaciones = Sivel2Gen::Caso.find(caso_id).ubicacion
    if cubi
      numero = cubi[1].split("_")[0]
      campo = cubi[1].split("_")[1]
      if ubicaciones.count >= numero.to_i
        ubicacion = ubicaciones[numero.to_i-1]
        if ubicacion
          if cubidob.include? campo
            return ubicacion.send(campo) ? ubicacion.send(campo).nombre : ''
          end
          if cubisim.include? campo
            return ubicacion.send(campo) ?  ubicacion.send(campo) : ''
          end
        end
      else
        return ''
      end
    end
    ## 3 primeros presuntos responsables
    cprdob = ['presponsable']
    cprsim = ['bloque', 'frente', 'brigada', 'batallon', 'division', 'otro']
    cpr = /presponsable(.*)$/.match(atr.to_s)
    presponsables = Sivel2Gen::CasoPresponsable.where(id_caso: caso_id)
    if cpr
      numero = cpr[1].split("_")[0]
      campo = cpr[1].split("_")[1]
      if !presponsables.empty?
        presponsable = presponsables[numero.to_i-1]
        if presponsable
          if cprdob.include? campo
            return presponsable.send(campo) ? presponsable.send(campo).nombre : ''
          end
          if cprsim.include? campo
            return presponsable.send(campo) ?  presponsable.send(campo) : ''
          end
        else
          if cprdob.include? campo or cprsim.include? campo
            return ''
          end
        end
      else
        if cprdob.include? campo or cprsim.include? campo
          return ''
        end
      end
    end

    ## 5 primeros actos
    cacto = /acto(.*)$/.match(atr.to_s)
    actos = Sivel2Gen::Acto.where(id_caso: caso_id)
    if cacto
      numero = cacto[1].split("_")[0]
      campo = cacto[1].split("_")[1]
      if !actos.empty?
        acto = actos[numero.to_i-1]
        if acto
          actosjr = Sivel2Sjr::Actosjr.where(id_acto: acto.id)[0]
          case campo
          when 'presponsable', 'categoria'
            return acto.send(campo) ? acto.send(campo).nombre : ''
          when 'persona'
            return acto.send(campo) ? acto.send(campo).nombres : ''
          when 'fecha'
            return actosjr ? actosjr.fecha : ''
          when 'desplazamiento'
            desplaza = Sivel2Sjr::Desplazamiento.where(id: actosjr.desplazamiento_id)[0]
            return desplaza ? desplaza.fechaexpulsion : ''
          end
        else
          case campo
          when 'presponsable', 'categoria', 'persona', 'fecha', 'desplazamiento'
            return ''
          end
        end
      else
        case campo
        when 'presponsable', 'categoria', 'persona', 'fecha', 'desplazamiento'
          return ''
        end
      end
    end

    ## 3 primeros presuntos responsables
    cprdob = ['presponsable']
    cprsim = ['bloque', 'frente', 'brigada', 'batallon', 'division', 'otro']
    cpr = /presponsable(.*)$/.match(atr.to_s)
    presponsables = Sivel2Gen::CasoPresponsable.where(id_caso: caso_id)
    if cpr
      numero = cpr[1].split("_")[0]
      campo = cpr[1].split("_")[1]
      if !presponsables.empty?
        presponsable = presponsables[numero.to_i-1]
        if presponsable
          if cprdob.include? campo
            return presponsable.send(campo) ? presponsable.send(campo).nombre : ''
          end
          if cprsim.include? campo
            return presponsable.send(campo) ?  presponsable.send(campo) : ''
          end
        else
          if cprdob.include? campo or cprsim.include? campo
            return ''
          end
        end
      else
        if cprdob.include? campo or cprsim.include? campo
          return ''
        end
      end
    end

    # Desplazamiento del Caso
    desplaza_simples = ::Ability::CAMPOS_DESPLAZA_SIMPLES
    desplaza_rela = ::Ability::CAMPOS_DESPLAZA_RELA
    desplaza_multi = ::Ability::CAMPOS_DESPLAZA_MULTI
    desplaza_bool = ::Ability::CAMPOS_DESPLAZA_BOOL
    desplaza_espe = ::Ability::CAMPOS_DESPLAZA_ESPECIALES
    desplazamiento = Sivel2Sjr::Desplazamiento.where(id_caso: caso_id)[0]
    if desplaza_simples.include? atr.to_s
      if desplazamiento
        if atr.to_s == 'declaro'
          case desplazamiento.send(atr.to_s)
          when 'S'
            return 'Si'
          when 'N'
            return 'No'
          when 'R'
            return 'NO SABE / NO RESPONDE'
          end
        else
          return desplazamiento.send(atr.to_s) ? desplazamiento.send(atr.to_s) : ''
        end
      else
        return ''
      end
    end
    if desplaza_rela.include? atr.to_s
      if desplazamiento
        return desplazamiento.send(atr.to_s).nil? ? "No aplica o nulo" : desplazamiento.send(atr.to_s).nombre
      else
        return ''
      end
    end
    if desplaza_multi.include? atr.to_s
      if desplazamiento
        return desplazamiento.send(atr.to_s).count > 0 ? desplazamiento.send(atr.to_s).pluck(:nombre).join(", ") : ''
      else
        return ''
      end
    end
    if desplaza_bool.include? atr.to_s
      if desplazamiento
        if desplazamiento.send(atr.to_s)
          return "Si"
        else
          return desplazamiento.send(atr.to_s).nil? ? 'No responde' : 'No'
        end
      else
        return ''
      end
    end
    if desplaza_espe.include? atr.to_s
      if desplazamiento
        exp = desplazamiento.expulsion
        lle = desplazamiento.llegada
        res = ::DesplazamientoHelper.modageo_desplazamiento(exp, lle)
        case atr.to_s
        when 'expulsion', 'llegada'
          return desplazamiento.send(atr.to_s) ? Sip::UbicacionHelper.formato_ubicacion(desplazamiento.send(atr.to_s)) : ''
        when 'modalidadgeo'
          return res ? res[0] : ''
        when 'submodalidadgeo'
          return res ? res[1] : ''
        end
      else
        return ''
      end
    end

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
    especiales = ['actividadoficio', 'numeroanexos', 'numeroanexosconsen']
    orientaciones = Sip::OrientacionsexualHelper::ORIENTACIONES
    m = /familiar(.*)$/.match(atr.to_s)
    if m
      numero = m[1].split("_")[0]
      campo = m[1].split("_")[1]
      victimasf = Sivel2Gen::Victima.where(id_caso: caso_id).where.not(id_persona: contacto.id).order(:id)
      if !victimasf.empty?
        victimaf = victimasf[numero.to_i-1]
        if !victimaf.nil?
          personaf = Sip::Persona.find(victimaf.id_persona)
          victimasjrf = Sivel2Sjr::Victimasjr.where(id_victima: victimaf.id)[0]
          if cpersonasimple.include? campo
            return personaf.send(campo) ? personaf.send(campo) : ''
          end
          if cpersonadoble.include? campo
            return personaf.send(campo) ? personaf.send(campo).nombre : ''
          end
          if cvictimasimple.include? campo
            if victimaf.send(campo) and campo == "orientacionsexual"
              orientaciones.each do |ori|
                if ori[1].to_s == victimaf.send(campo).to_s
                  return ori[0].to_s
                end
              end
            else
              return victimaf.send(campo) ? victimaf.send(campo) : ''
            end
          end
          if cvictimadoble.include? campo
            return victimaf.send(campo) ? victimaf.send(campo).nombre : ''
          end
          if cvictimasjrdoble.include? campo
            return victimasjrf.send(campo) ? victimasjrf.send(campo).nombre : ''
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
              aof = Sivel2Gen::Actividadoficio.find(victimasjrf.id_actividadoficio)
              return aof ? aof.nombre : ''
            when 'numeroanexos'
              return Sivel2Gen::AnexoVictima.where(victima_id: victimaf.id).where.not(tipoanexo_id: 11).count.to_s
            when 'numeroanexosconsen'
              return Sivel2Gen::AnexoVictima.where(victima_id: victimaf.id, tipoanexo_id: 11).count.to_s
            end
          end
        else
          return ''
        end
      else
        return ''
      end
    end

    ## 5 Etiquetas
    ceti = /etiqueta(.*)$/.match(atr.to_s)
    etiquetas = Sivel2Gen::CasoEtiqueta.where(id_caso: caso_id)
    if ceti
      numero = ceti[1].split("_")[0]
      campo = ceti[1].split("_")[1]
      if !etiquetas.empty?
        etiqueta = etiquetas[numero.to_i-1]
        if etiqueta
          case campo
          when 'etiqueta'
            return etiqueta.send(campo) ? etiqueta.send(campo).nombre : ''
          when 'usuario'
            return etiqueta.send(campo) ? etiqueta.send(campo).nusuario : ''
          when 'fecha', 'observaciones'
            return etiqueta ? etiqueta.send(campo) : ''
          end
        else
          case campo
          when 'etiqueta', 'usuario', 'fecha', 'observaciones'
            return ''
          end
        end
      else
        case campo
        when 'etiqueta', 'usuario', 'fecha', 'observaciones'
          return ''
        end
      end
    end
    ## Migración del caso
    migra_simples = ::Ability::CAMPOS_MIGRA_SIMPLES
    migra_rela = ::Ability::CAMPOS_MIGRA_RELA
    migra_multi = ::Ability::CAMPOS_MIGRA_MULTI
    migracion = Sivel2Sjr::Migracion.where(caso_id: caso_id)[0]
    if migra_simples.include? atr.to_s
      if migracion
        return migracion.send(atr.to_s).nil? ? '' : migracion.send(atr.to_s)
      else 
        return ''
      end
    end
    if migra_rela.include? atr.to_s
      if migracion
        return migracion.send(atr.to_s).nil? ? "No aplica o nulo" : migracion.send(atr.to_s).nombre
      else 
        return ''
      end
    end
    if migra_multi.include? atr.to_s
      if migracion
        if atr.to_s == 'causaagresion'
          causasagresion = migracion.send(atr.to_s).pluck(:nombre)
          causasagresion.each_with_index do |cag, index|
            if cag == 'Otra'
              otracausa = migracion.otracausaagresion
              causasagresion[index] = "Otra: #{otracausa}"
            end
          end
          return migracion.send(atr.to_s).count > 0  ? causasagresion.join(", ") : '' 
        elsif atr.to_s == 'causaagrpais'
          causasagresion = migracion.send(atr.to_s).pluck(:nombre)
          causasagresion.each_with_index do |cag, index|
            if cag == 'Otra'
              otracausa = migracion.otracausagrpais
              causasagresion[index] = "Otra: #{otracausa}"
            end
          end
          return migracion.send(atr.to_s).count > 0  ? causasagresion.join(", ") : '' 
        else
          return migracion.send(atr.to_s).count > 0  ? migracion.send(atr.to_s).pluck(:nombre).join(", ") : '' 
        end
      else 
        return ''
      end
    end
    ## 5 Respuestas a Caso
    cres = /respuesta(.*)$/.match(atr.to_s)
    respuestas = Sivel2Sjr::ActividadCasosjr.where(casosjr_id: caso_id)
    if cres
      numero = cres[1].split("_")[0]
      campo = cres[1].split("_")[1]
      if !respuestas.empty?
        respuesta = respuestas[numero.to_i-1]
        if respuesta
          actividad = Cor1440Gen::Actividad.where(id: respuesta.actividad_id)[0]
          case campo
          when 'actividad'
            return actividad ? actividad.id : ''
          when 'fecha'
            return actividad ? actividad.fecha : ''
          when 'proyectofinanciero'
            convenios_ids = Cor1440Gen::ActividadProyectofinanciero.where(actividad_id: actividad.id).pluck(:proyectofinanciero_id)
            proyectosfinancieros = Cor1440Gen::Proyectofinanciero.find(convenios_ids - [10])
            return proyectosfinancieros ? proyectosfinancieros.pluck(:nombre).join(', ') : ''
          when 'actividadpf'
            actividadespf_ids = Cor1440Gen::ActividadActividadpf.where(actividad_id: actividad.id).pluck(:actividadpf_id)
            actividadespf = Cor1440Gen::Actividadpf.find(actividadespf_ids)
            return actividadespf ? actividadespf.pluck(:titulo).join(', ') : ''
          end
        else
          case campo
          when 'actividad', 'fecha', 'proyectofinanciero', 'actividadpf'
            return ''
          end
        end
      else
        case campo
        when 'actividad', 'fecha', 'proyectofinanciero', 'actividadpf'
          return ''
        end
      end
    end
    caso = Sivel2Gen::Caso.find(caso_id)
    numeroanexos = Sivel2Gen::AnexoCaso.where(id_caso: caso_id).count
    case atr.to_s
      ## CONTACTO
    when 'contacto_anionac'
      contacto.anionac ? contacto.anionac : ''
    when 'contacto_mesnac'
      contacto.mesnac ? contacto.mesnac : ''
    when 'contacto_dianac'
      contacto.dianac ? contacto.dianac : ''
    when 'contacto_tdocumento'
      contacto.tdocumento ? contacto.tdocumento.nombre : ''
    when 'contacto_numerodocumento'
      contacto.numerodocumento ? contacto.numerodocumento : ''
    when 'contacto_pais'
      contacto.pais ? contacto.pais.nombre : ''
    when 'contacto_departamento'
      contacto.departamento ? contacto.departamento.nombre : ''
    when 'contacto_municipio'
      contacto.municipio ? contacto.municipio.nombre : ''
    when 'contacto_clase'
      contacto.clase ? contacto.clase.nombre : ''
    when 'telefono'
      casosjr.telefono ? casosjr.telefono : ''
    when 'direccion'
      casosjr.direccion ? casosjr.direccion : ''
    when 'contacto_numeroanexos'
      Sivel2Gen::AnexoVictima.where(victima_id: victimac.id).where.not(tipoanexo_id: 11).count.to_s
    when 'contacto_numeroanexosconsen'
      Sivel2Gen::AnexoVictima.where(victima_id: victimac.id, tipoanexo_id: 11).count.to_s
    when 'contacto_etnia'
      victimac.etnia ? victimac.etnia.nombre : ''
    when 'contacto_orientacionsexual'
      if victimac.orientacionsexual
        orientaciones.each do |ori|
          if ori[1].to_s == victimac.orientacionsexual.to_s
            return ori[0].to_s
          end
        end
      else
        return ''
      end
    when 'contacto_maternidad'
      victimasjrc.maternidad ? victimasjrc.maternidad.nombre : ''
    when 'contacto_estadocivil'
      victimasjrc.estadocivil ? victimasjrc.estadocivil.nombre : ''
    when 'contacto_discapacidad'
      victimasjrc.discapacidad ? victimasjrc.discapacidad.nombre : ''
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
      victimac.profesion ? victimac.profesion.nombre : ''
    when 'contacto_actividadoficio'
      Sivel2Gen::Actividadoficio.find(victimasjrc.id_actividadoficio).nombre
    when 'contacto_filiacion'
      victimac.filiacion ? victimac.filiacion.nombre : ''
    when 'contacto_organizacion'
      victimac.organizacion ? victimac.organizacion.nombre : ''
    when 'contacto_vinculoestado'
      victimac.vinculoestado ? victimac.vinculoestado.nombre : ''
    when 'contacto_comosupo'
      casosjr.comosupo ? casosjr.comosupo.nombre : ''
    when 'contacto_consentimientosjr'
      casosjr.concentimientosjr ? "Si" : "No"
    when 'contacto_consentimientobd'
      casosjr.concentimientobd ? "Si" : "No"
    when 'memo'
      caso.memo ? caso.memo : ''
    when 'numeroanexos'
      caso ? numeroanexos : ''

    when 'ultimaatencion_as_humanitaria'
      resp_ultimaatencion(11,110)
    when 'ultimaatencion_ac_juridica'
      r = ''
      if resp_ultimaatencion(14,140) != ''
         r += resp_ultimaatencion(14,140) + ": " + 
           resp_ultimaatencion(14,141) + '. '
      end
      if resp_ultimaatencion(14,142) != ''
         r += resp_ultimaatencion(14,142) + ": " + 
           resp_ultimaatencion(14,143) + '. '
      end
      r
    when 'ultimaatencion_as_juridica'
      resp_ultimaatencion(13,130)
    when 'ultimaatencion_beneficiarios_0_5'
      self.class.poblacion_ultimaatencion(
        caso_id, ultimaatencion_actividad_id, 'M', 0, 5)
    when 'ultimaatencion_beneficiarios_6_12'
      self.class.poblacion_ultimaatencion(
        caso_id, ultimaatencion_actividad_id, 'M', 6, 12)
    when 'ultimaatencion_beneficiarios_13_17'
      self.class.poblacion_ultimaatencion(
        caso_id, ultimaatencion_actividad_id, 'M', 13, 17)
    when 'ultimaatencion_beneficiarios_18_26'
      self.class.poblacion_ultimaatencion(
        caso_id, ultimaatencion_actividad_id, 'M', 18, 26)
    when 'ultimaatencion_beneficiarios_27_59'
      self.class.poblacion_ultimaatencion(
        caso_id, ultimaatencion_actividad_id, 'M', 27, 59)
    when 'ultimaatencion_beneficiarios_60_'
      self.class.poblacion_ultimaatencion(
        caso_id, ultimaatencion_actividad_id, 'M', 60, nil)
    when 'ultimaatencion_beneficiarios_se'
      self.class.poblacion_ultimaatencion(
        caso_id, ultimaatencion_actividad_id, 'M', nil, nil)
    when 'ultimaatencion_beneficiarias_0_5'
      self.class.poblacion_ultimaatencion(
        caso_id, ultimaatencion_actividad_id, 'F', 0, 5)
    when 'ultimaatencion_beneficiarias_6_12'
      self.class.poblacion_ultimaatencion(
        caso_id, ultimaatencion_actividad_id, 'F', 6, 12)
    when 'ultimaatencion_beneficiarias_13_17'
      self.class.poblacion_ultimaatencion(
        caso_id, ultimaatencion_actividad_id, 'F', 13, 17)
    when 'ultimaatencion_beneficiarias_18_26'
      self.class.poblacion_ultimaatencion(
        caso_id, ultimaatencion_actividad_id, 'F', 18, 26)
    when 'ultimaatencion_beneficiarias_27_59'
      self.class.poblacion_ultimaatencion(
        caso_id, ultimaatencion_actividad_id, 'F', 27, 59)
    when 'ultimaatencion_beneficiarias_60_'
      self.class.poblacion_ultimaatencion(
        caso_id, ultimaatencion_actividad_id, 'F', 60, nil)
    when 'ultimaatencion_beneficiarias_se'
      self.class.poblacion_ultimaatencion(
        caso_id, ultimaatencion_actividad_id, 'F', nil, nil)
    when 'ultimaatencion_beneficiarios_ss_0_5'
      self.class.poblacion_ultimaatencion(
        caso_id, ultimaatencion_actividad_id, 'S', 0, 5)
    when 'ultimaatencion_beneficiarios_ss_6_12'
      self.class.poblacion_ultimaatencion(
        caso_id, ultimaatencion_actividad_id, 'S', 6, 12)
    when 'ultimaatencion_beneficiarios_ss_13_17'
      self.class.poblacion_ultimaatencion(
        caso_id, ultimaatencion_actividad_id, 'S', 13, 17)
    when 'ultimaatencion_beneficiarios_ss_18_26'
      self.class.poblacion_ultimaatencion(
        caso_id, ultimaatencion_actividad_id, 'S', 18, 26)
    when 'ultimaatencion_beneficiarios_ss_27_59'
      self.class.poblacion_ultimaatencion(
        caso_id, ultimaatencion_actividad_id, 'S', 27, 59)
    when 'ultimaatencion_beneficiarios_ss_60_'
      self.class.poblacion_ultimaatencion(
        caso_id, ultimaatencion_actividad_id, 'S', 60, nil)
    when 'ultimaatencion_beneficiarios_ss_se'
      self.class.poblacion_ultimaatencion(
        caso_id, ultimaatencion_actividad_id, 'S', nil, nil)

    when 'ultimaatencion_derechosvul'
      resp_ultimaatencion(10,100)
    when 'ultimaatencion_descripcion_at', 'ultimaatencion_objetivo'
      ultatencion = Cor1440Gen::Actividad.
        where(id: ultimaatencion_actividad_id).take
      if !ultatencion
        return "Problema no existe actividad #{ultimaatencion_actividad_id}"
      end
      ultatencion.objetivo ? ultatencion.objetivo : ''
    when 'ultimaatencion_otros_ser_as'
      resp_ultimaatencion(15,150)

    else
      if respond_to?(atr)
        send(atr)
      else
        caso.presenta(atr)
      end
    end
  end
  
  def self.porsjrc
    "porsjrc"
  end

end # module ClassMethods



