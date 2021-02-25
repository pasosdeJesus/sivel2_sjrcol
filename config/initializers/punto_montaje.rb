Sivel2Sjrcol::Application.config.relative_url_root = ENV.fetch(
  'RUTA_RELATIVA', '/')
Sivel2Sjrcol::Application.config.assets.prefix = ENV.fetch(
  'RUTA_RELATIVA', '/') + 'assets'
