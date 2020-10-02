# encoding: UTF-8

require 'test_helper'

class MecanismodeentregaTest < ActiveSupport::TestCase

  PRUEBA_MECANISMODEENTREGA = {
    nombre: "Mecanismodeentrega",
    fechacreacion: "2020-09-11",
    created_at: "2020-09-11"
  }

  test "valido" do
    mecanismodeentrega = ::Mecanismodeentrega.create(
      PRUEBA_MECANISMODEENTREGA)
    assert(mecanismodeentrega.valid?)
    mecanismodeentrega.destroy
  end

  test "no valido" do
    mecanismodeentrega = ::Mecanismodeentrega.new(
      PRUEBA_MECANISMODEENTREGA)
    mecanismodeentrega.nombre = ''
    assert_not(mecanismodeentrega.valid?)
    mecanismodeentrega.destroy
  end

  test "existente" do
    skip
    mecanismodeentrega = ::Mecanismodeentrega.where(id: 0).take
    assert_equal(mecanismodeentrega.nombre, "SIN INFORMACIÓN")
  end

end
