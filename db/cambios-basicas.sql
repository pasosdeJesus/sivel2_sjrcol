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



INSERT INTO public.sip_oficina (id, nombre, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (2, 'VALLE', '2013-05-13', NULL, NULL, NULL);
INSERT INTO public.sip_oficina (id, nombre, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (3, 'MAGDALENA MEDIO', '2013-05-13', NULL, NULL, NULL);
INSERT INTO public.sip_oficina (id, nombre, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (4, 'CÚCUTA', '2013-05-13', NULL, NULL, NULL);
INSERT INTO public.sip_oficina (id, nombre, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (5, 'NARIÑO', '2013-05-13', NULL, NULL, NULL);
INSERT INTO public.sip_oficina (id, nombre, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (6, 'SOACHA', '2013-05-13', '2014-01-01', NULL, NULL);
INSERT INTO public.sip_oficina (id, nombre, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (7, 'NACIONAL', '2013-07-05', NULL, NULL, NULL);

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

