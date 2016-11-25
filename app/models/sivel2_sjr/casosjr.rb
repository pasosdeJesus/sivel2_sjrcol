# encoding: UTF-8

require 'sivel2_sjr/concerns/models/casosjr'

class Sivel2Sjr::Casosjr < ActiveRecord::Base
  include Sivel2Sjr::Concerns::Models::Casosjr

  validates :memo1612, length: { maximum: 5000 }
end
