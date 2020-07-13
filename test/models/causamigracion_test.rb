# encoding: UTF-8

require 'test_helper'

class CausamigracionTest < ActiveSupport::TestCase

  PRUEBA_CAUSAMIGRACION = {
    nombre: "Causamigracion",
    fechacreacion: "2020-07-12",
    created_at: "2020-07-12"
  }

  test "valido" do
    causamigracion = ::Causamigracion.create(
      PRUEBA_CAUSAMIGRACION)
    assert(causamigracion.valid?)
    causamigracion.destroy
  end

  test "no valido" do
    causamigracion = ::Causamigracion.new(
      PRUEBA_CAUSAMIGRACION)
    causamigracion.nombre = ''
    assert_not(causamigracion.valid?)
    causamigracion.destroy
  end

  test "existente" do
    skip
    causamigracion = ::Causamigracion.where(id: 0).take
    assert_equal(causamigracion.nombre, "SIN INFORMACIÓN")
  end

end
