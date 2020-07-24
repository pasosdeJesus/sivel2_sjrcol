# encoding: UTF-8

require 'test_helper'

class CausaagresionTest < ActiveSupport::TestCase

  PRUEBA_CAUSAAGRESION = {
    nombre: "Causaagresion",
    fechacreacion: "2020-07-22",
    created_at: "2020-07-22"
  }

  test "valido" do
    causaagresion = ::Causaagresion.create(
      PRUEBA_CAUSAAGRESION)
    assert(causaagresion.valid?)
    causaagresion.destroy
  end

  test "no valido" do
    causaagresion = ::Causaagresion.new(
      PRUEBA_CAUSAAGRESION)
    causaagresion.nombre = ''
    assert_not(causaagresion.valid?)
    causaagresion.destroy
  end

  test "existente" do
    skip
    causaagresion = ::Causaagresion.where(id: 0).take
    assert_equal(causaagresion.nombre, "SIN INFORMACIÓN")
  end

end
