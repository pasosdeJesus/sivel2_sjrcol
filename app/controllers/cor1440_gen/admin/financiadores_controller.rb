# encoding: UTF-8
require_dependency "cor1440_gen/concerns/controllers/financiadores_controller"

module Cor1440Gen
  module Admin
    class FinanciadoresController < Sip::Admin::BasicasController
      include Cor1440Gen::Concerns::Controllers::FinanciadoresController
        before_action :set_financiador, 
          only: [:show, :edit, :update, :destroy]
        load_and_authorize_resource  class: Cor1440Gen::Financiador

        def atributos_index
          ["id", "nombre", "nombregifmm", "observaciones", "fechacreacion_localizada", 
           "habilitado"]
        end
    end
  end
end
