module Sip
  class ClavesrespaldosController < Sip::ModelosController

    def clase
      'Sip::Claverespaldo'
    end
    
    def atributos_show
      [ :id,
        :clave,
        :created_at,
        :updated_at
      ]
    end

    def atributos_index
      atributos_show
    end 

    def atributos_form
      atributos_show - [:id, :created_at, :updated_at]
    end

    def lista_params
      atributos_form + [:id]
    end

    def create
      authorize! :new, Sip::Claverespaldo
      filtra_contenido_params
      pf = claverespaldo_params.merge(
        created_at: Time.now, updated_at: Time.now)
      registro = Sip::Claverespaldo.new(pf)
      create_gen(registro)
    end

    def index_reordenar(c)
      c.reorder('id DESC')
    end

    def claverespaldo_params
      params.require(:claverespaldo).permit(lista_params)
    end


  end
end
