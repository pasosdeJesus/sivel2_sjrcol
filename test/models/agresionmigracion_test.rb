# encoding: UTF-8

require 'test_helper'

class AgresionmigracionTest < ActiveSupport::TestCase

  PRUEBA_AGRESIONMIGRACION = {
    nombre: "Agresionmigracion",
    fechacreacion: "2020-07-21",
    created_at: "2020-07-21"
  }

  test "valido" do
    agresionmigracion = ::Agresionmigracion.create(
      PRUEBA_AGRESIONMIGRACION)
    assert(agresionmigracion.valid?)
    agresionmigracion.destroy
  end

  test "no valido" do
    agresionmigracion = ::Agresionmigracion.new(
      PRUEBA_AGRESIONMIGRACION)
    agresionmigracion.nombre = ''
    assert_not(agresionmigracion.valid?)
    agresionmigracion.destroy
  end

  test "existente" do
    skip
    agresionmigracion = ::Agresionmigracion.where(id: 0).take
    assert_equal(agresionmigracion.nombre, "SIN INFORMACIÓN")
  end

end
