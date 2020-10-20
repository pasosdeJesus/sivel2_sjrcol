# encoding: UTF-8

require 'sivel2_sjr/concerns/controllers/personas_controller'

module Sip
  class PersonasController < Heb412Gen::ModelosController

    include Sivel2Sjr::Concerns::Controllers::PersonasController

    def atributos_show
      atributos_show_sivel2_sjr + [
        :detallefinanciero_ids
      ]
    end

    def atributos_index
      atributos_index_sivel2_sjr  + [
        :detallefinanciero_ids
      ]
    end 

    def atributos_form
      atributos_form_sivel2_sjr
    end

    def lista_params
      atributos_form + [
        :id_pais,
        :id_departamento,
        :id_municipio,
        :id_clase,
        :tdocumento_id,
        :numerodocumento
      ] +
#     [
#       :datosbio_attributes => [
#         :afiliadoarl,
#         :anioaprobacion,
#         :correo,
#         :cvulnerabilidad_id,
#         :res_departamento_id,
#         :direccionres,
#         :otradiscapacidad,
#         :eps,
#         :discapacidad_id,
#         :escolaridad_id,
#         :espaciopart_id,
#         :fechaingespaciopp,
#         :mayores60acargo,
#         :menores12acargo,
#         :res_municipio_id,
#         :nivelsisben,
#         :nombreespaciopp,
#         :personashogar,
#         :telefono,
#         :veredares,
#         :sistemapensional,
#         :subsidioestado,
#         :telefono,
#         :tipocotizante
#       ]
#      ] + 
      [
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
      ] + [
        'proyectofinanciero_ids' => []
      ]
    end

    def validaciones(registro)
      if params[:persona][:numerodocumento].blank?
        @validaciones_error = "Se requiere número de documento" 
        return false
      end
      return true
    end

  end
end
