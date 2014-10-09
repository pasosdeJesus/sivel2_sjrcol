# encoding: UTF-8
module Admin
  class MotivossjrController < BasicasController
    before_action :set_motivosjr, only: [:show, :edit, :update, :destroy]
    load_and_authorize_resource

    def clase 
      "motivosjr"
    end

    def atributos_index
      [
        "id",  "nombre", "derecho_id",
        "fechacreacion", "fechadeshabilitacion"
      ]
    end


    # Use callbacks to share common setup or constraints between actions.
    def set_motivosjr
      @basica = Motivosjr.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def motivosjr_params
      params.require(:motivosjr).permit(*atributos_form)
    end

  end
end
