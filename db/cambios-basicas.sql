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


UPDATE public.sip_tema SET
fondo = '#f2f2ff',
color_fuen = '#000000',
nav_ini = '#5377a6',
nav_fin = '#1f4e8c',
nav_fuen = '#f2f2ff',
fondo_lis = '#5377a6',
b_primario_fondo_ini = '#04c4d9',
b_primario_fondo_fin = '#1f4e8c',
b_primario_fuen = '#f2f2ff',
b_peligro_fondo_ini = '#ff1b30',
b_peligro_fondo_fin = '#ad0a0a',
b_peligro_fuen = '#f2f2ff',
b_accion_fondo_ini = '#f2f2ff',
b_accion_fondo_fin= '#d6d6f0',
b_accion_fuen = '#000000',
aler_exi_fondo = '#01a7d1',
aler_exi_fuen = '#1f4e8c',
aler_problema_fondo = '#f8d7da',
aler_problema_fuen = '#721c24'
WHERE id=1;
