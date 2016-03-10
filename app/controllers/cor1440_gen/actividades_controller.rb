# encoding: UTF-8
require_dependency "cor1440_gen/concerns/controllers/actividades_controller"

module Cor1440Gen
  class ActividadesController < ApplicationController
    include Cor1440Gen::Concerns::Controllers::ActividadesController

    Cor1440Gen.actividadg1 = "Funcionarias del SJR"
    Cor1440Gen.actividadg3 = "Funcionarios del SJR"

    def self.filtramas(par, ac)
        return ac
    end
  end
end
