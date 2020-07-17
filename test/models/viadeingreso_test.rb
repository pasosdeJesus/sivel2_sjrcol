# encoding: UTF-8

require 'test_helper'

class ViadeingresoTest < ActiveSupport::TestCase

  PRUEBA_VIADEINGRESO = {
    nombre: "Viadeingreso",
    fechacreacion: "2020-07-11",
    created_at: "2020-07-11"
  }

  test "valido" do
    viadeingreso = ::Viadeingreso.create(
      PRUEBA_VIADEINGRESO)
    assert(viadeingreso.valid?)
    viadeingreso.destroy
  end

  test "no valido" do
    viadeingreso = ::Viadeingreso.new(
      PRUEBA_VIADEINGRESO)
    viadeingreso.nombre = ''
    assert_not(viadeingreso.valid?)
    viadeingreso.destroy
  end

  test "existente" do
    skip
    viadeingreso = ::Viadeingreso.where(id: 0).take
    assert_equal(viadeingreso.nombre, "SIN INFORMACIÓN")
  end

end
