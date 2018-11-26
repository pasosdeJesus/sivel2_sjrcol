# encoding: UTF-8

require 'test_helper'

class EspaciopartTest < ActiveSupport::TestCase

  PRUEBA_ESPACIOPART = {
    id: 100,
    nombre: "Espaciopart",
    fechacreacion: "2018-11-26",
    created_at: "2018-11-26"
  }

  test "valido" do
    Espaciopart = ::Espaciopart.create(
      PRUEBA_ESPACIOPART)
    assert(Espaciopart.valid?)
    Espaciopart.destroy
  end

  test "no valido" do
    Espaciopart = ::Espaciopart.new(
      PRUEBA_ESPACIOPART)
    Espaciopart.nombre = ''
    assert_not(Espaciopart.valid?)
    Espaciopart.destroy
  end

  test "existente" do
    skip
    Espaciopart = ::Espaciopart.where(id: 0).take
    assert_equal(Espaciopart.nombre, "SIN INFORMACIÓN")
  end

end
