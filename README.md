# SIVeL 2 para el SJR Colombia [![Esado Construcción](https://api.travis-ci.org/pasosdeJesus/sivel2_sjrcol.svg?branch=master)](https://travis-ci.org/pasosdeJesus/sivel2_sjrcol) [![Clima del Código](https://codeclimate.com/github/pasosdeJesus/sivel2_sjrcol/badges/gpa.svg)](https://codeclimate.com/github/pasosdeJesus/sivel2_sjrcol) [![Cobertura de Pruebas](https://codeclimate.com/github/pasosdeJesus/sivel2_sjrcol/badges/coverage.svg)](https://codeclimate.com/github/pasosdeJesus/sivel2_sjrcol)

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
* PostgreSQL >= 9.3
* Recomendado sobre adJ 5.5 (que incluye todos los componentes mencionados).  
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
  rake
```

## Desarrollo

### Convenciones

Las mismas de sivel2_gen

