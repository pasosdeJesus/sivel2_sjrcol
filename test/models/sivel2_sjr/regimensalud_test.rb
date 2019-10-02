# encoding: UTF-8

require_relative '../../test_helper'

module Sivel2Sjr
  class RegimensaludTest < ActiveSupport::TestCase

    PRUEBA_REGIMENSALUD= {
      nombre: "Regimensalud",
      fechacreacion: "2014-12-02",
      created_at: "2014-12-02",
    }

    test "valido" do
      regimensalud = Regimensalud.create PRUEBA_REGIMENSALUD
      assert regimensalud.valid?
      regimensalud.destroy
    end

    test "no valido" do
      regimensalud = Regimensalud.new PRUEBA_REGIMENSALUD
      regimensalud.nombre = ''
      assert_not regimensalud.valid?
      regimensalud.destroy
    end

    test "existente" do
      regimensalud = Regimensalud.where(id: 0).take
      byebug
      assert_equal regimensalud.nombre, "SIN INFORMACIÓN"
    end

  end
end
