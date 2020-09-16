module Sip
  class UbicacionespreController < Sip::ModelosController

    before_action :set_persona, only: [:show, :edit, :update, :destroy]
    load_and_authorize_resource class: Sip::Persona


    def index(c = nil)
      if c == nil
        c = Sip::Persona.all
      end
      if params[:term]
        term = Sip::Ubicacion.connection.quote_string(params[:term])
        consNomubi = term.downcase.strip #sin_tildes
        consNomubi.gsub!(/ +/, ":* & ")
        if consNomubi.length > 0
          consNomubi+= ":*"
        end
        # Usamos la funcion f_unaccent definida con el indice
        # en db/migrate/20200916022934_indice_ubicacionpre.rb
        where = " to_tsvector('spanish', f_unaccent(ubicacionpre.nombre)) " +
          "@@ to_tsquery('spanish', '#{consNomubi}')";

        cons = "SELECT TRIM(nombre) AS value, id AS id " +
          "FROM public.sip_ubicacionpre AS ubicacionpre " +
          "WHERE #{where} ORDER BY 1";

        r = ActiveRecord::Base.connection.select_all cons
        respond_to do |format|
          format.json { render :json, inline: r.to_json }
          format.html { render inline: 'No responde con parametro term' }
        end
      else
        super(c)
      end
    end


  end
end

