# encoding: UTF-8


require 'sivel2_sjr/concerns/controllers/validarcasos_controller'

module Sivel2Gen
  class ValidarcasosController < ApplicationController

    include Sivel2Sjr::Concerns::Controllers::ValidarcasosController

    def validar_sinderechovulnerado
      casos = ini_filtro
      casos = casos.joins('JOIN sivel2_sjr_respuesta ON
              sivel2_sjr_respuesta.id_caso=sivel2_sjr_casosjr.id_caso')
      validacion_estandar(
        casos, 
        'Casos con respuesta pero sin derecho vulnerado',
        'sivel2_sjr_respuesta.id NOT IN 
               (SELECT id_respuesta FROM sivel2_sjr_derecho_respuesta)'
      )
    end

    ## Sobrecarga una de sivel2_sjr 
    def valida_sinayudasjr
      casos = ini_filtro
      casos = casos.joins('JOIN sivel2_sjr_respuesta ON
              sivel2_sjr_respuesta.id_caso=sivel2_sjr_casosjr.id_caso')
      validacion_estandar(
        casos, 
        'Casos con respuesta pero sin respuesta del SJR',
        'sivel2_sjr_respuesta.id NOT IN 
           (SELECT id_respuesta FROM sivel2_sjr_ayudasjr_respuesta)
         AND sivel2_sjr_respuesta.id NOT IN 
           (SELECT id_respuesta FROM sivel2_sjr_aslegal_respuesta)
         AND sivel2_sjr_respuesta.id NOT IN 
           (SELECT id_respuesta FROM sivel2_sjr_motivosjr_respuesta)
        '
      )
    end

    def validar_interno
      @rango_fechas = 'Fecha de recepción'
      validar_sivel2_sjr
      validar_sinderechovulnerado
      validar_sivel2_gen
    end # def validar_interno
         
  end
end
