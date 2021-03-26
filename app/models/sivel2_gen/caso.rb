# encoding: UTF-8

require 'sivel2_sjr/concerns/models/caso'
class Sivel2Gen::Caso < ActiveRecord::Base
  include Sivel2Sjr::Concerns::Models::Caso

  def presenta(atr)
    case atr.to_s
    when 'fecharec'
      casosjr.fecharec if casosjr.fecharec
    when 'oficina'
      casosjr.oficina.nombre if casosjr.oficina
    when 'asesor'
      casosjr.usuario.nusuario if casosjr.usuario
    when 'contacto'
      if casosjr && casosjr.contacto
        casosjr.contacto.nombres + ' ' + casosjr.contacto.apellidos +
       ' ' + ((casosjr.contacto.tdocumento.nil? ||
               casosjr.contacto.tdocumento.sigla.nil?) ? '' : 
              casosjr.contacto.tdocumento.sigla) + ' ' +
       ' ' + (casosjr.contacto.numerodocumento.nil? ? '' : 
              casosjr.contacto.numerodocumento)
      end
    when 'direccion'
      casosjr.direccion if casosjr.direccion
    when 'telefono'
      casosjr.telefono if casosjr.telefono
    else
      presenta_gen(atr) 
    end
  end

  has_many :migracion, class_name: 'Sivel2Sjr::Migracion',
    foreign_key: "caso_id", validate: true, dependent: :destroy
  accepts_nested_attributes_for :migracion, allow_destroy: true, 
    reject_if: :all_blank

end

