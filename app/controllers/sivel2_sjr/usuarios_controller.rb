# encoding: UTF-8

require 'sip/concerns/controllers/usuarios_controller'

module Sivel2Sjr
  module Concerns
    module Controllers
      module UsuariosController

        extend ActiveSupport::Concern

        included do
          include Sip::Concerns::Controllers::UsuariosController

          def atributos_index
            [ :id,
              :nusuario,
              :nombre,
              :rol,
              :oficina_id,
              :email,
              :tema,
              :habilitado,
              :created_at_localizada
            ]
          end

          def atributos_form
            r = [ :nusuario,
                  :nombre,
                  :descripcion,
                  :rol,
                  :oficina_id] +
                [ :etiqueta_ids =>  [] ] +
                [ :email,
                  :tema,
                  :idioma,
                  :encrypted_password,
                  :fechacreacion_localizada,
                  :fechadeshabilitacion_localizada,
                  :failed_attempts,
                  :unlock_token,
                  :locked_at
                ]
            r
          end

          private

          def usuario_params
            p = params.require(:usuario).permit(
              :id, :nusuario, :password, 
              :nombre, :descripcion, :oficina_id,
              :rol, :idioma, :email, :encrypted_password, 
              :fechacreacion_localizada, :fechadeshabilitacion_localizada, 
              :reset_password_token, 
              :tema_id,
              :reset_password_sent_at, :remember_created_at, :sign_in_count, 
              :current_sign_in_at, :last_sign_in_at, :current_sign_in_ip, 
              :failed_attempts, :unlock_token, :locked_at,
              :last_sign_in_ip, :etiqueta_ids => []
            )
            return p
          end

        end  # included

      end
    end
  end
end
