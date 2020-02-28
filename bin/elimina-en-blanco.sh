#!/bin/sh
# Elimina actividades en blanco
# vtamara@pasosdeJesus.org. 2020. Dominio público.

# Por agregar en crontab con algo como:
# 0 20 * *  * (cd /var/www/htdosc/sivel2_sjrcol/; bin/elimina-en-blanco.sh >> /tmp/elimina-en-blanco.bitacora 2>&1)

if (test ! -f .env) then {
	echo 'Falata archivo .env'
	exit 1;
} fi;
. .env
if (test "$USUARIO_AP" = "") then {
	echo 'Falta USUARIO_AP en .env'
	exit 1;
} fi;
if (test ! -f config/database.yml) then {
	echo "Falta archivo config/database.yml"
	exit 1;
} fi;

bd=`grep -A2 production config/database.yml | grep database | sed -e "s/  database: //g"`
cl=`grep "password:" config/database.yml | sed -e "s/  password: //g"`
us=`grep "username:" config/database.yml | sed -e "s/  username: //g"`
ps axww | grep "[R]EFRESH" > /dev/null 2>&1
while (test "$?" = "0"); do
	echo "Refresco en curso, esperando 5 segundos"
	sleep 5;
	ps axww | grep "[R]EFRESH" > /dev/null 2>&1
done
doas su ${USUARIO_AP} -c "psql -U $us -h /var/www/var/run/postgresql $bd -c 'DELETE FROM cor1440_gen_actividad_proyectofinanciero WHERE
  actividad_id IN (
	SELECT id FROM cor1440_gen_actividad WHERE 
	nombre IS null 
	AND observaciones IS null 
	AND id NOT IN (SELECT actividad_id FROM cor1440_gen_actividad_actividadpf)  
	AND id NOT IN (SELECT actividad_id FROM cor1440_gen_actividad_respuestafor) 
	AND id NOT IN (SELECT actividad_id FROM cor1440_gen_actividad_proyecto) 
	AND id NOT IN (SELECT actividad_id FROM sivel2_sjr_actividad_casosjr) 
	AND id NOT IN (SELECT actividad_id FROM cor1440_gen_actividad_sip_anexo) 
	AND (id NOT IN (SELECT actividad_id FROM cor1440_gen_actividad_proyectofinanciero) 
          OR id IN (SELECT DISTINCT actividad_id FROM cor1440_gen_actividad_proyectofinanciero WHERE proyectofinanciero_id=10 AND 
	  actividad_id NOT IN (select actividad_id from cor1440_gen_actividad_proyectofinanciero where proyectofinanciero_id<>10)))
  ); '"

doas su ${USUARIO_AP} -c "psql -U $us -h /var/www/var/run/postgresql $bd -c 'DELETE FROM cor1440_gen_actividad WHERE 
	nombre IS null 
	AND observaciones IS null 
	AND id NOT IN (SELECT actividad_id FROM cor1440_gen_actividad_actividadpf)  
	AND id NOT IN (SELECT actividad_id FROM cor1440_gen_actividad_respuestafor) 
	AND id NOT IN (SELECT actividad_id FROM cor1440_gen_actividad_proyecto) 
	AND id NOT IN (SELECT actividad_id FROM sivel2_sjr_actividad_casosjr) 
	AND id NOT IN (SELECT actividad_id FROM cor1440_gen_actividad_sip_anexo) 
	AND (id NOT IN (SELECT actividad_id FROM cor1440_gen_actividad_proyectofinanciero) 
          OR id IN (SELECT DISTINCT actividad_id FROM cor1440_gen_actividad_proyectofinanciero WHERE proyectofinanciero_id=10 AND 
	  actividad_id NOT IN (select actividad_id from cor1440_gen_actividad_proyectofinanciero where proyectofinanciero_id<>10))) ; '"

