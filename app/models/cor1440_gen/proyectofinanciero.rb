# encoding: UTF-8

require 'sivel2_sjr/concerns/models/proyectofinanciero'

module Cor1440Gen
  class Proyectofinanciero < ActiveRecord::Base

    include Sivel2Sjr::Concerns::Models::Proyectofinanciero
   
  end
end
