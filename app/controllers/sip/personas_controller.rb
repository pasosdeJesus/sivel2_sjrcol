# encoding: UTF-8

require 'sivel2_sjr/concerns/controllers/personas_controller'

module Sip
  class PersonasController < Heb412Gen::ModelosController

    include Sivel2Sjr::Concerns::Controllers::PersonasController
    include Sip::Concerns::Controllers::ModelosController

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
      p = a.index(:fechanac)
      a[p] = :anionac
      a.insert(p, :mesnac)
      a.insert(p, :dianac)
      return a
    end

    def lista_params
      atributos_form + [
        :id_pais,
        :id_departamento,
        :id_municipio,
        :id_clase,
        :tdocumento_id,
        :numerodocumento
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
              :valor_ids,
              :campo_id,
              :id
            ] + [:valor_ids => []]
          ]
        ] 
      ]
    end

    def update
      if params[:persona][:numerodocumento].blank?
        redirect_to edit_persona_path, 
          flash: { error: "Se requiere numero de documento" }
      else
        update_gen
      end
    end
  end
end
