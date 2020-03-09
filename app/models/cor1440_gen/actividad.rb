# encoding: UTF-8
require 'sivel2_sjr/concerns/models/actividad'

module Cor1440Gen
  class Actividad < ActiveRecord::Base
    include Mr519Gen::Modelo 
    include Sip::Localizacion
    include Sivel2Sjr::Concerns::Models::Actividad

    def presenta_actividad_pob(atr)
      case atr.to_s
      when 'ubicacion'
        lugar           

      when 'poblacion_hombres'
        actividad_rangoedadac.inject(0) { |memo, r| 
          memo += r.mr ? r.mr : 0
          memo += r.ml ? r.ml : 0
          memo
        }

      when 'poblacion_mujeres'
        actividad_rangoedadac.inject(0) { |memo, r| 
          memo += r.fl ? r.fl : 0
          memo += r.fr ? r.fr : 0
          memo
        }

      when 'poblacion_sin_sexo'
        actividad_rangoedadac.inject(0) { |memo, r| 
          memo += r.s ? r.s : 0
          memo
        }

      else
        presenta_gen(atr)
      end
    end

    def presenta(atr)
      presenta_actividad(atr)
      presenta_actividad_pob(atr)
    end
  end
end
