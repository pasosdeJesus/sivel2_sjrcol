class CreaPlantillacasos < ActiveRecord::Migration[6.0]
  def up
    execute <<-SQL
      INSERT INTO public.heb412_gen_plantillahcm (id, ruta, fuente, licencia, vista, nombremenu, filainicial) VALUES (44, 'Plantillas/listado_de_casos.ods', 'PdJ', 'Dominio Publico', 'Caso', 'Listado de Casos', 5);

      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (200, 44, 'caso_id', 'A');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (201, 44, 'contacto_nombres', 'B');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (202, 44, 'contacto_apellidos', 'C');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (203, 44, 'contacto_anionac', 'D');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (204, 44, 'contacto_mesnac', 'E');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (205, 44, 'contacto_dianac', 'F');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (206, 44, 'contacto_tdocumento', 'G');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (207, 44, 'contacto_numerodocumento', 'H');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (208, 44, 'contacto_sexo', 'I');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (209, 44, 'contacto_pais', 'J');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (210, 44, 'contacto_departamento', 'K');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (211, 44, 'contacto_municipio', 'L');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (212, 44, 'contacto_vinculoestado', 'AF');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (213, 44, 'familiar1_profesion', 'BI');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (214, 44, 'contacto_orientacionsexual', 'Q');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (215, 44, 'contacto_maternidad', 'R');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (216, 44, 'contacto_estadocivil', 'S');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (217, 44, 'contacto_comosupo', 'AG');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (218, 44, 'familiar1_actividadoficio', 'BJ');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (219, 44, 'ubicacion2_pais', 'GN');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (220, 44, 'direccion', 'M');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (221, 44, 'telefono', 'N');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (222, 44, 'contacto_numeroanexos', 'O');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (223, 44, 'contacto_etnia', 'P');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (224, 44, 'contacto_discapacidad', 'T');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (225, 44, 'contacto_cabezafamilia', 'U');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (226, 44, 'contacto_rolfamilia', 'V');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (227, 44, 'contacto_tienesisben', 'W');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (228, 44, 'contacto_regimensalud', 'X');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (229, 44, 'contacto_asisteescuela', 'Y');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (230, 44, 'contacto_escolaridad', 'Z');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (231, 44, 'contacto_actualtrabajando', 'AA');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (232, 44, 'contacto_profesion', 'AB');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (233, 44, 'contacto_actividadoficio', 'AC');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (234, 44, 'contacto_filiacion', 'AD');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (235, 44, 'contacto_organizacion', 'AE');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (236, 44, 'contacto_consentimientosjr', 'AH');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (237, 44, 'contacto_consentimientobd', 'AI');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (238, 44, 'contacto_numeroanexosconsen', 'AJ');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (239, 44, 'familiar1_nombres', 'AK');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (240, 44, 'familiar1_apellidos', 'AL');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (241, 44, 'familiar1_anionac', 'AM');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (242, 44, 'familiar1_mesnac', 'AN');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (243, 44, 'familiar1_dianac', 'AO');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (244, 44, 'familiar1_tdocumento', 'AP');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (245, 44, 'familiar1_numerodocumento', 'AQ');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (246, 44, 'familiar1_sexo', 'AR');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (247, 44, 'familiar1_pais', 'AS');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (248, 44, 'familiar1_departamento', 'AT');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (249, 44, 'familiar1_municipio', 'AU');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (250, 44, 'familiar1_numeroanexos', 'AV');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (251, 44, 'familiar1_etnia', 'AW');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (252, 44, 'familiar1_orientacionsexual', 'AX');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (253, 44, 'familiar1_maternidad', 'AY');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (254, 44, 'familiar1_estadocivil', 'AZ');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (255, 44, 'familiar1_discapacidad', 'BA');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (256, 44, 'familiar1_cabezafamilia', 'BB');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (257, 44, 'familiar1_rolfamilia', 'BC');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (258, 44, 'familiar1_tienesisben', 'BD');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (259, 44, 'familiar1_regimensalud', 'BE');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (260, 44, 'familiar1_asisteescuela', 'BF');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (261, 44, 'familiar1_escolaridad', 'BG');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (262, 44, 'familiar1_actualtrabajando', 'BH');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (263, 44, 'familiar1_filiacion', 'BK');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (264, 44, 'familiar1_organizacion', 'BL');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (265, 44, 'familiar1_vinculoestado', 'BM');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (266, 44, 'familiar1_numeroanexosconsen', 'BN');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (267, 44, 'ubicacion1_pais', 'GE');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (268, 44, 'ubicacion1_departamento', 'GF');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (269, 44, 'ubicacion1_municipio', 'GG');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (270, 44, 'ubicacion1_clase', 'GH');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (271, 44, 'ubicacion1_longitud', 'GI');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (272, 44, 'ubicacion1_latitud', 'GJ');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (273, 44, 'ubicacion1_lugar', 'GK');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (274, 44, 'ubicacion1_sitio', 'GL');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (275, 44, 'ubicacion1_tsitio', 'GM');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (276, 44, 'ubicacion2_departamento', 'GO');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (277, 44, 'ubicacion2_municipio', 'GP');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (278, 44, 'ubicacion2_clase', 'GQ');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (279, 44, 'ubicacion2_longitud', 'GR');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (280, 44, 'ubicacion2_latitud', 'GS');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (281, 44, 'ubicacion2_lugar', 'GT');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (282, 44, 'ubicacion2_sitio', 'GU');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (283, 44, 'ubicacion2_tsitio', 'GV');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (284, 44, 'fechasalida', 'HF');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (285, 44, 'salida_pais', 'HG');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (286, 44, 'salida_municipio', 'HI');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (287, 44, 'salida_clase', 'HJ');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (288, 44, 'viadeingreso', 'HK');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (289, 44, 'causamigracion', 'HL');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (290, 44, 'pagoingreso', 'HM');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (291, 44, 'valor_pago', 'HN');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (292, 44, 'salida_departamento', 'HH');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (293, 44, 'concepto_pago', 'HO');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (294, 44, 'actor_pago', 'HP');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (295, 44, 'ubifamilia', 'HQ');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (296, 44, 'dificultadmigracion', 'HR');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (297, 44, 'agresionmigracion', 'HS');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (298, 44, 'perpetradoresagresion', 'HT');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (299, 44, 'causaagresion', 'HU');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (300, 44, 'fechallegada', 'HV');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (301, 44, 'llegada_pais', 'HW');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (302, 44, 'llegada_departamento', 'HX');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (303, 44, 'llegada_municipio', 'HY');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (304, 44, 'llegada_clase', 'HZ');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (305, 44, 'tiempoenpais', 'IA');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (306, 44, 'perfilmigracion', 'IB');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (307, 44, 'migracontactopre', 'IC');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (308, 44, 'statusmigratorio', 'ID');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (309, 44, 'agresionenpais', 'IE');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (310, 44, 'proteccion', 'IH');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (311, 44, 'autoridadrefugio', 'IJ');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (312, 44, 'salvoNpi', 'IK');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (313, 44, 'causaRefugio', 'IL');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (314, 44, 'tipoproteccion', 'IM');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (315, 44, 'miembrofamiliar', 'IN');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (316, 44, 'observacionesref', 'IO');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (317, 44, 'perpeagresenpais', 'IF');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (318, 44, 'fechaNpi', 'II');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (319, 44, 'causaagrpais', 'IG');

      SELECT setval('public.heb412_gen_plantillahcm_id_seq', 200);
    SQL
  end

  def down
    execute <<-SQL
      DELETE FROM public.heb412_gen_campoplantillahcm WHERE id>='200' AND id<='400';
      DELETE FROM public.heb412_gen_plantillahcm WHERE id='44';
    SQL
  end
end
