
# Agrega accesores del estilo prefijo_pais_id, prefijo_departamento_id... etc
# A un modelo que tiene un campo ubicacionpre de nombre prefijoubicacionpre_id
#
# Utilizar con extend
module AccesoresUbicacionpre

  def accesores_ubicacionpre(prefijo)
    self.send(:attr_accessor, "#{prefijo.to_s}_pais_id")
    self.send(:attr_accessor, "#{prefijo.to_s}_departamento_id")
    self.send(:attr_accessor, "#{prefijo.to_s}_municipio_id")
    self.send(:attr_accessor, "#{prefijo.to_s}_clase_id")
    self.send(:attr_accessor, "#{prefijo.to_s}_lugar")
    self.send(:attr_accessor, "#{prefijo.to_s}_sitio")
    self.send(:attr_accessor, "#{prefijo.to_s}_tsitio_id")
    self.send(:attr_accessor, "#{prefijo.to_s}_latitud")
    self.send(:attr_accessor, "#{prefijo.to_s}_longitud")

    define_method("#{prefijo.to_s}_pais_id") do
      self.send("#{prefijo.to_s}ubicacionpre") ?
        self.send("#{prefijo.to_s}ubicacionpre").pais_id : ''
    end

    define_method("#{prefijo.to_s}_departamento_id") do
      self.send("#{prefijo.to_s}ubicacionpre") ?
        self.send("#{prefijo.to_s}ubicacionpre").departamento_id : ''
    end

    define_method("#{prefijo.to_s}_municipio_id") do
      self.send("#{prefijo.to_s}ubicacionpre") ?
        self.send("#{prefijo.to_s}ubicacionpre").municipio_id : ''
    end

    define_method("#{prefijo.to_s}_clase_id") do
      self.send("#{prefijo.to_s}ubicacionpre") ?
        self.send("#{prefijo.to_s}ubicacionpre").clase_id : ''
    end

    define_method("#{prefijo.to_s}_lugar") do
      self.send("#{prefijo.to_s}ubicacionpre") ?
        self.send("#{prefijo.to_s}ubicacionpre").lugar : ''
    end

    define_method("#{prefijo.to_s}_sitio") do
      self.send("#{prefijo.to_s}ubicacionpre") ?
        self.send("#{prefijo.to_s}ubicacionpre").sitio : ''
    end

    define_method("#{prefijo.to_s}_tsitio_id") do
      self.send("#{prefijo.to_s}ubicacionpre") ?
        self.send("#{prefijo.to_s}ubicacionpre").tsitio_id : ''
    end

    define_method("#{prefijo.to_s}_latitud") do
      self.send("#{prefijo.to_s}ubicacionpre") ?
        self.send("#{prefijo.to_s}ubicacionpre").latitud : ''
    end

    define_method("#{prefijo.to_s}_longitud") do
      self.send("#{prefijo.to_s}ubicacionpre") ?
        self.send("#{prefijo.to_s}ubicacionpre").longitud : ''
    end
  end

end
