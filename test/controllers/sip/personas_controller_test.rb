# encoding: UTF-8

require_relative '../../test_helper'

module Sip
  class PersonasControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers
    include Devise::Test::IntegrationHelpers

    setup do
      @current_usuario = ::Usuario.create(PRUEBA_USUARIO)
      sign_in @current_usuario
    end
    
    PRUEBA_PERSONA = {
      nombres: 'Nombres',
      apellidos: 'Apellidos',
      anionac: 1974,
      mesnac: 1,
      dianac: 1,
      sexo: 'F',
      id_pais: 170,
      id_departamento: 17,
      id_municipio: 1152,
      id_clase: 2626,
      tdocumento_id: 1,
      numerodocumento: '123',
      nacionalde: 170
    }
    
    PRUEBA_PERSONA_SINDOC = {
      nombres: 'Nombres',
      apellidos: 'Apellidos',
      sexo: 'F',
      numerodocumento: '',
    }

    test 'Crea una persona y la elimina' do
      assert_difference('Sip::Persona.count') do
        post personas_url, params: { persona: PRUEBA_PERSONA }
      end
      assert_redirected_to persona_url(Sip::Persona.last)
      assert_difference('Sip::Persona.count', -1) do
        delete persona_url(Sip::Persona.last)
      end
    end

    test 'no debería crear beneficiario sin numero de documento' do
      assert_no_difference('Sip::Persona.count') do
        post personas_url, params: { persona: PRUEBA_PERSONA_SINDOC }
      end
    end
  end
end
