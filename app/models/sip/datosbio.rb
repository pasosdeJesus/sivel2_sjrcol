# encoding: UTF-8

class Sip::Datosbio < ActiveRecord::Base

  belongs_to :persona, class_name: 'Sip::Persona', foreign_key: 'persona_id',
    validate: true
  belongs_to :departamentores, class_name: 'Sip::Departamento', 
    foreign_key: 'departamentores_id', validate: true
  belongs_to :municipiores, class_name: 'Sip::Municipio', 
    foreign_key: 'municipiores_id', validate: true
  belongs_to :escolaridad, class_name: 'Sivel2Gen::Escolaridad', 
    foreign_key: 'escolaridad_id', validate: true

  validates :anioaprobacion, numericality: { 
    only_integer: true,  greater_than: 1900, allow_nil: true,
    message: 'Año no valido, debe ser entero superior a 1900'
  }
  validates :correo, length: {maximum: 100}
  validates :direccionres, length: {maximum: 1000}
  validates :discapacidad, length: {maximum: 1000}
  validates :eps, length: {maximum: 1000}
  validates :mayores60acargo, numericality: { 
    only_integer: true,  greater_than: 0, allow_nil: true
  }
  validates :menores12acargo, numericality: { 
    only_integer: true,  greater_than: 0, allow_nil: true
  }
  validates :nombreespaciopp, length: {maximum: 1000}
  validates :personashogar, numericality: { 
    only_integer: true,  greater_than: 0, allow_nil: true
  }
  validates :telefono, length: {maximum: 100}
  validates :tipocotizante, inclusion: { 
    in: %w(C, B), 
    message: 'Los valores válidos son C (Cotizante) y B (Beneficiario)'
  }
  validates :veredares, length: {maximum: 1000}
end

