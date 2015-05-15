-- Novedades a tablas basicas de sivel2_gen

      
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET search_path = public, pg_catalog;

UPDATE sivel2_gen_rangoedad SET fechadeshabilitacion='2014-11-28' WHERE nombre LIKE 'R%';

DELETE FROM sivel2_gen_regionsjr WHERE id='2';
INSERT INTO sivel2_gen_regionsjr (id, nombre, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (2, 'VALLE', '2013-05-13', NULL, NULL, NULL);
INSERT INTO sivel2_gen_regionsjr (id, nombre, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (3, 'MAGDALENA MEDIO', '2013-05-13', NULL, NULL, NULL);
INSERT INTO sivel2_gen_regionsjr (id, nombre, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (4, 'CÚCUTA', '2013-05-13', NULL, NULL, NULL);
INSERT INTO sivel2_gen_regionsjr (id, nombre, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (5, 'NARIÑO', '2013-05-13', NULL, NULL, NULL);
INSERT INTO sivel2_gen_regionsjr (id, nombre, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (6, 'SOACHA', '2013-05-13', '2014-01-01', NULL, NULL);
INSERT INTO sivel2_gen_regionsjr (id, nombre, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (7, 'NACIONAL', '2013-07-05', NULL, NULL, NULL);


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

INSERT INTO sivel2_sjr_regimensalud (id, nombre, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (0, 'SIN INFORMACIÓN', '2013-05-16', NULL, NULL, NULL);
INSERT INTO sivel2_sjr_regimensalud (id, nombre, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (1, 'SUBSIDIADO', '2013-05-16', NULL, NULL, NULL);
INSERT INTO sivel2_sjr_regimensalud (id, nombre, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (2, 'CONTRIBUTIVO', '2013-05-16', NULL, NULL, NULL);
INSERT INTO sivel2_sjr_regimensalud (id, nombre, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (3, 'NO AFILIADO/A', '2013-05-16', NULL, NULL, NULL);


--
-- PostgreSQL database dump complete
--

