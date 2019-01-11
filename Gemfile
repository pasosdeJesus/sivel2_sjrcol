source 'https://rubygems.org'

# Rails (internacionalización)
gem "rails", '~> 5.2.1'

gem "rails-i18n"

gem 'bigdecimal'

gem 'bootsnap', '>=1.1.0', require: false

# Colores en terminal
gem 'colorize'

# Servidor web
gem 'puma'

gem 'redcarpet'

# Cuadros de selección para búsquedas
gem 'chosen-rails'

# Generación de PDF
gem "prawn"
gem "prawnto_2",  :require => "prawnto"
gem "prawn-table"

# Plantilla ODT
gem "odf-report"


# Plantilla ODS
#gem "rspreadsheet", path: '../rspreadsheet'
gem "rspreadsheet"#, git: "https://github.com/gorn/rspreadsheet"
gem 'libxml-ruby'

# Postgresql
gem "pg"#, '~> 0.21'

# Maneja variables de ambiente (como claves y secretos) en .env
gem "foreman"

# API JSON facil. Ver: https://github.com/rails/jbuilder
gem "jbuilder"

gem 'sass'
gem 'sass-rails'
#gem 'compass-rails'
#gem 'compass'

# Uglifier comprime recursos Javascript
gem "uglifier"

# CoffeeScript para recuersos .js.coffee y vistas
gem "coffee-rails"

# jquery como librería JavaScript
gem "jquery-rails"
gem "jquery-ui-rails"

# Seguir enlaces más rápido. Ver: https://github.com/rails/turbolinks
gem "turbolinks"

# Ambiente de CSS
gem "twitter-bootstrap-rails"
gem "bootstrap-datepicker-rails"
gem "font-awesome-rails"

gem "chartkick"

# Formularios simples 
gem "simple_form"

# Formularios anidados (algunos con ajax)
gem "cocoon", git: "https://github.com/vtamara/cocoon.git", branch: 'new_id_with_ajax'


# Autenticación y roles
gem "devise"
gem "devise-i18n"
gem "cancancan"
gem "bcrypt"

# Listados en páginas
gem "will_paginate"

# ICU con CLDR
gem 'twitter_cldr'

# Maneja adjuntos
gem "paperclip"

# Zonas horarias
gem "tzinfo"

# Motor SIP
gem 'sip', git: "https://github.com/pasosdeJesus/sip.git"
#gem 'sip', path: '../sip'

# Motor Heb412_gen
gem 'heb412_gen', git: "https://github.com/pasosdeJesus/heb412_gen.git"
#gem 'heb412_gen', path: '../heb412_gen'

# Motor formularios y encuestas
gem 'mr519_gen', git: "https://github.com/pasosdeJesus/mr519_gen.git"
#gem 'mr519_gen', path: '../mr519_gen'

# Motor de SIVeL 2
gem 'sivel2_gen', git: "https://github.com/pasosdeJesus/sivel2_gen.git"
#gem 'sivel2_gen', path: '../sivel2_gen'

# Motor Cor1440_gen
gem 'cor1440_gen', git: "https://github.com/pasosdeJesus/cor1440_gen.git"
#gem 'cor1440_gen', path: '../cor1440_gen'

# Motor de SIVeL 2 - SJR
gem 'sivel2_sjr', git: "https://github.com/pasosdeJesus/sivel2_sjr.git"
#gem 'sivel2_sjr', path: '../sivel2_sjr'

# Motor Sal7711_gen
gem 'sal7711_gen', git: "https://github.com/pasosdeJesus/sal7711_gen.git"
#gem 'sal7711_gen', path: '../sal7711_gen'

# Motor Sal7711_web
gem 'sal7711_web', git: "https://github.com/pasosdeJesus/sal7711_web.git"
#gem 'sal7711_web', path: '../sal7711_web'



# Los siguientes son para desarrollo o para pruebas con generadores
group :development do
  # Depurar
  #gem "byebug"
  
  # Consola irb en páginas con excepciones o usando <%= console %> en vistasA
  gem 'web-console'

end

# Los siguientes son para pruebas y no tiene generadores requeridos en desarrollo
group :test do
  # Acelera desarrollo ejecutando en fondo.  https://github.com/jonleighton/spring

  gem 'simplecov'

  gem 'connection_pool'
  gem "minitest-reporters"
  gem 'minitest-rails-capybara'
  gem 'poltergeist'

  # Pruebas de regresión que no requieren javascript
  gem 'selenium-webdriver'
  gem 'chromedriver-helper'

  # Un proceso para cada prueba -- acelera
  gem 'spork'


  # https://www.relishapp.com/womply/rails-style-guide/docs/developing-rails-applications/bundler
  # Lanza programas para examinar resultados
  #gem "launchy"


  
  gem 'pry-rescue'
  gem 'pry-stack_explorer'
end

group :production do
  # Para despliegue
  gem "unicorn"

  # Requerido por heroku para usar stdout como bitacora
  gem "rails_12factor"
end
