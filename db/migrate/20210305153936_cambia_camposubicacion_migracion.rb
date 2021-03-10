class CambiaCamposubicacionMigracion < ActiveRecord::Migration[6.1]

  def agrega_sip_ubicacionpre
    Sivel2Sjr::Migracion.all.each do |migracion|
      salida_pais = migracion.salida_pais_id
      salida_departamento = migracion.salida_departamento_id
      salida_municipio = migracion.salida_municipio_id
      salida_clase = migracion.salida_clase_id
      ubicacionpre = Sip::Ubicacionpre.where(pais_id: salida_pais, departamento_id: salida_departamento, municipio_id: salida_municipio, clase_id: salida_clase)
      if ubicacionpre[0]
        migracion.salidaubicacionpre_id = ubicacionpre[0].id
      end
      migracion.save! 
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
    agrega_sip_ubicacionpre
    cambianombres_borrar
  end

  def down
    cambianombres_sinborrar
    quita_sip_ubicacionpre
  end
end
