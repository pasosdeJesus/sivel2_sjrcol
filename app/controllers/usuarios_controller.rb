# encoding: UTF-8
require 'bcrypt'

require 'sivel2_sjr/concerns/controllers/usuarios_controller'

class UsuariosController < Sip::ModelosController

  include Sivel2Sjr::Concerns::Controllers::UsuariosController

  def index
    authorize! :read, ::Usuario
    @registros= @usuarios = Usuario.where(
      'fechadeshabilitacion IS NULL').order(
      'LOWER(nusuario)').paginate(:page => params[:pagina], per_page: 20)
    super(@usuarios)
    #render layout: '/application'
  end

end
