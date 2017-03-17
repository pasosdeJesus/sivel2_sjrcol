# encoding: UTF-8

require_relative '../test_helper'

class UsuarioTest < Capybara::Rails::TestCase
  test "no autentica con clave errada a usuario existente" do
    @usuario = Usuario.find_by(nusuario: 'sjrcol')
    visit main_app.new_usuario_session_path 
    fill_in "Usuario", with: @usuario.nusuario
    fill_in "Clave", with: 'ERRADA'
    click_button "Iniciar Sesión"
    assert_not page.has_content?("Administrar")
  end

  test "autentica con usuario creado en prueba" do
    @usuario = Usuario.create(PRUEBA_USUARIO)
    visit main_app.new_usuario_session_path 
    fill_in "Usuario", with: @usuario.nusuario
    fill_in "Clave", with: @usuario.password
    click_button "Iniciar Sesión"
    assert page.has_content?("Administrar")
    @usuario.destroy
  end

  it "autentica con usuario existente en base inicial" do
    @usuario = Usuario.find_by(nusuario: 'sjrcol')
    @usuario.password = 'sjrcol123'
    visit main_app.new_usuario_session_path 
    fill_in "Usuario", with: @usuario.nusuario
    fill_in "Clave", with: @usuario.password
    click_button "Iniciar Sesión"
    assert page.has_content?("Administrar")
  end

end

