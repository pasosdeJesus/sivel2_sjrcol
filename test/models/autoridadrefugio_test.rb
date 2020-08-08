# encoding: UTF-8

require 'test_helper'

class AutoridadrefugioTest < ActiveSupport::TestCase

  PRUEBA_AUTORIDADREFUGIO = {
    nombre: "Autoridadrefugio",
    fechacreacion: "2020-08-06",
    created_at: "2020-08-06"
  }

  test "valido" do
    autoridadrefugio = ::Autoridadrefugio.create(
      PRUEBA_AUTORIDADREFUGIO)
    assert(autoridadrefugio.valid?)
    autoridadrefugio.destroy
  end

  test "no valido" do
    autoridadrefugio = ::Autoridadrefugio.new(
      PRUEBA_AUTORIDADREFUGIO)
    autoridadrefugio.nombre = ''
    assert_not(autoridadrefugio.valid?)
    autoridadrefugio.destroy
  end

  test "existente" do
    skip
    autoridadrefugio = ::Autoridadrefugio.where(id: 0).take
    assert_equal(autoridadrefugio.nombre, "SIN INFORMACIÓN")
  end

end
