# encoding: UTF-8

require 'sivel2_sjr/concerns/models/oficina'

class Sip::Oficina < ActiveRecord::Base
  include Sivel2Sjr::Concerns::Models::Oficina
end

