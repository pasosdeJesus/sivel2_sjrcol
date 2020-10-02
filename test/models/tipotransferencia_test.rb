# encoding: UTF-8

require 'test_helper'

class TipotransferenciaTest < ActiveSupport::TestCase

  PRUEBA_TIPOTRANSFERENCIA = {
    nombre: "Tipotransferencia",
    fechacreacion: "2020-09-12",
    created_at: "2020-09-12"
  }

  test "valido" do
    tipotransferencia = ::Tipotransferencia.create(
      PRUEBA_TIPOTRANSFERENCIA)
    assert(tipotransferencia.valid?)
    tipotransferencia.destroy
  end

  test "no valido" do
    tipotransferencia = ::Tipotransferencia.new(
      PRUEBA_TIPOTRANSFERENCIA)
    tipotransferencia.nombre = ''
    assert_not(tipotransferencia.valid?)
    tipotransferencia.destroy
  end

  test "existente" do
    skip
    tipotransferencia = ::Tipotransferencia.where(id: 0).take
    assert_equal(tipotransferencia.nombre, "SIN INFORMACIÓN")
  end

end
