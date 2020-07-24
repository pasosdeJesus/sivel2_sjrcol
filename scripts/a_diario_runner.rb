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

def recuenta_poblacion_0
  ap0 = Cor1440Gen::Actividad.all.select {|a| 
    (a.presenta('poblacion') == 0 && 
     (a.asistencia.count > 0 || a.actividad_casosjr.count > 0)}
  ap0.each do |a|
    personas = {}
    a.asistencia.each do |asist|
      personas[asist.persona.id] = 1
    end
    a.actividad_casosjr.each do |ac|
      Sivel2Sjr::Victimasjr.joins(:victima).where('sivel2_gen_victima.id_caso' => ac.casosjr.id_caso).where(fechadesagreacion: nil).each do |vs|
        personas[vs.victima.id_persona] = 1
      end
    end
  end

  personas.keys.sort.each do |p|
    agrega_rango_edad(p.persona[])
  end

end


def run
  if !ENV['SMTP_MAQ']
    puts "No esta definida variable de ambiente SMTP_MAQ"
    exit 1
  end
  alertas
  elimina_generados
  recuenta_poblacion_0
end

run
