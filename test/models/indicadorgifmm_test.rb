# encoding: UTF-8

require 'test_helper'

class IndicadorgifmmTest < ActiveSupport::TestCase

  PRUEBA_INDICADORGIFMM = {
    nombre: "Indicadorgifmm",
    fechacreacion: "2020-09-08",
    created_at: "2020-09-08"
  }

  test "valido" do
    indicadorgifmm = ::Indicadorgifmm.create(
      PRUEBA_INDICADORGIFMM)
    assert(indicadorgifmm.valid?)
    indicadorgifmm.destroy
  end

  test "no valido" do
    indicadorgifmm = ::Indicadorgifmm.new(
      PRUEBA_INDICADORGIFMM)
    indicadorgifmm.nombre = ''
    assert_not(indicadorgifmm.valid?)
    indicadorgifmm.destroy
  end

  test "existente" do
    skip
    indicadorgifmm = ::Indicadorgifmm.where(id: 0).take
    assert_equal(indicadorgifmm.nombre, "SIN INFORMACIÓN")
  end

end
