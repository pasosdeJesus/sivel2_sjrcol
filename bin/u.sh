#!/bin/sh
# Inicia produccion
if (test "${SECRET_KEY_BASE}" = "") then {
	echo "Definir variable de ambiente SECRET_KEY_BASE"
	exit 1;
} fi;
sudo su vtamara -c "cd /var/www/htdocs/sivel2_sjrcol; rake assets:precompile; echo \"Iniciando unicorn...\"; SECRET_KEY_BASE=${SECRET_KEY_BASE} bundle exec unicorn_rails -c ../sivel2_sjrcol/config/unicorn.conf.minimal.rb  -E production -D"


  

