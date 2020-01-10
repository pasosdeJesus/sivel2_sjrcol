-- Novedades a tablas basicas de sivel2_gen

      
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET search_path = public, pg_catalog;

UPDATE public.sivel2_gen_rangoedad SET fechadeshabilitacion='2014-11-28' WHERE nombre LIKE 'R%';
INSERT INTO public.sivel2_gen_rangoedad (id, nombre, rango, limiteinferior, limitesuperior, fechacreacion, fechadeshabilitacion, created_at, updated_at, observaciones)
 VALUES (7, 'S1', 'DE 0 A 5 AÑOS', 0, 5, '2014-10-29', NULL, NULL, NULL, NULL); 
INSERT INTO public.sivel2_gen_rangoedad (id, nombre, rango, limiteinferior, limitesuperior, fechacreacion, fechadeshabilitacion, created_at, updated_at, observaciones)
 VALUES (8, 'S2', 'DE 6 A 12 AÑOS', 6, 12, '2014-10-29', NULL, NULL, NULL, NULL); 
INSERT INTO public.sivel2_gen_rangoedad (id, nombre, rango, limiteinferior, limitesuperior, fechacreacion, fechadeshabilitacion, created_at, updated_at, observaciones)
 VALUES (9, 'S3', 'DE 13 A 17 AÑOS', 13, 17, '2014-10-29', NULL, NULL, NULL, NULL); 
INSERT INTO public.sivel2_gen_rangoedad (id, nombre, rango, limiteinferior, limitesuperior, fechacreacion, fechadeshabilitacion, created_at, updated_at, observaciones)
 VALUES (11, 'S5', 'DE 27 A 59 AÑOS', 27, 59, '2014-10-29', NULL, NULL, NULL, NULL); 
INSERT INTO public.sivel2_gen_rangoedad (id, nombre, rango, limiteinferior, limitesuperior, fechacreacion, fechadeshabilitacion, created_at, updated_at, observaciones)
 VALUES (12, 'S6', 'DE 60 EN ADELANTE', 60, 180, '2014-10-29', NULL, NULL, NULL, NULL); 
INSERT INTO public.sivel2_gen_rangoedad (id, nombre, rango, limiteinferior, limitesuperior, fechacreacion, fechadeshabilitacion, created_at, updated_at, observaciones)
 VALUES (10, 'S4', 'DE 18 A 26 AÑOS', 18, 26, '2014-10-29', NULL, NULL, NULL, NULL);


