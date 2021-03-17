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
  end
end

