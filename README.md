# SIVeL 2 para el SJR Colombia
[![Estado Construcción](https://api.travis-ci.org/pasosdeJesus/sivel2_sjrcol.svg?branch=master)](https://travis-ci.org/pasosdeJesus/sivel2_sjrcol) [![Clima del Código](https://codeclimate.com/github/pasosdeJesus/sivel2_sjrcol/badges/gpa.svg)](https://codeclimate.com/github/pasosdeJesus/sivel2_sjrcol) [![Cobertura de Pruebas](https://codeclimate.com/github/pasosdeJesus/sivel2_sjrcol/badges/coverage.svg)](https://codeclimate.com/github/pasosdeJesus/sivel2_sjrcol) [![security](https://hakiri.io/github/pasosdeJesus/sivel2_sjrcol/master.svg)](https://hakiri.io/github/pasosdeJesus/sivel2_sjrcol/master) [![Dependencias](https://gemnasium.com/pasosdeJesus/sivel2_sjrcol.svg)](https://gemnasium.com/pasosdeJesus/sivel2_sjrcol) 

## Tabla de Contenido
* [Uso](#uso)
	* [Requerimientos](#requerimientos)
* [Pruebas](#pruebas)
* [Desarrollo](#pruebas)

SIVeL 2 para el SJR Colombia.

## Uso

Usar junto con sivel2_gen y sivel2_sjr

### Requerimientos
* Ruby version >= 1.9
* PostgreSQL >= 9.3 con extension unaccent
* Recomendado sobre adJ 5.5 (que incluye todos los componentes mencionados). 
* La cuenta desde la cual se ejecute el servidor o las pruebas debe poder abrir 2048 archivos --en adJ se establece en la clase del usuario que ejecuta en /etc/login.conf con :openfiles-cur=2048:

Las siguientes instrucciones suponen que opera en este ambiente.

## Pruebas
Se han implementado algunas pruebas con RSpec a modelos y pruebas de regresión.

* Instale gemas requeridas (como Rails 4.1) con:
``` sh
  cd spec/dummy
  sudo bundle install
  bundle install
```
* Prepare base de prueba con:
``` sh
  cd spec/dummy
  RAILS_ENV=test rake db:setup
  RAILS_ENV=test rake sivel2gen:indices
```
* Ejecute las pruebas desde el directorio del motor con:
```sh
  RACK_MULTIPART_LIMIT=2048 rspec
```

## Servidor de desarrollo

RACK_MULTIPART_LIMIT=2048 rails s

Copie y modifique plantilla de pie de página de su sitio en la página
principal:

cp app/views/sivel2_gen/hogar/_local.html.erb.plantilla app/views/sivel2_gen/hogar/_local.html.erb
$EDITOR app/views/sivel2_gen/hogar/_local.html.erb

## Desarrollo

### Convenciones

Las mismas de sivel2_gen

