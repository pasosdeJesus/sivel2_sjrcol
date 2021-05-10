class Sip::Claverespaldo < ActiveRecord::Base
  include Sip::Modelo

  validates :created_at, presence: true
  validates :clave, presence: true, length: { maximum: 2047 },
    format: {with: /\A[0-9A-Za-z_]*\z/i,
             message: 'La clave sólo puede tener dígitos, letras o el caracter _' }

end
