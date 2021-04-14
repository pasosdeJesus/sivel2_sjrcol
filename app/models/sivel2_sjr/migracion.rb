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
    
  belongs_to :viadeingreso,
    class_name: 'Viadeingreso', foreign_key: "viadeingreso_id", optional: true
  belongs_to :causamigracion, 
    class_name: 'Causamigracion', foreign_key: "causamigracion_id", optional: true
  belongs_to :pagoingreso, 
    class_name: 'Sip::Trivalente', foreign_key: "pagoingreso_id", optional: true  
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
  

  belongs_to :statusmigratorio,
    class_name: 'Sivel2Sjr::Statusmigratorio', 
    foreign_key: "statusmigratorio_id", 
    optional: true
  belongs_to :tipoproteccion,
    class_name: 'Tipoproteccion', foreign_key: "tipoproteccion_id", optional: true

  validates :fechasalida, presence: true

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
