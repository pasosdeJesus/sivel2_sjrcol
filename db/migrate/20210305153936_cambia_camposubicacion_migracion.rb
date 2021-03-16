class CambiaCamposubicacionMigracion < ActiveRecord::Migration[6.1]

  def agrega_sip_ubicacionpre
    t = Sivel2Sjr::Migracion.all.count
    c = 0
    ultp = 0
    Sivel2Sjr::Migracion.all.each do |migracion|
      salida_pais = migracion.salida_pais_id_porborrar
      salida_departamento = migracion.salida_departamento_id_porborrar
      salida_municipio = migracion.salida_municipio_id_porborrar
      salida_clase = migracion.salida_clase_id_porborrar
      if !salida_pais && !salida_departamento && !salida_municipio && 
          !salida_clase
        puts "Migración #{migracion.id} no tiene salida"
      else 
        ubicacionpre = Sip::Ubicacionpre.where(
          pais_id: salida_pais, departamento_id: salida_departamento, 
          municipio_id: salida_municipio, clase_id: salida_clase)
        if ubicacionpre[0]
          migracion.salidaubicacionpre_id = ubicacionpre[0].id
          migracion.save! 
        else
          #byebug
          puts "En ubicacionpre no se encontró salida_pais=#{salida_pais}, "\
            "salida_departamento=#{salida_departamento}, "\
            "salida_municipio=#{salida_municipio}, "\
            "salida_clase=#{salida_clase}, "\
            "migración=#{migracion.id}, "\
            "caso=#{migracion.caso_id}"
          exit 1
        end
      end
      c += 1
      p = c*100/t
      if p.to_i > ultp 
        ultp = p.to_i
        puts "Procesados #{c} migraciones (#{ultp} %)"
      end
    end
  end

  def quita_sip_ubicacionpre
    Sivel2Sjr::Migracion.all.each do |migracion|
      migracion.salidaubicacionpre_id = nil
      migracion.save! 
    end
  end

  def cambianombres_borrar
     execute <<-SQL
       ALTER TABLE sivel2_sjr_migracion RENAME salida_pais_id TO salida_pais_id_porborrar;
       ALTER TABLE sivel2_sjr_migracion RENAME salida_departamento_id TO salida_departamento_id_porborrar;
       ALTER TABLE sivel2_sjr_migracion RENAME salida_municipio_id TO salida_municipio_id_porborrar;
       ALTER TABLE sivel2_sjr_migracion RENAME salida_clase_id TO salida_clase_id_porborrar;
     SQL
  end

  def cambianombres_sinborrar
     execute <<-SQL
     ALTER TABLE sivel2_sjr_migracion RENAME salida_pais_id_porborrar TO salida_pais_id;
     ALTER TABLE sivel2_sjr_migracion RENAME salida_departamento_id_porborrar TO salida_departamento_id;
     ALTER TABLE sivel2_sjr_migracion RENAME salida_municipio_id_porborrar TO salida_municipio_id;
     ALTER TABLE sivel2_sjr_migracion RENAME salida_clase_id_porborrar TO salida_clase_id;
     SQL
  end

  def up
    cambianombres_borrar
    agrega_sip_ubicacionpre
  end

  def down
    quita_sip_ubicacionpre
    cambianombres_sinborrar
  end
end
