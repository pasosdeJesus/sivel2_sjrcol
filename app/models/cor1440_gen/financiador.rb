# encoding: UTF-8

require 'cor1440_gen/concerns/models/financiador'

module Cor1440Gen
  class Financiador < ActiveRecord::Base
    include Sip::Basica

    validates :nombregifmm, length: { in: 0..256 }
  end
end
