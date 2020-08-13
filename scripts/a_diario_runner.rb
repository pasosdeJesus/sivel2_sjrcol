# encoding: utf-8
# Ejecutar con bin/cron_diario

def alertas
  puts "Inicio de verificacion alertas"
end

def elimina_generados
    puts "Eliminando public/heb412/generados"
    orden = "ls -l public/heb412/generados/"
    res = `#{orden}`
    puts res
    orden = "rm public/heb412/generados/*ods"
    res = `#{orden}`
    puts res
    orden = "rm public/heb412/generados/*xlsx"
    res = `#{orden}`
    puts res
    orden = "rm public/heb412/generados/*pdf"
    res = `#{orden}`
    puts res
end

def cuenta_poblacion_0
  ap0 = Cor1440Gen::Actividad.all.select {|a| 
    a.presenta('poblacion') == 0 && 
     (a.asistencia.count > 0 || a.actividad_casosjr.count > 0)
  }
  ap0.each do |a|
    personas = {}
    a.asistencia.each do |asist|
      personas[asist.persona.id] = 1
    end
    a.actividad_casosjr.each do |ac|
      Sivel2Sjr::Victimasjr.joins(:victima).where('sivel2_gen_victima.id_caso' => ac.casosjr.id_caso).where(fechadesagregacion: nil).each do |vs|
        personas[vs.victima.id_persona] = 1
      end
    end

    rangoedadsexo = {}
    personas.keys.sort.each do |pid|
      p = Sip::Persona.find(pid)
      edad = Sivel2Gen::RangoedadHelper.edad_de_fechanac_fecha(
        p.anionac, p.mesnac, p.dianac,
        a.fecha.year, a.fecha.month, a.fecha.day)
      re = Sivel2Gen::RangoedadHelper.buscar_rango_edad(
        edad, 'Cor1440Gen::Rangoedadac')
      if !rangoedadsexo[re]
        rangoedadsexo[re] = {}
      end
      if !rangoedadsexo[re][p.sexo]
        rangoedadsexo[re][p.sexo] = 0
      end
      rangoedadsexo[re][p.sexo] += 1
    end

    car = 0
    rangoedadsexo.each do |r, ds|
      ar = Cor1440Gen::ActividadRangoedadac.create(
        actividad_id: a.id,
        rangoedadac_id: r,
        ml: 0,
        mr: ds['M'] ? ds['M'] : 0,
        fl: 0,
        fr: ds['F'] ? ds['F'] : 0,
        s: ds['S'] ? ds['S'] : 0
      )
      ar.save!
      car += 1
    end
    puts "Añadidos #{car} registros en .._actividad_rangoedadac con actividad #{a.id}"
  end
end


def run
  if !ENV['SMTP_MAQ']
    puts "No esta definida variable de ambiente SMTP_MAQ"
    exit 1
  end
  alertas
  elimina_generados
  cuenta_poblacion_0
end

run
