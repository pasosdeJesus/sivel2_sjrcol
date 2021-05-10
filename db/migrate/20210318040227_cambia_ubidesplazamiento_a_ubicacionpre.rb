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
        ubicacionpre = Sip::Ubicacionpre::buscar_o_agregar(
          ubiex.id_pais, ubiex.id_departamento,
          ubiex.id_municipio, ubiex.id_clase,
          ubiex.lugar, ubiex.sitio,
          ubiex.id_tsitio, ubiex.latitud,
          ubiex.longitud, ubiex.latitud && ubiex.longitud && 
            ubiex.latitud != 0 && ubiex.longitud != 0)
        if !ubicacionpre
          puts "Problema encontrando o creando ubicaciónpre para expulsión en"\
            "caso=#{desplazamiento.id_caso}, "\
            "desplazamiento=#{desplazamiento.id}, "\
            "ubicacion=#{ubiex.id}: "\
            "pais=#{ubiex.id_pais}, "\
            "departamento=#{ubiex.id_departamento}, "\
            "municipio=#{ubiex.id_municipio}, "\
            "clase=#{ubiex.id_clase}, "\
            "lugar=#{ubiex.lugar}, "\
            "sitio=#{ubiex.sitio}, "\
            "tsitio=#{ubiex.tsitio ? ubiex.tsitio.nombre : '' }, "\
            "latitud=#{ubiex.latitud}, "\
            "longitud=#{ubiex.longitud} "
          exit 1
        end
        desplazamiento.expulsionubicacionpre_id = ubicacionpre
      end
      llegada = desplazamiento.id_llegada_porborrar
      if !llegada
        puts "Desplazamiento #{desplazamiento.id} no tiene llegada"
      else 
        ubilleg = Sip::Ubicacion.find(llegada)
        ubicacionpre = Sip::Ubicacionpre::buscar_o_agregar(
          ubilleg.id_pais, ubilleg.id_departamento,
          ubilleg.id_municipio, ubilleg.id_clase,
          ubilleg.lugar, ubilleg.sitio,
          ubilleg.id_tsitio, ubilleg.latitud,
          ubilleg.longitud, ubilleg.latitud && ubilleg.longitud && 
          ubilleg.latitud != 0 && ubilleg.longitud != 0)
        if !ubicacionpre
          puts "Problema encontrando o creando ubicaciónpre para llegada en"\
            "caso=#{desplazamiento.id_caso}, "\
            "desplazamiento=#{desplazamiento.id}, "\
            "ubicacion=#{ubilleg.id}: "\
            "pais=#{ubilleg.id_pais}, "\
            "departamento=#{ubilleg.id_departamento}, "\
            "municipio=#{ubilleg.id_municipio}, "\
            "clase=#{ubilleg.id_clase}, "\
            "lugar=#{ubilleg.lugar}, "\
            "sitio=#{ubilleg.sitio}, "\
            "tsitio=#{ubilleg.tsitio ? ubilleg.tsitio.nombre : '' }, "\
            "latitud=#{ubilleg.latitud}, "\
            "longitud=#{ubilleg.longitud} "
          exit 1 
        end
        desplazamiento.llegadaubicacionpre_id = ubicacionpre
      end
      desplazamiento.save(validate: false)
      c += 1
      p = c*100/t
      if p.to_i > ultp 
        ultp = p.to_i
        puts "Procesados #{c} desplazamientos (#{ultp} %)"
      end
    end
  end

  def quita_sip_ubicacionpre
    Sivel2Sjr::Desplazamiento.all.each do |desplazamiento|
      desplazamiento.expulsionubicacionpre_id = nil
      desplazamiento.llegadaubicacionpre_id = nil
      desplazamiento.save(validate: false)
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
     change_column_null(:sivel2_sjr_desplazamiento, :id_expulsion, false)
     change_column_null(:sivel2_sjr_desplazamiento, :id_llegada, false)
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
