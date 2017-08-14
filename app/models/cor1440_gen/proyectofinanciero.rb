# encoding: UTF-8

require 'sivel2_sjr/concerns/models/proyectofinanciero'

module Cor1440Gen
  class Proyectofinanciero < ActiveRecord::Base

    include Sivel2Sjr::Concerns::Models::Proyectofinanciero


    # Recibe un grupo de proyectosfinancieros y los filtra 
    # de acuerdo al control de acceso del usuario o a 
    # otros parametros recibidos
    def filtra_acceso(current_usuario, pf, params = nil)
      if params && params[:filtro] && params[:filtro][:busoficina] &&
        params[:filtro][:busoficina] != ''
        pf = pf.joins(:oficina_proyectofinanciero).
          where('sivel2_sjr_oficina_proyectofinanciero.oficina_id = ?',
                params[:filtro][:busoficina])
      end
      return pf
    end

   
  end
end
