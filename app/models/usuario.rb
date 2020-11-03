# encoding: UTF-8

require 'sivel2_sjr/concerns/models/usuario'

class Usuario < ActiveRecord::Base
  include Sivel2Sjr::Concerns::Models::Usuario
  def active_for_authentication?
    #logger.debug self.to_yaml
    # Si fecha de contrato es posterior a hoy no puede autenticarse
    hoy = Date.today
    super && (!fincontrato || fincontrato < hoy)
  end
end

