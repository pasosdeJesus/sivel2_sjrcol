# encoding: UTF-8

require_dependency 'sivel2_sjr/concerns/controllers/proyectosfinancieros_controller'

module Cor1440Gen
  class ProyectosfinancierosController < Heb412Gen::ModelosController
    
    include Cor1440Gen::Concerns::Controllers::ProyectosfinancierosController

    load_and_authorize_resource  class: Cor1440Gen::Proyectofinanciero,
      only: [:new, :create, :destroy, :edit, :update, :index, :show,
             :objetivospf]

     def proyectofinanciero_params_cor1440_gen
       atributos_form + [:responsable_id] + [ 
         :actividadpf_attributes =>  [
           :id, 
           :resultadopf_id,
           :actividadtipo_id,
           :nombrecorto, 
           :titulo, 
           :descripcion,
           :indicadorgifmm_id, 
           :_destroy ] 
       ] + [
         :anexo_proyectofinanciero_attributes => [
           :id,
           :proyectofinanciero_id,
           :_destroy,
           :anexo_attributes => [
             :adjunto, 
             :descripcion, 
             :id, 
             :_destroy ] ]
       ] + [
         :beneficiario_ids => []
       ] + [
         :caracterizacion_ids => []
       ] + [
         :plantillahcm_ids => []
       ] + [
         :indicadorobjetivo_attributes =>  [
           :id, 
           :objetivopf_id,
           :numero, 
           :indicador, 
           :tipoindicador_id, 
           :_destroy ] 
       ] + [ 
         :indicadorpf_attributes =>  [
           :id, 
           :resultadopf_id,
           :numero, 
           :indicador, 
           :tipoindicador_id,
           :_destroy ] 
       ] + [ 
         :objetivopf_attributes =>  [
           :id, 
           :numero, 
           :objetivo, 
           :_destroy ] 
       ] + [
         :proyectofinanciero_usuario_attributes => [
           :id,
           :usuario_id,
           :_destroy ]
       ] + [
         :resultadopf_attributes =>  [
           :id, 
           :objetivopf_id,
           :numero, 
           :resultado, 
           :_destroy ] 
       ]
     end
  end
end
