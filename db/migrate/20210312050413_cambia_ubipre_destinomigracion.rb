class CambiaUbipreDestinomigracion < ActiveRecord::Migration[6.1]
def agrega_sip_ubicacionpre
    t = Sivel2Sjr::Migracion.all.count
    c = 0
    ultp = 0
    Sivel2Sjr::Migracion.all.each do |migracion|
      destino_pais = migracion.destino_pais_id_porborrar
      destino_departamento = migracion.destino_departamento_id_porborrar
      destino_municipio = migracion.destino_municipio_id_porborrar
      destino_clase = migracion.destino_clase_id_porborrar
      if !destino_pais && !destino_departamento && !destino_municipio && 
          !destino_clase
        puts "Migración #{migracion.id} no tiene destino"
      else 
        ubicacionpre = Sip::Ubicacionpre.where(
          pais_id: destino_pais, departamento_id: destino_departamento, 
          municipio_id: destino_municipio, clase_id: destino_clase)
        if ubicacionpre[0]
          migracion.destinoubicacionpre_id = ubicacionpre[0].id
          migracion.save! 
        else
         # byebug
          puts "En ubicacionpre no se encontró destino_pais=#{destino_pais}, "\
<<<<<<< HEAD
            "destino_departamento=#{destino_departamento}, "\
            "destino_municipio=#{destino_municipio}, "\
            "destino_clase=#{destino_clase} "\
            "de la migración #{migracion.id}, "\
            "caso #{migracion.caso_id}"
=======
            "destino_departamento=#{destino_departamento}, destino_municipio=#{destino_municipio}, "\
            "destino_clase=#{destino_clase}"
>>>>>>> 0509487... funciona destino
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
      migracion.destinoubicacionpre_id = nil
      migracion.save! 
    end
  end

  def cambianombres_borrar
     execute <<-SQL
       ALTER TABLE sivel2_sjr_migracion RENAME destino_pais_id TO destino_pais_id_porborrar;
       ALTER TABLE sivel2_sjr_migracion RENAME destino_departamento_id TO destino_departamento_id_porborrar;
       ALTER TABLE sivel2_sjr_migracion RENAME destino_municipio_id TO destino_municipio_id_porborrar;
       ALTER TABLE sivel2_sjr_migracion RENAME destino_clase_id TO destino_clase_id_porborrar;
     SQL
  end

  def cambianombres_sinborrar
     execute <<-SQL
     ALTER TABLE sivel2_sjr_migracion RENAME destino_pais_id_porborrar TO destino_pais_id;
     ALTER TABLE sivel2_sjr_migracion RENAME destino_departamento_id_porborrar TO destino_departamento_id;
     ALTER TABLE sivel2_sjr_migracion RENAME destino_municipio_id_porborrar TO destino_municipio_id;
     ALTER TABLE sivel2_sjr_migracion RENAME destino_clase_id_porborrar TO destino_clase_id;
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
