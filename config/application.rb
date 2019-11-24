require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Sivel2Sjrcol
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
    
    config.time_zone = 'Bogota'
    config.i18n.default_locale = :es
    config.active_record.schema_format = :sql
    config.x.formato_fecha = 'yyyy-mm-dd'
    config.x.heb412_ruta = Rails.root.join('public', 'heb412') 
    
    config.x.url_colchon = 'colchon-articulos'
    config.x.sal7711_presencia_adjunto = true
    config.x.sal7711_presencia_adjuntodesc = true
    config.x.sal7711_presencia_fuenteprensa = true
    config.x.sal7711_presencia_fecha = true
    config.x.sal7711_presencia_pagina = false

    config.x.cor1440_permisos_por_oficina = true

    config.hosts << ENV['CONFIG_HOSTS'] || '127.0.0.1'

    #config.web_console.permission = ['186.102.147.134']
  end
end
