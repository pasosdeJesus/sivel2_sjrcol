# encoding: UTF-8


Sal7711Gen::Articulo.class_eval do
  clear_validators!

  validates :fuenteprensa_id, presence: true
  validates :fecha, presence: true

  validate :departamento_y_municipio_coinciden

end

