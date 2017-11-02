# encoding: UTF-8

require 'sivel2_sjr/concerns/models/usuario'

class Usuario < ActiveRecord::Base
  include Sivel2Sjr::Concerns::Models::Usuario
end

