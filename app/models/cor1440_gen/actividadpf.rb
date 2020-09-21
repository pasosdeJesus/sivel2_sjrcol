# encoding: UTF-8

require 'cor1440_gen/concerns/models/actividadpf'

module Cor1440Gen
  class Actividadpf < ActiveRecord::Base
    include Cor1440Gen::Concerns::Models::Actividadpf

    belongs_to :indicadorgifmm, foreign_key: 'indicadorgifmm_id',
      optional: true, dependent: :destroy,
      class_name: 'Indicadorgifmm'
    
    def presenta_detallefinanciero_pfacpf
      pf = Cor1440Gen::Proyectofinanciero.find(proyectofinanciero_id).nombre
      "#{pf} - #{titulo}"
    end
    
    scope :filtro_actividadtipo_id, lambda { |t|
        where(actividadtipo_id: t)
    }
  end
end
