class DetallesfinancierosController < ApplicationController

  include ActionView::Helpers::AssetUrlHelper


  # Responde a requerimiento AJAX generado por cocoon creando una
  # nueva fuente de prensa para el caso que recibe por parametro 
  # params[:caso_id].  Pone valores simples en los campos requeridos
  def nuevo
    authorize! :new, Cor1440Gen::Actividad
    if !params[:actividad_id].nil?
      @detfinanciero = Detallefinanciero.new
      @detfinanciero.actividad_id = params[:actividad_id]
      if @detfinanciero.save(validate: false)
        respond_to do |format|
          format.js { render text: @detfinanciero.id.to_s }
          format.json { render json: @detfinanciero.id.to_s, 
                        status: :created }
          format.html { render inline: @detfinanciero.id.to_s }
        end
      else
        respond_to do |format|
          format.html { 
            render inline: "No pudo crear fuente frecuente: " +
            "'#{@detfinanciero.errors.message.to_s}'" 
          }
          format.json { 
            render json: @detfinanciero.errors, 
                        status: :unprocessable_entity 
          }
        end
      end
    else
      respond_to do |format|
        format.html { render inline: 'Falta identificacion de la actividad' }
      end
    end
  end # def nuevo

end 
