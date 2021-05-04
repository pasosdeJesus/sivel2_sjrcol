require_relative 'boot'

require 'rails/all'

# Requerir las gemas listas en el Gemfile, incluyendo gemas que haya
# limitado a :test, :development, o :production.
Bundler.require(*Rails.groups)

module Sivel2Sjrcol
  class Application < Rails::Application

    # config.load_defaults 6.0

    # Las configuraciones de config/environments/* tienen precedencia
    # sobre las especifciadas aquí.
    #
    # La configuración de la aplicación debería ir en archivos en
    # config/initializers -- todos los archivos .rb de esa ruta
    # se cargan automáticamente

    # Establecer Time.zone a la zona por omisión y que Active Record se
    # convierta a esa zona.
    # ejecute "rake -D time" para ver tareas relacionadas con encontrar
    # nombres de zonas. Por omisión es UTC.
    config.time_zone = 'America/Bogota'

    # El locale predeterminado es :en y se cargan todas las traducciones
    # de config/locales/*.rb,yml 
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    config.i18n.default_locale = :es

    config.active_record.schema_format = :sql

    config.railties_order = [:main_app, Sivel2Sjr::Engine, 
                             Cor1440Gen::Engine, Sivel2Gen::Engine,
                             Heb412Gen::Engine, Mr519Gen::Engine, 
                             Sip::Engine, :all]

    config.hosts <<  ENV.fetch('CONFIG_HOSTS', 'defensor.info').downcase

    config.relative_url_root = ENV.fetch('RUTA_RELATIVA', '/')

    # sip
    config.x.formato_fecha = ENV.fetch('FORMATO_FECHA', 'yyyy-mm-dd')

    # heb412
    config.x.heb412_ruta = Pathname(
      ENV.fetch('HEB412_RUTA', Rails.root.join('public', 'heb412').to_s)
    )

    # sivel2
    config.x.sivel2_consulta_web_publica = ENV['SIVEL2_CONSWEB_PUBLICA'] &&
      ENV['SIVEL2_CONSWEB_PUBLICA'] != ''

    config.x.sivel2_consweb_max = ENV.fetch('SIVEL2_CONSWEB_MAX', 2000)

    config.x.sivel2_consweb_epilogo = ENV.fetch(
      'SIVEL2_CONSWEB_EPILOGO',
      "<br>Si requiere más puede suscribirse a SIVeL Pro"
    ).html_safe

    config.x.sivel2_mapaosm_diasatras = ENV.fetch(
      'SIVEL2_CONSWEB_EPILOGO', 182)

    # sal7711
    config.x.url_colchon = ENV.fetch('COLCHON_ARTICULOS', 'colchon-articulos')
    config.x.sal7711_presencia_adjunto = true
    config.x.sal7711_presencia_adjuntodesc = true
    config.x.sal7711_presencia_fuenteprensa = true
    config.x.sal7711_presencia_fecha = true
    config.x.sal7711_presencia_pagina = false


    # cor1440
    config.x.cor1440_permisos_por_oficina = 
      (ENV['COR1440_PERMISOS_POR_OFICINA'] && ENV['COR1440_PERMISOS_POR_OFICINA'] != '')

    if ENV.fetch('WC_PERMISOS', '') != ''
      config.web_console.permissions = ENV['WC_PERMISOS']
    end
  end
end

