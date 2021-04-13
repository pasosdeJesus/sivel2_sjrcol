class CambiaUbidesplazamientoAUbicacionpre < ActiveRecord::Migration[6.1]

  def agrega_sip_ubicacionpre
    t = Sivel2Sjr::Desplazamiento.all.count
    c = 0
    ultp = 0
    Sivel2Sjr::Desplazamiento.all.each do |desplazamiento|
      expulsion = desplazamiento.id_expulsion_porborrar
      if !expulsion
        puts "Desplazamiento #{desplazamiento.id} no tiene expulsion"
      else 
        ubiex = Sip::Ubicacion.find(expulsion)
        ubicacionpre = Sip::Ubicacionpre.where(
          pais_id: ubiex.id_pais, departamento_id: ubiex.id_departamento, 
          municipio_id: ubiex.id_municipio, clase_id: ubiex.id_clase)
        if ubicacionpre[0]
          desplazamiento.expulsionubicacionpre_id = ubicacionpre[0].id
        else
         # byebug
          puts "En ubicacionpre no se encontró de expulsión pais=#{ubiex.id_pais}, "\
            "departamento=#{ubiex.id_departamento}, municipio=#{ubiex.id_municipio}, "\
            "clase=#{ubiex.id_clase}"
          exit 1
        end
      end
      llegada = desplazamiento.id_llegada_porborrar
      if !llegada
        puts "Desplazamiento #{desplazamiento.id} no tiene llegada"
      else 
        ubilleg = Sip::Ubicacion.find(llegada)
        ubicacionpre = Sip::Ubicacionpre.where(
          pais_id: ubilleg.id_pais, departamento_id: ubilleg.id_departamento, 
          municipio_id: ubilleg.id_municipio, clase_id: ubilleg.id_clase)
        if ubicacionpre[0]
          desplazamiento.llegadaubicacionpre_id = ubicacionpre[0].id
        else
         # byebug
          puts "En ubicacionpre no se encontró de expulsión pais=#{ubilleg.id_pais}, "\
            "departamento=#{ubilleg.id_departamento}, municipio=#{ubilleg.id_municipio}, "\
            "clase=#{ubilleg.id_clase}"
          exit 1
        end
      end
      desplazamiento.save! if desplazamiento.save 
      c += 1
      p = c*100/t
      if p.to_i > ultp 
        ultp = p.to_i
        puts "Procesadas #{c} desplazamientos (#{ultp} %)"
      end
    end
  end

  def quita_sip_ubicacionpre
    Sivel2Sjr::Desplazamiento.all.each do |desplazamiento|
      desplazamiento.expulsionubicacionpre_id = nil
      desplazamiento.llegadaubicacionpre_id = nil
      desplazamiento.save! if desplazamiento.save 
    end
  end

  def cambianombres_borrar
     execute <<-SQL
       ALTER TABLE sivel2_sjr_desplazamiento RENAME id_expulsion TO id_expulsion_porborrar;
       ALTER TABLE sivel2_sjr_desplazamiento RENAME id_llegada TO id_llegada_porborrar;
     SQL
     change_column_null(:sivel2_sjr_desplazamiento, :id_expulsion_porborrar, true)
     change_column_null(:sivel2_sjr_desplazamiento, :id_llegada_porborrar, true)
  end

  def cambianombres_sinborrar
     execute <<-SQL
       ALTER TABLE sivel2_sjr_desplazamiento RENAME id_expulsion_porborrar TO id_expulsion;
       ALTER TABLE sivel2_sjr_desplazamiento RENAME id_llegada_porborrar TO id_llegada;
     SQL
     change_column_null(:sivel2_sjr_desplazamiento, :id_expulsion_porborrar, false)
     change_column_null(:sivel2_sjr_desplazamiento, :id_llegada_porborrar, false)
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
