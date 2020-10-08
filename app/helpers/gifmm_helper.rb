module GifmmHelper

  def self.departamento_gifmm(d)
    case d
    when 'BOGOTÁ, D.C.'
      'Bogotá D.C.'
    else
      d.altas_bajas
    end
  end

  def self.municipio_gifmm(m)
    case m
    when 'BOGOTÁ, D.C.'
      'Bogotá D.C.'
    else
      m.altas_bajas
    end
  end


end
