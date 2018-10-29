# encoding: UTF-8

require 'test_helper'

module Sip
  class LineaactorsocialTest < ActiveSupport::TestCase
  
      PRUEBA_TIPOACTORSOCIAL = {
        nombre: "Lineaactorsocial",
        fechacreacion: "2018-10-25",
        created_at: "2018-10-25",
      }
  
      test "valido" do
        lineaactorsocial = Sip::Lineaactorsocial.create(
          PRUEBA_TIPOACTORSOCIAL)
        assert(lineaactorsocial.valid?)
        lineaactorsocial.destroy
      end
  
      test "no valido" do
        lineaactorsocial = Sip::Lineaactorsocial.new(
          PRUEBA_TIPOACTORSOCIAL)
        lineaactorsocial.nombre = ''
        assert_not(lineaactorsocial.valid?)
        lineaactorsocial.destroy
      end
  
      test "existente" do
        skip
        lineaactorsocial = Sip::Lineaactorsocial.where(id: 0).take
        assert_equal(lineaactorsocial.nombre, "SIN INFORMACIÓN")
      end
  
  end
end
class LineaactorsocialTest < ActiveSupport::TestCase
end
