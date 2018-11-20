# encoding: UTF-8

require 'sip/concerns/controllers/personas_controller'

module Sip
  class PersonasController < Heb412Gen::ModelosController

    include Sip::Concerns::Controllers::PersonasController

    def atributos_index
      [ :id, 
        :nombres,
        :apellidos,
        :tdocumento,
        :numerodocumento,
        :fechanac,
        :sexo,
        :municipio
      ]
    end

    def atributos_show
      [ :id, 
        :nombres,
        :apellidos,
        :fechanac,
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
      if @registro && @registro.datosbio.nil?
        @datosbio = Sip::Datosbio.new()
        @datosbio.tipocotizante = 'B'
        @datosbio.fecharecoleccion = Date.today()
        @datosbio.save!
        @registro.datosbio =  @datosbio
      end
      a = atributos_show - [:id] +
        [:datosbio]
      return a
    end

    def vistas_manejadas
      ['Persona']
    end

    def index(c = nil)
      super(c)
    end

    def listaparams
      atributos_form + [
        :id_pais,
        :id_departamento,
        :id_municipio,
        :id_clase,
        :tdocumento_id,
        :datosbio_attributes => [
          :afiliadoarl,
          :anioaprobacion,
          :correo,
          :cvulnerabilidad_id,
          :res_departamento_id,
          :direccionres,
          :discapacidad,
          :eps,
          :escolaridad_id,
          :fechaingespaciopp,
          :mayores60acargo,
          :menores12acargo,
          :res_municipio_id,
          :nivelsisben,
          :nombreespaciopp,
          :personashogar,
          :telefono,
          :veredares,
          :sistemapensional,
          :subsidioestado,
          :telefono,
          :tipocotizante
        ]
      ]
    end

  end
end
