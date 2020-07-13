# encoding: UTF-8

class Sivel2Sjr::Migracion < ActiveRecord::Base

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
 
  belongs_to :statusmigratorio,
    class_name: 'Sivel2Sjr::Statusmigratorio', 
    foreign_key: "statusmigratorio_id", 
    optional: true


  validates :fechasalida, presence: true
end
