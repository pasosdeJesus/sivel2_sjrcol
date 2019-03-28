# encoding: UTF-8

require 'sivel2_sjr/concerns/controllers/personas_controller'

module Sip
  class PersonasController < Heb412Gen::ModelosController

    include Sivel2Sjr::Concerns::Controllers::PersonasController


    def atributos_form
      if @registro && @registro.datosbio.nil?
        @datosbio = Sip::Datosbio.new()
        @datosbio.tipocotizante = 'B'
        @datosbio.fecharecoleccion = Date.today()
        @datosbio.save!
        @registro.datosbio =  @datosbio
      end
      a = atributos_show - [:id] +
        [:datosbio, :caracterizaciones]
      return a
    end

    def lista_params
      atributos_form + [
        :id_pais,
        :id_departamento,
        :id_municipio,
        :id_clase,
        :tdocumento_id 
      ] + [
        :datosbio_attributes => [
          :afiliadoarl,
          :anioaprobacion,
          :correo,
          :cvulnerabilidad_id,
          :res_departamento_id,
          :direccionres,
          :otradiscapacidad,
          :eps,
          :discapacidad_id,
          :escolaridad_id,
          :espaciopart_id,
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
      ] + [
        "caracterizacionpersona_attributes" =>
        [ :id,
          "respuestafor_attributes" => [
            :id,
            "valorcampo_attributes" => [
              :valor,
              :campo_id,
              :id
            ]
        ] ]
      ]
    end

  end
end
