# encoding: UTF-8
require 'bcrypt'

class UsuariosController < Sip::UsuariosController

  def index
    @usuarios = Usuario.where(
      'fechadeshabilitacion IS NULL').order(
      'LOWER(nusuario)').paginate(:page => params[:pagina], per_page: 20)
  end

end
