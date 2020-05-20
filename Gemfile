source 'https://rubygems.org'


gem 'bcrypt'

gem 'bootsnap', '>=1.1.0', require: false

gem 'bootstrap-datepicker-rails', '>= 1.9.0.1'

gem 'cancancan'

gem 'chartkick'

gem 'cocoon', git: 'https://github.com/vtamara/cocoon.git', branch: 'new_id_with_ajax' # Formularios anidados (algunos con ajax)

gem 'coffee-rails' , '>= 5.0.0' # CoffeeScript para recuersos .js.coffee y vistas

gem 'devise' , '>= 4.7.1' # Autenticación y roles

gem 'devise-i18n', '>= 1.9.1'

gem 'jbuilder' , '>= 2.10.0' # API JSON facil. Ver: https://github.com/rails/jbuilder

gem 'jquery-ui-rails', '>= 6.0.1'

gem 'libxml-ruby'

gem 'odf-report' # Genera ODT

gem 'paperclip' , '>= 6.1.0' # Maneja adjuntos

gem 'pg'#, '~> 0.21' # Postgresql

gem 'pick-a-color-rails' , '>= 0.0.1' # Facilita elegir colores en tema

gem 'puma' , '>= 4.3.3' # Servidor web

gem 'prawn' # Generación de PDF

gem 'prawnto_2', '>= 0.3.0', :require => 'prawnto'

gem 'prawn-table'

gem 'rails', '~> 6.0.3', '>= 6.0.3.1' # Rails (internacionalización)

gem 'rails-i18n', '>= 6.0.0'

gem 'redcarpet'

gem 'rspreadsheet' # Plantilla ODS

gem 'rubyzip', '>=2.0.0'

gem 'sassc-rails', '>= 2.1.2'

gem 'simple_form', '>= 5.0.2'

gem 'tiny-color-rails' , '>= 0.0.2'

gem 'twitter_cldr' # ICU con CLDR

gem 'tzinfo' # Zonas horarias

gem 'webpacker', '>= 5.1.1'

gem 'will_paginate' # Listados en páginas


#####
# Motores que se sobrecargan vistas (deben ponerse en orden de apilamiento 
# lógico y no alfabetico como las gemas anteriores) 

gem 'sip', # Motor generico
  git: 'https://github.com/pasosdeJesus/sip.git'
  #path: '../sip'

gem 'mr519_gen', # Motor de gestion de formularios y encuestas
  git: 'https://github.com/pasosdeJesus/mr519_gen.git'
  #path: '../mr519_gen'

gem 'heb412_gen',  # Motor de nube y llenado de plantillas
  git: 'https://github.com/pasosdeJesus/heb412_gen.git'
  #path: '../heb412_gen'

# Motor Cor1440_gen
gem 'cor1440_gen', 
  git: 'https://github.com/pasosdeJesus/cor1440_gen.git'
  #path: '../cor1440_gen'

# Motor Sal7711_gen
gem 'sal7711_gen', 
  git: 'https://github.com/pasosdeJesus/sal7711_gen.git'
  #path: '../sal7711_gen'

# Motor Sal7711_web
gem 'sal7711_web', 
  git: 'https://github.com/pasosdeJesus/sal7711_web.git'
  #path: '../sal7711_web'

# Motor de SIVeL 2
gem 'sivel2_gen', 
  git: 'https://github.com/pasosdeJesus/sivel2_gen.git'
  #path: '../sivel2_gen'

# Motor de SIVeL 2 - SJR
gem 'sivel2_sjr', 
  git: 'https://github.com/pasosdeJesus/sivel2_sjr.git'
  #path: '../sivel2_sjr'

group :development, :test do
  
  #gem 'byebug' # Depurar

  gem 'colorize' # Colores en terminal
end


group :development do
  
  gem 'web-console' , '>= 4.0.2' # Consola irb en páginas 

end


group :test do

  gem 'capybara'

  gem 'selenium-webdriver' # Pruebas de regresión que no requieren javascript

  gem 'simplecov'

end


group :production do
  
  gem 'unicorn' # Para despliegue

end
