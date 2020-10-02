require_dependency "cor1440_gen/concerns/controllers/actividadespf_controller"

module Cor1440Gen
  class ActividadespfController < Heb412Gen::ModelosController

    include Cor1440Gen::Concerns::Controllers::ActividadespfController

    before_action :set_actividad, 
      only: [:show, :index]
    load_and_authorize_resource class: Cor1440Gen::Actividadpf

    def clase
      'Cor1440Gen::Actividadpf'
    end

    def atributos_index
      [:id, 
       :nombrecorto,
       :titulo,
       :descripcion,
       :resultadopf_id,
       :actividadtipo_id,
       :indicadorgifmm_id
      ]
    end

    def atributos_show_json
      [:id, 
       :nombrecorto,
       :titulo,
       :descripcion,
       :resultadopf_id,
       :actividadtipo_id,
       :indicadorgifmm_id
      ]
    end


    def set_actividad
      @actividadpf = @registro = nil
      if params && params[:id] && params[:id].to_i > 0 && 
        Cor1440Gen::Actividadpf.where(id: params[:id].to_i).count > 0
      	@actividadpf = @registro = Cor1440Gen::Actividadpf.find(params[:id].to_i)
      end
    end

  end
end
