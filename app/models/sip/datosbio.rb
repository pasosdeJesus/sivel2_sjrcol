# encoding: UTF-8

class Sip::Datosbio < ActiveRecord::Base

  belongs_to :persona, class_name: 'Sip::Persona', foreign_key: 'persona_id',
    validate: true, optional: true
  belongs_to :res_departamento, class_name: 'Sip::Departamento', 
    foreign_key: 'res_departamento_id', validate: true, optional: true
  belongs_to :res_municipio, class_name: 'Sip::Municipio', 
    foreign_key: 'res_municipio_id', validate: true, optional: true
  belongs_to :discapacidad, class_name: '::Discapacidad', 
    foreign_key: 'discapacidad_id', validate: true, optional: true
  belongs_to :escolaridad, class_name: 'Sivel2Gen::Escolaridad', 
    foreign_key: 'escolaridad_id', validate: true, optional: true
  belongs_to :espaciopart, class_name: '::Espaciopart', 
    foreign_key: 'espaciopart_id', validate: true, optional: true

  validates :anioaprobacion, numericality: { 
    only_integer: true,  greater_than: 1900, allow_nil: true,
    message: 'Año no valido, debe ser entero superior a 1900'
  }
  validates :correo, length: {maximum: 100}
  validates :direccionres, length: {maximum: 1000}
  validates :discapacidad, length: {maximum: 1000}
  validates :eps, length: {maximum: 1000}
  validates :mayores60acargo, numericality: { 
    only_integer: true,  greater_than: 0, less_than: 13, allow_nil: true
  }
  validates :menores12acargo, numericality: { 
    only_integer: true,  greater_than: 0, less_than: 13, allow_nil: true
  }
  validates :nombreespaciopp, length: {maximum: 1000}
  validates :personashogar, numericality: { 
    only_integer: true,  greater_than: 0, allow_nil: true
  }
  validates :telefono, length: {maximum: 100}
  validates :tipocotizante, inclusion: { 
    in: ['C', 'B'], 
    message: 'Los valores válidos son C (Cotizante) y B (Beneficiario)'
  }
  validates :veredares, length: {maximum: 1000}
end

