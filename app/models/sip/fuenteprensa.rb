# encoding: UTF-8

require 'sal7711_gen/concerns/models/fuenteprensa'
require 'sivel2_gen/concerns/models/fuenteprensa'

module Sip
  class Fuenteprensa < ActiveRecord::Base
    include Sivel2Gen::Concerns::Models::Fuenteprensa
    include Sal7711Gen::Concerns::Models::Fuenteprensa
  end
end
