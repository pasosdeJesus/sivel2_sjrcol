class CambiaCamposubicacionLlegmigracion < ActiveRecord::Migration[6.1]

  def agrega_sip_ubicacionpre
    t = Sivel2Sjr::Migracion.all.count
    c = 0
    ultp = 0
    Sivel2Sjr::Migracion.all.each do |migracion|
      llegada_pais = migracion.llegada_pais_id_porborrar
      llegada_departamento = migracion.llegada_departamento_id_porborrar
      llegada_municipio = migracion.llegada_municipio_id_porborrar
      llegada_clase = migracion.llegada_clase_id_porborrar
      if !llegada_pais && !llegada_departamento && !llegada_municipio && 
          !llegada_clase
        puts "Migración #{migracion.id} no tiene llegada"
      else 
        ubicacionpre = Sip::Ubicacionpre.where(
          pais_id: llegada_pais, departamento_id: llegada_departamento, 
          municipio_id: llegada_municipio, clase_id: llegada_clase)
        if ubicacionpre[0]
          migracion.llegadaubicacionpre_id = ubicacionpre[0].id
          migracion.save! 
        else
         # byebug
          puts "En ubicacionpre no se encontró llegada_pais=#{llegada_pais}, "\
            "llegada_departamento=#{llegada_departamento}, llegada_municipio=#{llegada_municipio}, "\
            "llegada_clase=#{llegada_clase}, migracion=#{migracion.id}"
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
      migracion.llegadaubicacionpre_id = nil
      migracion.save! 
    end
  end

  def cambianombres_borrar
     execute <<-SQL
       ALTER TABLE sivel2_sjr_migracion RENAME llegada_pais_id TO llegada_pais_id_porborrar;
       ALTER TABLE sivel2_sjr_migracion RENAME llegada_departamento_id TO llegada_departamento_id_porborrar;
       ALTER TABLE sivel2_sjr_migracion RENAME llegada_municipio_id TO llegada_municipio_id_porborrar;
       ALTER TABLE sivel2_sjr_migracion RENAME llegada_clase_id TO llegada_clase_id_porborrar;
     SQL
  end

  def cambianombres_sinborrar
     execute <<-SQL
     ALTER TABLE sivel2_sjr_migracion RENAME llegada_pais_id_porborrar TO llegada_pais_id;
     ALTER TABLE sivel2_sjr_migracion RENAME llegada_departamento_id_porborrar TO llegada_departamento_id;
     ALTER TABLE sivel2_sjr_migracion RENAME llegada_municipio_id_porborrar TO llegada_municipio_id;
     ALTER TABLE sivel2_sjr_migracion RENAME llegada_clase_id_porborrar TO llegada_clase_id;
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
