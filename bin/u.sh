#!/bin/sh
# Inicia produccion
if (test "${SECRET_KEY_BASE}" = "") then {
	echo "Definir variable de ambiente SECRET_KEY_BASE"
	exit 1;
} fi;
DOAS=`which doas 2> /dev/null`
if (test "$?" != "0") then {
	        DOAS="sudo"
} fi;
if (test "$CONFIG_HOSTS" = "") then {
	CONFIG_HOSTS=127.0.0.1
} fi;
$DOAS su vtamara -c "cd /var/www/htdocs/sivel2_sjrcol; bin/rails assets:precompile; echo \"Iniciando unicorn...\"; CONFIG_HOSTS=${CONFIG_HOSTS} RACK_MULTIPART_LIMIT=2048 SECRET_KEY_BASE=${SECRET_KEY_BASE} bundle exec unicorn_rails -c ../sivel2_sjrcol/config/unicorn.conf.minimal.rb  -E production -D"


  

