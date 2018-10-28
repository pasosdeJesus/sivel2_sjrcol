# encoding: UTF-8

require 'sip/concerns/controllers/personas_controller'

module Sip
  class PersonasController < Sip::ModelosController

    include Sip::Concerns::Controllers::PersonasController

    def atributos_index
      [ :id, 
        :nombres,
        :apellidos,
        :tdocumento,
        :numerodocumento,
        :presenta_fechanac,
        :sexo,
        :municipio
      ]
    end

    def atributos_show
      [ :id, 
        :nombres,
        :apellidos,
        :anionac,
        :mesnac,
        :dianac,
        :sexo,
        :pais,
        :departamento,
        :municipio,
        :clase,
        :nacionalde,
        :tdocumento,
        :numerodocumento
      ]
    end


    def atributos_form
      a = atributos_show - [:id] +
        [:datosbio]
      return a
    end

    def listaparams
      atributos_form + [
        :id_pais,
        :id_departamento,
        :id_municipio,
        :id_clase,
        :tdocumento_id
      ]
    end

  end
end
