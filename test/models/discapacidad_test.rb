# encoding: UTF-8

require 'test_helper'

class DiscapacidadTest < ActiveSupport::TestCase

  PRUEBA_DISCAPACIDAD = {
    nombre: "Discapacidad",
    fechacreacion: "2018-11-26",
    created_at: "2018-11-26"
  }

  test "valido" do
    Discapacidad = ::Discapacidad.create(
      PRUEBA_DISCAPACIDAD)
    assert(Discapacidad.valid?)
    Discapacidad.destroy
  end

  test "no valido" do
    Discapacidad = ::Discapacidad.new(
      PRUEBA_DISCAPACIDAD)
    Discapacidad.nombre = ''
    assert_not(Discapacidad.valid?)
    Discapacidad.destroy
  end

  test "existente" do
    skip
    Discapacidad = ::Discapacidad.where(id: 0).take
    assert_equal(Discapacidad.nombre, "SIN INFORMACIÓN")
  end

end
