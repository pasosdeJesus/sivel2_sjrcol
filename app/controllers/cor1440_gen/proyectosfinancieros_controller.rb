# encoding: UTF-8

require_dependency 'sivel2_sjr/concerns/controllers/proyectosfinancieros_controller'

module Cor1440Gen
  class ProyectosfinancierosController < Heb412Gen::ModelosController
    
    include Cor1440Gen::Concerns::Controllers::ProyectosfinancierosController

    before_action :set_proyectofinanciero,
      only: [:show, :edit, :update, :destroy]
    skip_before_action :set_proyectofinanciero, only: [:validar]

    load_and_authorize_resource  class: Cor1440Gen::Proyectofinanciero,
      only: [:new, :create, :destroy, :edit, :update, :index, :show,
             :objetivospf]

    def atributos_index
      atributos_index_cor1440 - [:titulo]
    end

    def filtra_contenido_params
      if !params || !params[:proyectofinanciero] 
        return
      end

      # Deben eliminarse actividadespf creadas con AJAX
      if params[:proyectofinanciero][:actividadpf_attributes]
        porelimd = []
        params[:proyectofinanciero][:actividadpf_attributes].each do |l, vel|
          apf = Cor1440Gen::Actividadpf.find(vel[:id].to_i)
          if vel['_destroy'] == "1" || vel['_destroy'] == "true"
            apf.resultadopf_id = ""
            apf.actividadtipo_id = ""
            apf.destroy
            # Quitar de los parámetros
            porelimd.push(l)  
          end
        end
        porelimd.each do |l|
          params[:proyectofinanciero][:actividadpf_attributes].delete(l)
        end
      end

    end
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
