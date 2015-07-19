# encoding: UTF-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

connection = ActiveRecord::Base.connection();

# Básicas de motor sip
l = File.readlines(
  Gem.loaded_specs['sip'].full_gem_path + "/db/datos-basicas.sql"
)
connection.execute(l.join("\n"))

# Básicas de motor SIVeL genérico
l = File.readlines(
  Gem.loaded_specs['sivel2_gen'].full_gem_path + "/db/cambios-basicas.sql"
)
connection.execute(l.join("\n"))

# Básicas de motor SIVeL genérico
l = File.readlines(
  Gem.loaded_specs['sivel2_gen'].full_gem_path + "/db/datos-basicas.sql"
)
connection.execute(l.join("\n"))

# Básicas de motor SIVeL SJR
l = File.readlines(
  Gem.loaded_specs['sivel2_sjr'].full_gem_path + "/db/cambios-basicas.sql"
)
connection.execute(l.join("\n"))

# Básicas de motor SIVeL SJR
l = File.readlines(
  Gem.loaded_specs['sivel2_sjr'].full_gem_path + "/db/datos-basicas.sql"
)
connection.execute(l.join("\n"))

# Básicas de motor cor1440_gen
l = File.readlines(
  Gem.loaded_specs['cor1440_gen'].full_gem_path + "/db/datos-basicas.sql"
)
connection.execute(l.join("\n"))

# Cambios a básicas anteriores
l = File.readlines("db/cambios-basicas.sql")
connection.execute(l.join("\n"))

# Nuevas basicas 
#l = File.readlines("db/datos-basicas.sql")
#connection.execute(l.join("\n"));

# Usuario inicial: sjrcol con clave sjrcol123
connection.execute("INSERT INTO usuario 
	(nusuario, email, encrypted_password, password, 
  fechacreacion, created_at, updated_at, rol) 
	VALUES ('sjrcol', 'sjrcol@localhost.org', 
	'$2a$10$qoo7Sh6ZoxplKPygeF2JDePwnpA1AhhkNUXkqOVy2YXK2jcs/BQU.', 
	'', '2014-01-12', '2013-12-24', '2013-12-24', 1);")


