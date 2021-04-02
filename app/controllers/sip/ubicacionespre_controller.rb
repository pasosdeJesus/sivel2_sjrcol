# encoding: UTF-8

require 'sip/concerns/controllers/ubicacionespre_controller'

module Sip
  class UbicacionespreController < Sip::ModelosController

    include Sip::Concerns::Controllers::UbicacionespreController

    def index
      @ubicacionespre = Sip::Ubicacionpre.all
      respond_to do |format|
        format.json { render :json, inline: @ubicacionespre.to_json }
      end
    end

    def lugar
      if params[:term]
        term = Sip::Ubicacion.connection.quote_string(params[:term])
        consNomubi = term.downcase.strip #sin_tildes
        consNomubi.gsub!(/ +/, ":* & ")
        if consNomubi.length > 0
          consNomubi+= ":*"
        end
        pais = "AND pais_id=#{params[:pais].to_i}"
        dep = "AND departamento_id=#{params[:dep].to_i}"
        mun = "AND municipio_id=#{params[:mun].to_i}"
        clas = params[:clas] && params[:clas] != '' ? 
          "AND clase_id=#{params[:clas].to_i}" : ""
        # Usamos la funcion f_unaccent definida con el indice
        # en db/migrate/20200916022934_indice_ubicacionpre.rb
        where = " to_tsvector('spanish', " +
          "f_unaccent(ubicacionpre.nombre)) " +
          "@@ to_tsquery('spanish', '#{consNomubi}')";

        cons = "SELECT TRIM(nombre) AS value, pais_id, departamento_id, "\
          "municipio_id, clase_id, tsitio_id, lugar, sitio, "\
          "latitud, longitud "\
          "FROM public.sip_ubicacionpre AS ubicacionpre "\
          "WHERE #{where} #{pais} #{dep} #{mun} #{clas}"
        r = ActiveRecord::Base.connection.select_all cons
        respond_to do |format|
          format.json { render :json, inline: r.to_json }
          format.html { render inline: 'No responde con parametro term' }
        end
      end
    end
  end
end

