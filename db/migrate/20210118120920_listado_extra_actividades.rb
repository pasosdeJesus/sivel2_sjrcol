class ListadoExtraActividades < ActiveRecord::Migration[6.0]
  def up
    execute <<-SQL
      INSERT INTO public.heb412_gen_plantillahcm 
        (id, ruta, fuente, licencia, vista, nombremenu, filainicial) VALUES 
        (45, 'Plantillas/listado_extracompleto_de_actividades.ods', 
        '', '', 'Actividad', 'Listado extracompleto de Actividades', 5);

      INSERT INTO public.heb412_gen_formulario_plantillahcm 
        (formulario_id, plantillahcm_id) VALUES (10, 45);
      INSERT INTO public.heb412_gen_formulario_plantillahcm 
        (formulario_id, plantillahcm_id) VALUES (11, 45);
      INSERT INTO public.heb412_gen_formulario_plantillahcm 
        (formulario_id, plantillahcm_id) VALUES (13, 45);
      INSERT INTO public.heb412_gen_formulario_plantillahcm 
        (formulario_id, plantillahcm_id) VALUES (14, 45);
      INSERT INTO public.heb412_gen_formulario_plantillahcm 
        (formulario_id, plantillahcm_id) VALUES (15, 45);


      INSERT INTO public.heb412_gen_campoplantillahcm 
        (id, plantillahcm_id, nombrecampo, columna) VALUES 
        (2100, 45, 'id', 'A');
      INSERT INTO public.heb412_gen_campoplantillahcm 
        (id, plantillahcm_id, nombrecampo, columna) VALUES 
        (2101, 45, 'fecha', 'B');
      INSERT INTO public.heb412_gen_campoplantillahcm 
        (id, plantillahcm_id, nombrecampo, columna) VALUES 
        (2102, 45, 'nombre', 'C');
      INSERT INTO public.heb412_gen_campoplantillahcm 
        (id, plantillahcm_id, nombrecampo, columna) VALUES 
        (2103, 45, 'áreas_de_actividad', 'D');
      INSERT INTO public.heb412_gen_campoplantillahcm 
        (id, plantillahcm_id, nombrecampo, columna) VALUES 
        (2104, 45, 'actividad_de_marco_lógico', 'E');
      INSERT INTO public.heb412_gen_campoplantillahcm
        (id, plantillahcm_id, nombrecampo, columna) VALUES
        (2105, 45, 'convenio_financiado', 'F');
      INSERT INTO public.heb412_gen_campoplantillahcm
        (id, plantillahcm_id, nombrecampo, columna) VALUES
        (2106, 45, 'oficina', 'G');
      INSERT INTO public.heb412_gen_campoplantillahcm
        (id, plantillahcm_id, nombrecampo, columna) VALUES
        (2107, 45, 'responsable', 'H');
      INSERT INTO public.heb412_gen_campoplantillahcm
        (id, plantillahcm_id, nombrecampo, columna) VALUES
        (2108, 45, 'objetivo', 'I');
      INSERT INTO public.heb412_gen_campoplantillahcm
        (id, plantillahcm_id, nombrecampo, columna) VALUES
        (2109, 45, 'resultado', 'J');
      INSERT INTO public.heb412_gen_campoplantillahcm
        (id, plantillahcm_id, nombrecampo, columna) VALUES
        (2110, 45, 'poblacion', 'K');
      INSERT INTO public.heb412_gen_campoplantillahcm
        (id, plantillahcm_id, nombrecampo, columna) VALUES
        (2111, 45, 'lugar', 'L');
      INSERT INTO public.heb412_gen_campoplantillahcm
        (id, plantillahcm_id, nombrecampo, columna) VALUES
        (2112, 45, 'subáreas', 'M');
      INSERT INTO public.heb412_gen_campoplantillahcm
        (id, plantillahcm_id, nombrecampo, columna) VALUES
        (2113, 45, 'corresponsables', 'N');
      INSERT INTO public.heb412_gen_campoplantillahcm
        (id, plantillahcm_id, nombrecampo, columna) VALUES
        (2114, 45, 'observaciones', 'O');
      INSERT INTO public.heb412_gen_campoplantillahcm
        (id, plantillahcm_id, nombrecampo, columna) VALUES
        (2115, 45, 'creacion', 'P');
      INSERT INTO public.heb412_gen_campoplantillahcm
        (id, plantillahcm_id, nombrecampo, columna) VALUES
        (2116, 45, 'actualizacion', 'Q');
      INSERT INTO public.heb412_gen_campoplantillahcm
        (id, plantillahcm_id, nombrecampo, columna) VALUES
        (2117, 45, 'poblacion_mujeres_r', 'R');
      INSERT INTO public.heb412_gen_campoplantillahcm
        (id, plantillahcm_id, nombrecampo, columna) VALUES
        (2118, 45, 'poblacion_hombres_r', 'S');
      INSERT INTO public.heb412_gen_campoplantillahcm
        (id, plantillahcm_id, nombrecampo, columna) VALUES
        (2119, 45, 'poblacion_mujeres_l', 'T');
      INSERT INTO public.heb412_gen_campoplantillahcm
        (id, plantillahcm_id, nombrecampo, columna) VALUES
        (2120, 45, 'poblacion_hombres_l', 'U');
      INSERT INTO public.heb412_gen_campoplantillahcm
        (id, plantillahcm_id, nombrecampo, columna) VALUES
        (2121, 45, 'poblacion_mujeres_r_g1', 'V');
      INSERT INTO public.heb412_gen_campoplantillahcm
        (id, plantillahcm_id, nombrecampo, columna) VALUES
        (2122, 45, 'poblacion_mujeres_r_g2', 'W');
      INSERT INTO public.heb412_gen_campoplantillahcm
        (id, plantillahcm_id, nombrecampo, columna) VALUES
        (2123, 45, 'poblacion_mujeres_r_g3', 'X');
      INSERT INTO public.heb412_gen_campoplantillahcm
        (id, plantillahcm_id, nombrecampo, columna) VALUES
        (2124, 45, 'poblacion_mujeres_r_g4', 'Y');
      INSERT INTO public.heb412_gen_campoplantillahcm
        (id, plantillahcm_id, nombrecampo, columna) VALUES
        (2125, 45, 'poblacion_mujeres_r_g5', 'Z');
      INSERT INTO public.heb412_gen_campoplantillahcm
        (id, plantillahcm_id, nombrecampo, columna) VALUES
        (2126, 45, 'poblacion_mujeres_r_g6', 'AA');
      INSERT INTO public.heb412_gen_campoplantillahcm
        (id, plantillahcm_id, nombrecampo, columna) VALUES
        (2127, 45, 'poblacion_hombres_r_g1', 'AB');
      INSERT INTO public.heb412_gen_campoplantillahcm
        (id, plantillahcm_id, nombrecampo, columna) VALUES
        (2128, 45, 'poblacion_hombres_r_g2', 'AC');
      INSERT INTO public.heb412_gen_campoplantillahcm
        (id, plantillahcm_id, nombrecampo, columna) VALUES
        (2129, 45, 'poblacion_hombres_r_g3', 'AD');
      INSERT INTO public.heb412_gen_campoplantillahcm
        (id, plantillahcm_id, nombrecampo, columna) VALUES
        (2130, 45, 'poblacion_hombres_r_g4', 'AE');
      INSERT INTO public.heb412_gen_campoplantillahcm
        (id, plantillahcm_id, nombrecampo, columna) VALUES
        (2131, 45, 'poblacion_hombres_r_g5', 'AF');
      INSERT INTO public.heb412_gen_campoplantillahcm
        (id, plantillahcm_id, nombrecampo, columna) VALUES
        (2132, 45, 'poblacion_hombres_r_g6', 'AG');
      INSERT INTO public.heb412_gen_campoplantillahcm
        (id, plantillahcm_id, nombrecampo, columna) VALUES
        (2133, 45, 'anexo_1_desc', 'AH');
      INSERT INTO public.heb412_gen_campoplantillahcm
        (id, plantillahcm_id, nombrecampo, columna) VALUES
        (2134, 45, 'anexo_2_desc', 'AI');
      INSERT INTO public.heb412_gen_campoplantillahcm
        (id, plantillahcm_id, nombrecampo, columna) VALUES
        (2135, 45, 'anexo_3_desc', 'AJ');
      INSERT INTO public.heb412_gen_campoplantillahcm
        (id, plantillahcm_id, nombrecampo, columna) VALUES
        (2136, 45, 'anexo_4_desc', 'AK');
      INSERT INTO public.heb412_gen_campoplantillahcm
        (id, plantillahcm_id, nombrecampo, columna) VALUES
        (2137, 45, 'anexo_5_desc', 'AL');
      INSERT INTO public.heb412_gen_campoplantillahcm
        (id, plantillahcm_id, nombrecampo, columna) VALUES
        (2138, 45, 'covid19', 'AM');
      INSERT INTO public.heb412_gen_campoplantillahcm
        (id, plantillahcm_id, nombrecampo, columna) VALUES
        (2139, 45, 'departamento', 'AN');
      INSERT INTO public.heb412_gen_campoplantillahcm
        (id, plantillahcm_id, nombrecampo, columna) VALUES
        (2144, 45, 'municipio', 'AO');
      INSERT INTO public.heb412_gen_campoplantillahcm
        (id, plantillahcm_id, nombrecampo, columna) VALUES
        (2142, 45, 'lugar', 'AP');
       INSERT INTO public.heb412_gen_campoplantillahcm
        (id, plantillahcm_id, nombrecampo, columna) VALUES
        (2147, 45, 'poblacion_ids', 'AQ');

      INSERT INTO public.heb412_gen_campoplantillahcm 
        (id, plantillahcm_id, nombrecampo, columna) VALUES 
        (2150, 45, 'derechos_vulnerados_respuesta_estado.derechos_vulnerados', 'AR');
      INSERT INTO public.heb412_gen_campoplantillahcm 
        (id, plantillahcm_id, nombrecampo, columna) VALUES 
        (2151, 45, 'derechos_vulnerados_respuesta_estado.se_brindo_informacion', 'AS');
      INSERT INTO public.heb412_gen_campoplantillahcm 
        (id, plantillahcm_id, nombrecampo, columna) VALUES 
        (2152, 45, 'derechos_vulnerados_respuesta_estado.acciones_persona', 'AT');
      INSERT INTO public.heb412_gen_campoplantillahcm 
        (id, plantillahcm_id, nombrecampo, columna) VALUES 
        (2153, 45, 'derechos_vulnerados_respuesta_estado.ayuda_del_estado', 'AU');
      INSERT INTO public.heb412_gen_campoplantillahcm 
        (id, plantillahcm_id, nombrecampo, columna) VALUES 
        (2154, 45, 'derechos_vulnerados_respuesta_estado.cantidad_ayuda_estado', 'AV');
      INSERT INTO public.heb412_gen_campoplantillahcm 
        (id, plantillahcm_id, nombrecampo, columna) VALUES 
        (2155, 45, 'derechos_vulnerados_respuesta_estado.instituciones_que_ayudaron', 'AW');
      INSERT INTO public.heb412_gen_campoplantillahcm 
        (id, plantillahcm_id, nombrecampo, columna) VALUES 
        (2156, 45, 'derechos_vulnerados_respuesta_estado.programas_respuesta_estado', 'AX');
      INSERT INTO public.heb412_gen_campoplantillahcm 
        (id, plantillahcm_id, nombrecampo, columna) VALUES 
        (2157, 45, 'derechos_vulnerados_respuesta_estado.dificultades_y_observaciones', 'AY');
      INSERT INTO public.heb412_gen_campoplantillahcm 
        (id, plantillahcm_id, nombrecampo, columna) VALUES 
        (2158, 45, 'asistencia_humanitaria.asistencia_humanitaria', 'AZ');
      INSERT INTO public.heb412_gen_campoplantillahcm 
        (id, plantillahcm_id, nombrecampo, columna) VALUES 
        (2159, 45, 'asistencia_humanitaria.detalle_asistencia_humanitaria', 'BA');
      INSERT INTO public.heb412_gen_campoplantillahcm 
        (id, plantillahcm_id, nombrecampo, columna) VALUES 
        (2160, 45, 'asesoria_juridica.asesoria_juridica', 'BB');
      INSERT INTO public.heb412_gen_campoplantillahcm 
        (id, plantillahcm_id, nombrecampo, columna) VALUES 
        (2161, 45, 'asesoria_juridica.detalle_asesoria_juridica', 'BC');
      INSERT INTO public.heb412_gen_campoplantillahcm 
        (id, plantillahcm_id, nombrecampo, columna) VALUES 
        (2162, 45, 'accion_juridica.accion_juridica_1', 'BD');
      INSERT INTO public.heb412_gen_campoplantillahcm 
        (id, plantillahcm_id, nombrecampo, columna) VALUES 
        (2163, 45, 'accion_juridica.respuesta_1', 'BE');
      INSERT INTO public.heb412_gen_campoplantillahcm 
        (id, plantillahcm_id, nombrecampo, columna) VALUES 
        (2164, 45, 'accion_juridica.accion_juridica_2', 'BF');
      INSERT INTO public.heb412_gen_campoplantillahcm 
        (id, plantillahcm_id, nombrecampo, columna) VALUES 
        (2165, 45, 'accion_juridica.respuesta_2', 'BG');
      INSERT INTO public.heb412_gen_campoplantillahcm 
        (id, plantillahcm_id, nombrecampo, columna) VALUES 
        (2166, 45, 'otros_servicios_asesorias_caso.otros_servicios_asesorias', 'BH');
      INSERT INTO public.heb412_gen_campoplantillahcm 
        (id, plantillahcm_id, nombrecampo, columna) VALUES 
        (2167, 45, 'otros_servicios_asesorias_caso.detalle_otros_servicios_asesorias', 'BI');

      INSERT INTO public.heb412_gen_campoplantillahcm 
        (id, plantillahcm_id, nombrecampo, columna) VALUES 
        (2170, 45, 'organizaciones_sociales', 'BJ'); --organizaciones_sociales_ids
      INSERT INTO public.heb412_gen_campoplantillahcm 
        (id, plantillahcm_id, nombrecampo, columna) VALUES 
        (2171, 45, 'organizaciones_sociales_ids', 'BK'); --organizaciones_sociales_ids

      INSERT INTO public.heb412_gen_campoplantillahcm 
        (id, plantillahcm_id, nombrecampo, columna) VALUES 
        (2172, 45, 'listado_casos_ids', 'BL');
      INSERT INTO public.heb412_gen_campoplantillahcm 
        (id, plantillahcm_id, nombrecampo, columna) VALUES 
        (2173, 45, 'numero_anexos', 'BM');
      INSERT INTO public.heb412_gen_campoplantillahcm 
        (id, plantillahcm_id, nombrecampo, columna) VALUES 
        (2174, 45, 'anexos_ids', 'BN');
      INSERT INTO public.heb412_gen_campoplantillahcm 
        (id, plantillahcm_id, nombrecampo, columna) VALUES 
        (2175, 45, 'numero_detalles_financieros', 'BO');
      INSERT INTO public.heb412_gen_campoplantillahcm 
        (id, plantillahcm_id, nombrecampo, columna) VALUES 
        (2176, 45, 'detalles_financieros_ids', 'BP');


      -- Contador de ids para heb412_gen_campoplantillahcm pasa a 5000 
      -- de manera que nuevos campos de plantillas por migraciones 
      -- tengan entre 2000 y 5000
      SELECT pg_catalog.setval('public.heb412_gen_campoplantillahcm_id_seq', 
        MAX(id), true) FROM (SELECT 5000 AS id UNION
          SELECT max(id) from heb412_gen_campoplantillahcm) AS s;
    SQL
  end

  def down
  end
end
