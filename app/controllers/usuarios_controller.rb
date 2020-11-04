# encoding: UTF-8
require 'bcrypt'

require 'sivel2_sjr/concerns/controllers/usuarios_controller'

class UsuariosController < Sip::ModelosController

  include Sivel2Sjr::Concerns::Controllers::UsuariosController

  def index
    authorize! :read, ::Usuario
    @registros= @usuarios = Usuario.order(
      'LOWER(nusuario)').paginate(:page => params[:pagina], per_page: 20)
    super(@usuarios)
    #render layout: '/application'
  end
 
  def atributos_index
    [ :id,
      :nusuario,
      :nombre,
      :rol,
      :oficina_id,
      :fincontrato,
      :email,
      :tema,
      :habilitado,
      :created_at_localizada ]
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
          :locked_at,
          :fincontrato
        ]
    r
  end

  def usuario_params
    p = params.require(:usuario).permit(lista_params + [:fincontrato])
    return p
  end
end
