# encoding: UTF-8

require 'test_helper'

class ModalidadentregaTest < ActiveSupport::TestCase

  PRUEBA_MODALIDADENTREGA = {
    nombre: "Modalidadentrega",
    fechacreacion: "2020-09-12",
    created_at: "2020-09-12"
  }

  test "valido" do
    modalidadentrega = ::Modalidadentrega.create(
      PRUEBA_MODALIDADENTREGA)
    assert(modalidadentrega.valid?)
    modalidadentrega.destroy
  end

  test "no valido" do
    modalidadentrega = ::Modalidadentrega.new(
      PRUEBA_MODALIDADENTREGA)
    modalidadentrega.nombre = ''
    assert_not(modalidadentrega.valid?)
    modalidadentrega.destroy
  end

  test "existente" do
    skip
    modalidadentrega = ::Modalidadentrega.where(id: 0).take
    assert_equal(modalidadentrega.nombre, "SIN INFORMACIÓN")
  end

end
