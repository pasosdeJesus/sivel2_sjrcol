# encoding: UTF-8

class Indicadorgifmm < ActiveRecord::Base
  include Sip::Basica

  belongs_to :sectorgifmm, foreign_key: 'sectorgifmm_id', 
    validate: true, dependent: :destroy, 
    class_name: 'Sectorgifmm'
end
