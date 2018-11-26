# encoding: UTF-8

require 'test_helper'


require 'test_helper'

module Sip
  class TipoactorsocialTest < ActiveSupport::TestCase
  
      PRUEBA_TIPOACTORSOCIAL = {
        nombre: "Tipoactorsocial",
        fechacreacion: "2018-10-25",
        created_at: "2018-10-25",
      }
  
      test "valido" do
        tipoactorsocial = Sip::Tipoactorsocial.create(
          PRUEBA_TIPOACTORSOCIAL)
        assert(tipoactorsocial.valid?)
        tipoactorsocial.destroy
      end
  
      test "no valido" do
        tipoactorsocial = Sip::Tipoactorsocial.new(
          PRUEBA_TIPOACTORSOCIAL)
        tipoactorsocial.nombre = ''
        assert_not(tipoactorsocial.valid?)
        tipoactorsocial.destroy
      end
  
      test "existente" do
        skip
        tipoactorsocial = Sip::Tipoactorsocial.where(id: 0).take
        assert_equal(tipoactorsocial.nombre, "SIN INFORMACIÓN")
      end
  
  end
end
