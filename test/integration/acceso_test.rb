# encoding: UTF-8

require_relative '../test_helper'

class AccesoTest < Capybara::Rails::TestCase

  test "puede crear caso" do
    @usuario = Usuario.create(PRUEBA_USUARIO)
    visit new_usuario_session_path 
    fill_in "Usuario", with: @usuario.nusuario
    fill_in "Clave", with: @usuario.password
    click_button "Iniciar Sesión"
    assert page.has_content?("Administrar")


    visit '/casos/nuevo'
    @numcaso=find_field('Código').value

    assert (@numcaso.to_i > 0)
    click_button "Guardar"
    puts page.body
    assert page.has_content?("5 errores.")
    #puts page.body
    # Driver no acepta: abrir solicitante para poner nombreclick_on "Eliminar" end
    #expect(page).to have_content("Casos")
  end

end
