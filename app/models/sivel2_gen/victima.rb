# encoding: UTF-8
require 'sivel2_sjr/concerns/models/victima'

class Sivel2Gen::Victima < ActiveRecord::Base
  include Sivel2Sjr::Concerns::Models::Victima

  attr_accessor :rangoedadactual_id
  belongs_to :rangoedadactual, foreign_key: "rangoedadactual_id", validate: true, 
    class_name: "Sivel2Gen::Rangoedad"

end

