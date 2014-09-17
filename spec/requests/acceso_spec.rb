# encoding: UTF-8
require 'spec_helper'

describe "Control de acceso " do
  before { 
    @usuario = FactoryGirl.create(:usuario, 
                                  rol: Ability::ROLANALI, 
                                  regionsjr_id: 100)
    visit new_usuario_session_path 
    fill_in "Usuario", with: @usuario.nusuario
    fill_in "Clave", with: @usuario.password
    click_button "Iniciar Sesión"
    expect(page).to have_content("Administrar")
  }

  describe "analista" do
    it "puede crear caso" do
      visit new_caso_path
      @numcaso=find_field('Código').value

		  expect(@numcaso.to_i).to be > 0
      click_button "Guardar"
      expect(page).to have_content("El formulario tiene 3 errores.")
      #puts page.body
			# Driver no acepta: abrir solicitante para poner nombreclick_on "Eliminar" end
		  #expect(page).to have_content("Casos")
    end

  end

end
