module DesplazamientoHelper


  # calcula clasificacion de modalidad geográfica y submodalidad
  def modageo_desplazamiento(expulsion, llegada)
    pe = Sip::UbicacionHelper.formato_ubicacion(expulsion).split(' / ')
    pl = Sip::UbicacionHelper.formato_ubicacion(llegada).split(' / ')
    if pe.length > 0 && pl.length > 0
      if pe[0] != pl[0]
        cl = "TRANSFRONTERIZO"
      else
        cl = "INTERDEPARTAMENTAL"
        if pe.length > 1 && pl.length > 1 && pe[1] == pl[1]
          cl = "INTERMUNICIPAL"
          if pe.length > 2 && pl.length > 2 && pe[2] == pl[2]
            cl = "DENTRO DE UN MUNICIPIO"
            if pe.length == 4 && pl.length == 4 && pe[3] == pl[3]
              cl = "INTRAURBANO"
            end
          end
        end
      end
    end
    ue = "RURAL"
    if pe.length == 4
      ue = "URBANO"
    end
    ul = "RURAL"
    if pl.length == 4
      ul = "URBANO"
    end
    res = [cl, ue + " - " + ul]
    return res
  end
  module_function :modageo_desplazamiento

end
