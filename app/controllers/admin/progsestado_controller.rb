# encoding: UTF-8
module Admin
  class ProgsestadoController < BasicasController
    before_action :set_progestado, only: [:show, :edit, :update, :destroy]
    load_and_authorize_resource

    def clase 
      "progestado"
    end

    def atributos_index
      [
        "id",  "nombre", "derecho_id",
        "fechacreacion", "fechadeshabilitacion"
      ]
    end


    # Use callbacks to share common setup or constraints between actions.
    def set_progestado
      @basica = Progestado.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def progestado_params
      params.require(:progestado).permit(*atributos_form)
    end

  end
end