UPDATE public.cor1440_gen_rangoedadac set nombre='DE 0 A 5', limiteinferior=0, limitesuperior=5 WHERE id=1;
UPDATE public.cor1440_gen_rangoedadac set nombre='DE 6 A 12', limiteinferior=6, limitesuperior=12 WHERE id=2;
UPDATE public.cor1440_gen_rangoedadac set nombre='DE 13 A 17', limiteinferior=13, limitesuperior=17 WHERE id=3;
UPDATE public.cor1440_gen_rangoedadac set nombre='DE 18 A 26', limiteinferior=18, limitesuperior=26 WHERE id=4;
UPDATE public.cor1440_gen_rangoedadac set nombre='DE 27 A 59', limiteinferior=27, limitesuperior=59 WHERE id=5;
UPDATE public.cor1440_gen_rangoedadac set nombre='DE 60 EN ADELANTE', limiteinferior=60, limitesuperior=NULL WHERE id=6;
INSERT INTO public.cor1440_gen_rangoedadac (id, nombre, limiteinferior, limitesuperior, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (7, 'SIN INFORMACIÓN', -1, -1, '2019-09-28', NULL, '2019-09-28', '2019-09-28');



INSERT INTO public.sip_oficina (id, nombre, fechacreacion, fechadeshabilitacion, created_at, updated_at, observaciones, pais_id, departamento_id, municipio_id, clase_id) VALUES (4, 'CÚCUTA', '2013-05-13', NULL, NULL, '2019-11-27 21:37:59.742224', '', 170, 39, 32, 9041);
INSERT INTO public.sip_oficina (id, nombre, fechacreacion, fechadeshabilitacion, created_at, updated_at, observaciones, pais_id, departamento_id, municipio_id, clase_id) VALUES (3, 'MAGDALENA MEDIO', '2013-05-13', NULL, NULL, '2019-11-27 21:40:24.544825', '', 170, 43, 1319, 9899);
INSERT INTO public.sip_oficina (id, nombre, fechacreacion, fechadeshabilitacion, created_at, updated_at, observaciones, pais_id, departamento_id, municipio_id, clase_id) VALUES (7, 'NACIONAL', '2013-07-05', NULL, NULL, '2019-11-27 21:41:06.947402', '', 170, 4, 24, 238);
INSERT INTO public.sip_oficina (id, nombre, fechacreacion, fechadeshabilitacion, created_at, updated_at, observaciones, pais_id, departamento_id, municipio_id, clase_id) VALUES (5, 'NARIÑO', '2013-05-13', NULL, NULL, '2019-11-27 22:59:01.58987', '', 170, 38, 44, 7907);
INSERT INTO public.sip_oficina (id, nombre, fechacreacion, fechadeshabilitacion, created_at, updated_at, observaciones, pais_id, departamento_id, municipio_id, clase_id) VALUES (6, 'SOACHA', '2013-05-13', NULL, NULL, '2019-11-27 22:59:39.810354', '', 170, 27, 1216, 4758);
INSERT INTO public.sip_oficina (id, nombre, fechacreacion, fechadeshabilitacion, created_at, updated_at, observaciones, pais_id, departamento_id, municipio_id, clase_id) VALUES (2, 'VALLE', '2013-05-13', NULL, NULL, '2019-11-27 23:00:00.649667', '', 170, 47, 86, 11771);
INSERT INTO sivel2_sjr_proteccion (id, nombre, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (9, 'APATRIDA', '2020-01-04', NULL, NULL, NULL);
INSERT INTO sivel2_sjr_proteccion (id, nombre, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (10, 'EN RIESGO DE APATRIDA', '2020-01-04', NULL, NULL, NULL);

--
-- PostgreSQL database dump
--

SET statement_timeout = 0;

SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = public, pg_catalog;

--
-- Data for Name: regimensalud; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.sivel2_sjr_regimensalud (id, nombre, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (0, 'SIN INFORMACIÓN', '2013-05-16', NULL, NULL, NULL);
INSERT INTO public.sivel2_sjr_regimensalud (id, nombre, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (1, 'SUBSIDIADO', '2013-05-16', NULL, NULL, NULL);
INSERT INTO public.sivel2_sjr_regimensalud (id, nombre, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (2, 'CONTRIBUTIVO', '2013-05-16', NULL, NULL, NULL);
INSERT INTO public.sivel2_sjr_regimensalud (id, nombre, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (3, 'NO AFILIADO/A', '2013-05-16', NULL, NULL, NULL);


--
-- PostgreSQL database dump complete
--

UPDATE sip_tema SET
  fondo = '#f2f2ff',
  color_fuente = '#000000',
  nav_ini = '#5377a6',
  nav_fin = '#1f4e8c',
  nav_fuente = '#f2f2ff',
  fondo_lista = '#5377a6',
  btn_primario_fondo_ini = '#04c4d9',
  btn_primario_fondo_fin = '#1f4e8c',
  btn_primario_fuente = '#f2f2ff',
  btn_peligro_fondo_ini = '#ff1b30',
  btn_peligro_fondo_fin = '#ad0a0a',
  btn_peligro_fuente = '#f2f2ff',
  btn_accion_fondo_ini = '#f2f2ff',
  btn_accion_fondo_fin= '#d6d6f0',
  btn_accion_fuente = '#000000',
  alerta_exito_fondo = '#01a7d1',
  alerta_exito_fuente = '#1f4e8c',
  alerta_problema_fondo = '#f8d7da',
  alerta_problema_fuente = '#721c24'
WHERE id=1;
