# encoding: UTF-8

require_dependency 'sivel2_sjr/concerns/controllers/casos_controller'

module Sivel2Sjr
  class CasosController < ApplicationController

    include Sivel2Sjr::Concerns::Controllers::CasosController

          # Campos en filtro
          def campos_filtro1
            [:codigo,
              :fechaini, :fechafin, 
              :fecharecini, :fecharecfin, 
              :oficina_id, :usuario_id,
              :ultimafechaatencionini, :ultimafechaatencionfin,
              :statusmigratorio_id,
              :nombressp, :apellidossp,
              :nombres, :apellidos, :sexo, :rangoedad_id, 
              :descripcion
            ]
          end

          # Campos por presentar en listado index
          def incluir_inicial
            ['casoid', 'contacto', 'fecharec', 'oficina', 
              'nusuario', 'fecha', 'expulsion',
              'llegada', 'ultimafechaatencion', 'memo'
            ]
          end

          # Ordenamiento inicial por este campo
          def campoord_inicial
            'fecharec'
          end

  end
end
