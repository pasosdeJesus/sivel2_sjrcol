module GifmmHelper

  def self.departamento_gifmm(d)
    case d
    when 'BOGOTÁ, D.C.'
      'Bogotá D.C.'
    else
      d.altas_bajas
    end
  end

  def self.municipio_gifmm(m)
    case m
    when 'BOGOTÁ, D.C.'
      'Bogotá D.C.'
    else
      m.altas_bajas
    end
  end


  # Recibe id de persona y fecha hasta la cual mirar casos
  # o actividades para determinar y retornar cadena con su 
  # perfil migratorio (i.e nombre de la tabla pefilmigracion) más 
  # reciente hasta esa fecha.
  # Si no encuentra perfil migratorio retorna ''
  def self.perfilmigracion_de_beneficiario(idp, fecha)
    p = Sip::Persona.find(idp)
    mc = p.caso.joins(
      'JOIN sivel2_sjr_casosjr ON ' +
      'sivel2_gen_caso.id=sivel2_sjr_casosjr.id_caso').
      where('sivel2_sjr_casosjr.fecharec <= ?', fecha).
      order('sivel2_sjr_casosjr.fecharec DESC').find { |c| 
      v = c.victima.where(id_persona: idp).take
      (v.victimasjr.fechadesagregacion.nil? || 
       v.victimasjr.fechadesagregacion > fecha) &&
      c.migracion.count > 0 &&
      c.migracion[0].perfilmigracion
    }
    ma = Cor1440Gen::Asistencia.where(persona_id: idp).joins(
      'JOIN cor1440_gen_actividad ON ' + 
      'cor1440_gen_actividad.id = cor1440_gen_asistencia.actividad_id').
      where('cor1440_gen_actividad.fecha <= ?', fecha).
      order('cor1440_gen_actividad.fecha DESC').find {|as|
      as.perfilactorsocial &&
        ::Perfilmigracion.pluck(:nombre).include?(
          as.perfilactorsocial.nombre)
    }
    if mc
      if ma
        if mc.casosjr.fecharec > ma.actividad.fecha
          return mc.migracion[0].perfilmigracion.nombre
        else
          return ma.perfilactorsocial.nombre
        end
      end
      return mc.migracion[0].perfilmigracion.nombre
    end
    if ma
      return ma.perfilactorsocial.nombre
    end
    return ''
  end

  
  # Recibe Sip::Persona y fecha hasta la cual mirar casos
  # para determinar y retornar cadena con su etnia
  # más reciente hasta esa fecha en casos de los que no haya
  # sido desagregado.
  # Si no encuentra etnia retorna ''
  def self.etnia_de_beneficiario(p, fecha)
    r = ''
    ce = p.caso.order('fecha DESC').find { |c|
      v = c.victima.where(id_persona: p.id).take
      (v.victimasjr.fechadesagregacion.nil? || 
       v.victimasjr.fechadesagregacion > fecha) &&
      v.etnia
    }
    if ce
      r = ce.victima.where(id_persona: p.id).take.etnia.nombre
    end
    r
  end


end
