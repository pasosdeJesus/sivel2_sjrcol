class CambiaNombreUbicacionpre < ActiveRecord::Migration[6.1]
  def up
    ultp = -1
    i = 0
    tot = Sip::Ubicacionpre.all.count
    Sip::Ubicacionpre.all.each do |ubi|
      a = ubi.nombre
      a2 = ubi.nombre_sin_pais
      ubi.poner_nombre_estandar
      if a != ubi.nombre || a2 !=ubi.nombre_sin_pais
        puts "#{a} => #{ubi.nombre}.  #{a2} => #{ubi.nombre_sin_pais}"
      end
      i += 1
      p  = (100*i/tot)
      if p > ultp
        puts "#{p}%"
        ultp = p
      end
    end
  end

  def down
  end
end
