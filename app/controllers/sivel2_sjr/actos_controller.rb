# encoding: UTF-8
require 'date'

module Sivel2Sjr
  class ActosController < Sivel2Gen::ActosController

    # Crea nuevos actos procesando parámetros
    def agregar
      des_id = params[:desplazamiento]
      presponsable = "caso_acto_id_presponsable_#{des_id}"
      categoria = "caso_acto_id_categoria_#{des_id}"
      persona = "caso_acto_id_persona_#{des_id}"
      fecha = "caso_acto_fecha_#{des_id}"
      desplazamiento = "caso_acto_id_desplazamiento_#{des_id}"
      if params[:caso][:id].nil?
        respond_to do |format|
          format.html { render inline: 'Falta identificacion del caso' }
        end
        return
      elsif !params[presponsable]
        respond_to do |format|
          format.html { render inline: 'Debe tener Presunto Responsable' }
        end
        return
      elsif !params[categoria]
        respond_to do |format|
          format.html { render inline: 'Debe tener Categoria' }
        end
        return
      elsif !params[persona]
        respond_to do |format|
          format.html { render inline: 'Debe tener Víctima' }
        end
        return
      elsif !params[fecha]
        respond_to do |format|
          format.html { render inline: 'Debe tener Fecha' }
        end
        return
      else
        params[presponsable].each do |cpresp|
          presp = cpresp.to_i
          params[categoria].each do |ccat|
            cat = ccat.to_i
            params[persona].each do |cvic|
              vic = cvic.to_i
              @caso = Sivel2Gen::Caso.find(params[:caso][:id])
              @caso.current_usuario = current_usuario
              authorize! :update, @caso
              acto = Sivel2Gen::Acto.new(
                id_presponsable: presp,
                id_categoria: cat,
                id_persona: vic,
              )
              acto.caso = @caso
              acto.save
              actosjr = Sivel2Sjr::Actosjr.new(
                fecha: params[fecha],
                desplazamiento_id: params[desplazamiento]!="" ? params[desplazamiento].to_i : nil
              )
              actosjr.acto = acto
              actosjr.save!
            end
          end
        end
      end
      @params = params
      respond_to do |format|
        format.js { render 'refrescar' }
      end
    end

    def nuevopr
      des_id = params[:desplazamiento]
      nombre_pr = "nombre_nuevopr_#{des_id}"
      papa_pr = "papa_nuevopr_#{des_id}"
      observaciones_pr = "observaciones_nuevopr_#{des_id}"
      if !params[nombre_pr]
        respond_to do |format|
          format.html { render inline: 'El presunto responsable debe tener un nombre' }
        end
        return
      else
        papa = Sivel2Gen::Presponsable.where(id: params[papa_pr])
        papa_id  = papa.empty? ? nil : papa[0].id
        pr = Sivel2Gen::Presponsable.new(
          nombre: params[nombre_pr],
          observaciones: params[observaciones_pr],
          papa_id: papa_id, 
          fechacreacion: Date.today()
        )
        pr.save!
        params[:id_nuevopr] = pr.id
      end
      @params = params
      respond_to do |format|
        format.js { render 'refrescar' }
      end
    end
    def eliminar
      acto = Sivel2Gen::Acto.where(id: params[:id_acto].to_i).take
      params[:desplazamiento_id] = Sivel2Sjr::Actosjr.where(id_acto: acto.id)[0].desplazamiento_id.to_s
      @params = params
      if acto && acto.actosjr
        @caso = acto.caso
        acto.actosjr.destroy!
      end
      respond_to do |format|
        format.js { render 'refrescar' }
      end
    end

  end
end
