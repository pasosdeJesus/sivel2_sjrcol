require 'accesores_ubicacionpre'

class Sivel2Sjr::Migracion < ActiveRecord::Base

  extend ::AccesoresUbicacionpre

  accesores_ubicacionpre :destino

  accesores_ubicacionpre :llegada

  accesores_ubicacionpre :salida

  attr_accessor :tiempoenpais

  has_and_belongs_to_many :agresionmigracion, 
    class_name: 'Agresionmigracion',
    foreign_key: :migracion_id, 
    association_foreign_key: 'agremigracion_id',
    join_table: 'sivel2_sjr_agremigracion_migracion'

  has_and_belongs_to_many :agresionenpais, 
    class_name: 'Agresionmigracion',
    foreign_key: :migracion_id, 
    association_foreign_key: 'agreenpais_id',
    join_table: 'sivel2_sjr_agreenpais_migracion'

  has_and_belongs_to_many :causaagresion, 
    class_name: 'Causaagresion',
    foreign_key: :migracion_id, 
    association_foreign_key: 'causaagresion_id',
    join_table: 'sivel2_sjr_causaagresion_migracion'

  has_and_belongs_to_many :causaagrpais, 
    class_name: 'Causaagresion',
    foreign_key: :migracion_id, 
    association_foreign_key: 'causaagrpais_id',
    join_table: 'sivel2_sjr_causaagrpais_migracion'
  
  has_and_belongs_to_many :dificultadmigracion, 
    class_name: 'Dificultadmigracion',
    foreign_key: :migracion_id, 
    association_foreign_key: 'difmigracion_id',
    join_table: 'sivel2_sjr_difmigracion_migracion'
  
  belongs_to :autoridadrefugio,
    class_name: 'Autoridadrefugio', foreign_key: "autoridadrefugio_id", optional: true
  belongs_to :caso,
    class_name: 'Sivel2Gen::Caso', foreign_key: "caso_id"

  belongs_to :causaRefugio, class_name: 'Sivel2Gen::Categoria', 
    foreign_key: "causaRefugio_id", optional: true
    
  belongs_to :destino_pais, 
    class_name: 'Sip::Pais', foreign_key: "destino_pais_id", optional: true
  belongs_to :destino_departamento, 
    class_name: 'Sip::Departamento', foreign_key: "destino_departamento_id", 
    optional: true
  belongs_to :destino_municipio, 
    class_name: 'Sip::Municipio', foreign_key: "destino_municipio_id", 
    optional: true
  belongs_to :destino_clase, 
    class_name: 'Sip::Clase', foreign_key: "destino_clase_id", optional: true
  belongs_to :destino_tsitio, 
    class_name: 'Sip::Tsitio', foreign_key: "destino_tsitio_id", optional: true
  belongs_to :viadeingreso,
    class_name: 'Viadeingreso', foreign_key: "viadeingreso_id", optional: true
  belongs_to :causamigracion, 
    class_name: 'Causamigracion', foreign_key: "causamigracion_id", optional: true
  belongs_to :pagoingreso, 
    class_name: 'Sip::Trivalente', foreign_key: "pagoingreso_id", optional: true  
  belongs_to :llegada_pais, 
    class_name: 'Sip::Pais', foreign_key: "llegada_pais_id", optional: true
  belongs_to :llegada_departamento, 
    class_name: 'Sip::Departamento', foreign_key: "llegada_departamento_id", 
    optional: true
  belongs_to :llegada_municipio, 
    class_name: 'Sip::Municipio', foreign_key: "llegada_municipio_id", 
    optional: true
  belongs_to :llegada_clase, 
    class_name: 'Sip::Clase', foreign_key: "llegada_clase_id", optional: true
  belongs_to :llegada_tsitio, 
    class_name: 'Sip::Tsitio', foreign_key: "llegada_tsitio_id", optional: true

  belongs_to :miembrofamiliar,
    class_name: 'Miembrofamiliar', foreign_key: "miembrofamiliar_id", optional: true
  belongs_to :migracontactopre,
    class_name: '::Migracontactopre', foreign_key: "migracontactopre_id", 
    optional: true

  belongs_to :perfilmigracion,
    class_name: '::Perfilmigracion', 
    foreign_key: "perfilmigracion_id", 
    optional: true

  belongs_to :proteccion,
    class_name: 'Sivel2Sjr::Proteccion', 
    foreign_key: "proteccion_id", 
    optional: true
  
  belongs_to :salida_pais, 
    class_name: 'Sip::Pais', foreign_key: "salida_pais_id", optional: true
  belongs_to :salida_departamento, 
    class_name: 'Sip::Departamento', foreign_key: "salida_departamento_id", 
    optional: true
  belongs_to :salida_municipio, 
    class_name: 'Sip::Municipio', foreign_key: "salida_municipio_id", 
    optional: true
  belongs_to :salida_clase, 
   class_name: 'Sip::Clase', foreign_key: "salida_clase_id", optional: true
  belongs_to :salida_tsitio, 
    class_name: 'Sip::Tsitio', foreign_key: "salida_tsitio_id", optional: true

  belongs_to :salidaubicacionpre,
    class_name: 'Sip::Ubicacionpre', foreign_key: "salidaubicacionpre_id", 
    optional: true
  belongs_to :llegadaubicacionpre,
    class_name: 'Sip::Ubicacionpre', foreign_key: "llegadaubicacionpre_id", 
    optional: true
  belongs_to :destinoubicacionpre,
    class_name: 'Sip::Ubicacionpre', foreign_key: "destinoubicacionpre_id", 
    optional: true

  belongs_to :statusmigratorio,
    class_name: 'Sivel2Sjr::Statusmigratorio', 
    foreign_key: "statusmigratorio_id", 
    optional: true
  belongs_to :tipoproteccion,
    class_name: 'Tipoproteccion', foreign_key: "tipoproteccion_id", optional: true

  validates :fechasalida, presence: true


  def destino_pais_id
    if self.destinoubicacionpre_id
      return Sip::Ubicacionpre.find(self.destinoubicacionpre_id).pais_id
    else
      return ''
    end
  end
  def destino_departamento_id
    if self.destinoubicacionpre_id
      return Sip::Ubicacionpre.find(self.destinoubicacionpre_id).departamento_id
    else
      return ''
    end 
  end
  def destino_municipio_id
    if self.destinoubicacionpre_id
      return Sip::Ubicacionpre.find(self.destinoubicacionpre_id).municipio_id
    else
      return ''
    end 
  end
  def destino_clase_id
    if self.destinoubicacionpre_id
      return Sip::Ubicacionpre.find(self.destinoubicacionpre_id).clase_id
    else
      return ''
    end 
  end

  def destino_lugar
    if self.destinoubicacionpre_id
      return Sip::Ubicacionpre.find(self.destinoubicacionpre_id).lugar
    else
      return ''
    end 
  end

  def destino_sitio
    if self.destinoubicacionpre_id
      return Sip::Ubicacionpre.find(self.destinoubicacionpre_id).sitio
    else
      return ''
    end 
  end

  def destino_latitud
    if self.destinoubicacionpre_id
      return Sip::Ubicacionpre.find(self.destinoubicacionpre_id).latitud
    else
      return ''
    end 
  end

  def destino_longitud
    if self.destinoubicacionpre_id
      return Sip::Ubicacionpre.find(self.destinoubicacionpre_id).longitud
    else
      return ''
    end 
  end

  def destino_tsitio_id
    if self.destinoubicacionpre_id
      return Sip::Ubicacionpre.find(self.destinoubicacionpre_id).tsitio_id
    else
      return ''
    end 
  end

  def tiempoenpais
    if self.id && self.fechallegada
      fechallegada = self.fechallegada.to_datetime
      hoy = Date.today
      dias = hoy - fechallegada
      return dias.to_i
    end
    return ''
  end



end
