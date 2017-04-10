# encoding: UTF-8
require 'bcrypt'

class UsuariosController < Sip::UsuariosController

  def index
    authorize! :read, ::Usuario
    @usuarios = Usuario.where(
      'fechadeshabilitacion IS NULL').order(
      'LOWER(nusuario)').paginate(:page => params[:pagina], per_page: 20)
    render layout: '/application'
  end

end
