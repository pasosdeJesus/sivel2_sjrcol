# encoding: UTF-8

class Indicadorgifmm < ActiveRecord::Base
  include Sip::Basica

  belongs_to :sectorgifmm, foreign_key: 'sectorgifmm_id', 
    validate: true, class_name: 'Sectorgifmm'

  has_many :actividadpf, foreign_key: 'indicadorgifmm_id',
    class_name: 'Cor1440Gen::Actividadpf'
end
