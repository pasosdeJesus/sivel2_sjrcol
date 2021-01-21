class CasosConHistorialDeAtenciones < ActiveRecord::Migration[6.0]
  def up
    execute <<-SQL

      INSERT INTO public.heb412_gen_plantillahcm (id, ruta, fuente, licencia, vista, nombremenu, filainicial) VALUES (48, 'Plantillas/Casos_con_historial_de_atenciones.ods', '', '', 'Caso', 'Casos con historial de atenciones', 10);

      INSERT INTO public.heb412_gen_campoplantillahcm 
        (id, plantillahcm_id, nombrecampo, columna) VALUES 
        (3000, 48, 'caso_id', 'A');
      INSERT INTO public.heb412_gen_campoplantillahcm 
        (id, plantillahcm_id, nombrecampo, columna) VALUES 
        (3001, 48, 'fecharecepcion', 'B');
      INSERT INTO public.heb412_gen_campoplantillahcm 
        (id, plantillahcm_id, nombrecampo, columna) VALUES 
        (3002, 48, 'actividades_departamentos', 'C');
      INSERT INTO public.heb412_gen_campoplantillahcm 
        (id, plantillahcm_id, nombrecampo, columna) VALUES 
        (3003, 48, 'actividades_municipios', 'D');
      INSERT INTO public.heb412_gen_campoplantillahcm 
        (id, plantillahcm_id, nombrecampo, columna) VALUES 
        (3004, 48, 'contacto_nombres', 'E');
      INSERT INTO public.heb412_gen_campoplantillahcm 
        (id, plantillahcm_id, nombrecampo, columna) VALUES 
        (3005, 48, 'contacto_apellidos', 'F');
      INSERT INTO public.heb412_gen_campoplantillahcm 
        (id, plantillahcm_id, nombrecampo, columna) VALUES 
        (3006, 48, 'contacto_tdocumento', 'G');
      INSERT INTO public.heb412_gen_campoplantillahcm 
        (id, plantillahcm_id, nombrecampo, columna) VALUES 
        (3007, 48, 'contacto_numerodocumento', 'H');
      INSERT INTO public.heb412_gen_campoplantillahcm 
        (id, plantillahcm_id, nombrecampo, columna) VALUES 
        (3008, 48, 'telefono', 'I');
      INSERT INTO public.heb412_gen_campoplantillahcm 
        (id, plantillahcm_id, nombrecampo, columna) VALUES 
        (3009, 48, 'contacto_sexo', 'J');
      INSERT INTO public.heb412_gen_campoplantillahcm 
        (id, plantillahcm_id, nombrecampo, columna) VALUES 
        (3010, 48, 'contacto_edad_fecha_recepcion', 'K');
      INSERT INTO public.heb412_gen_campoplantillahcm 
        (id, plantillahcm_id, nombrecampo, columna) VALUES 
        (3011, 48, 'contacto_rangoedad_fecha_recepcion', 'L');
      INSERT INTO public.heb412_gen_campoplantillahcm 
        (id, plantillahcm_id, nombrecampo, columna) VALUES 
        (3012, 48, 'numero_beneficiarios', 'M');
      INSERT INTO public.heb412_gen_campoplantillahcm 
        (id, plantillahcm_id, nombrecampo, columna) VALUES 
        (3013, 48, 'numero_madres_gestantes', 'N');
      INSERT INTO public.heb412_gen_campoplantillahcm 
        (id, plantillahcm_id, nombrecampo, columna) VALUES 
        (3014, 48, 'beneficiarios_0_5_fecha_recepcion', 'O');
      INSERT INTO public.heb412_gen_campoplantillahcm 
        (id, plantillahcm_id, nombrecampo, columna) VALUES 
        (3015, 48, 'beneficiarios_6_12_fecha_recepcion', 'P');
      INSERT INTO public.heb412_gen_campoplantillahcm 
        (id, plantillahcm_id, nombrecampo, columna) VALUES 
        (3016, 48, 'beneficiarios_13_17_fecha_recepcion', 'Q');
      INSERT INTO public.heb412_gen_campoplantillahcm 
        (id, plantillahcm_id, nombrecampo, columna) VALUES 
        (3017, 48, 'beneficiarios_18_26_fecha_recepcion', 'R');
      INSERT INTO public.heb412_gen_campoplantillahcm 
        (id, plantillahcm_id, nombrecampo, columna) VALUES 
        (3018, 48, 'beneficiarios_27_59_fecha_recepcion', 'S');
      INSERT INTO public.heb412_gen_campoplantillahcm 
        (id, plantillahcm_id, nombrecampo, columna) VALUES 
        (3019, 48, 'beneficiarios_60m_fecha_recepcion', 'T');
      INSERT INTO public.heb412_gen_campoplantillahcm 
        (id, plantillahcm_id, nombrecampo, columna) VALUES 
        (3020, 48, 'beneficiarios_se_fecha_recepcion', 'U');
      INSERT INTO public.heb412_gen_campoplantillahcm 
        (id, plantillahcm_id, nombrecampo, columna) VALUES 
        (3021, 48, 'beneficiarias_0_5_fecha_recepcion', 'V');
      INSERT INTO public.heb412_gen_campoplantillahcm 
        (id, plantillahcm_id, nombrecampo, columna) VALUES 
        (3022, 48, 'beneficiarias_6_12_fecha_recepcion', 'W');
      INSERT INTO public.heb412_gen_campoplantillahcm 
        (id, plantillahcm_id, nombrecampo, columna) VALUES 
        (3023, 48, 'beneficiarias_13_17_fecha_recepcion', 'X');
      INSERT INTO public.heb412_gen_campoplantillahcm 
        (id, plantillahcm_id, nombrecampo, columna) VALUES 
        (3024, 48, 'beneficiarias_18_26_fecha_recepcion', 'Y');
      INSERT INTO public.heb412_gen_campoplantillahcm 
        (id, plantillahcm_id, nombrecampo, columna) VALUES 
        (3025, 48, 'beneficiarias_27_59_fecha_recepcion', 'Z');
      INSERT INTO public.heb412_gen_campoplantillahcm 
        (id, plantillahcm_id, nombrecampo, columna) VALUES 
        (3026, 48, 'beneficiarias_60m_fecha_recepcion', 'AA');
      INSERT INTO public.heb412_gen_campoplantillahcm 
        (id, plantillahcm_id, nombrecampo, columna) VALUES 
        (3027, 48, 'beneficiarias_se_fecha_recepcion', 'AB');
      INSERT INTO public.heb412_gen_campoplantillahcm 
        (id, plantillahcm_id, nombrecampo, columna) VALUES 
        (3028, 48, 'beneficiarios_ss_0_5_fecha_recepcion', 'AC');
      INSERT INTO public.heb412_gen_campoplantillahcm 
        (id, plantillahcm_id, nombrecampo, columna) VALUES 
        (3029, 48, 'beneficiarios_ss_6_12_fecha_recepcion', 'AD');
      INSERT INTO public.heb412_gen_campoplantillahcm 
        (id, plantillahcm_id, nombrecampo, columna) VALUES 
        (3030, 48, 'beneficiarios_ss_13_17_fecha_recepcion', 'AE');
      INSERT INTO public.heb412_gen_campoplantillahcm 
        (id, plantillahcm_id, nombrecampo, columna) VALUES 
        (3031, 48, 'beneficiarios_ss_18_26_fecha_recepcion', 'AF');
      INSERT INTO public.heb412_gen_campoplantillahcm 
        (id, plantillahcm_id, nombrecampo, columna) VALUES 
        (3032, 48, 'beneficiarios_ss_27_59_fecha_recepcion', 'AG');
      INSERT INTO public.heb412_gen_campoplantillahcm 
        (id, plantillahcm_id, nombrecampo, columna) VALUES 
        (3033, 48, 'beneficiarios_ss_60m_fecha_recepcion', 'AH');
      INSERT INTO public.heb412_gen_campoplantillahcm 
        (id, plantillahcm_id, nombrecampo, columna) VALUES 
        (3034, 48, 'beneficiarios_ss_se_fecha_recepcion', 'AI');

      INSERT INTO public.heb412_gen_campoplantillahcm 
        (id, plantillahcm_id, nombrecampo, columna) VALUES 
        (3035, 48, 'descripcion', 'AJ');

      INSERT INTO public.heb412_gen_campoplantillahcm 
        (id, plantillahcm_id, nombrecampo, columna) VALUES 
        (3036, 48, 'actividades_perfiles', 'AK');
      INSERT INTO public.heb412_gen_campoplantillahcm 
        (id, plantillahcm_id, nombrecampo, columna) VALUES 
        (3037, 48, 'estatus_migratorio', 'AL');
      INSERT INTO public.heb412_gen_campoplantillahcm 
        (id, plantillahcm_id, nombrecampo, columna) VALUES 
        (3038, 48, 'contacto_comosupo', 'AM');

      INSERT INTO public.heb412_gen_campoplantillahcm 
        (id, plantillahcm_id, nombrecampo, columna) VALUES 
        (3039, 48, 'actividades_a_humanitaria_tipos_de_ayuda', 'AN');
      INSERT INTO public.heb412_gen_campoplantillahcm 
        (id, plantillahcm_id, nombrecampo, columna) VALUES 
        (3040, 48, 'actividades_a_humanitaria_valor_de_ayuda', 'AO');
      INSERT INTO public.heb412_gen_campoplantillahcm 
        (id, plantillahcm_id, nombrecampo, columna) VALUES 
        (3041, 48, 'actividades_a_humanitaria_modalidades_entrega', 'AP');
      INSERT INTO public.heb412_gen_campoplantillahcm 
        (id, plantillahcm_id, nombrecampo, columna) VALUES 
        (3042, 48, 'actividades_a_humanitaria_convenios_financiados', 'AQ');
      INSERT INTO public.heb412_gen_campoplantillahcm 
        (id, plantillahcm_id, nombrecampo, columna) VALUES 
        (3043, 48, 'actividades_asesorias_juridicas', 'AR');
      INSERT INTO public.heb412_gen_campoplantillahcm 
        (id, plantillahcm_id, nombrecampo, columna) VALUES 
        (3044, 48, 'actividades_as_juridicas_convenios_financiados', 'AS');
      INSERT INTO public.heb412_gen_campoplantillahcm 
        (id, plantillahcm_id, nombrecampo, columna) VALUES 
        (3045, 48, 'actividades_acompañamientos_psicosociales', 'AT');
      INSERT INTO public.heb412_gen_campoplantillahcm 
        (id, plantillahcm_id, nombrecampo, columna) VALUES 
        (3046, 48, 'actividades_a_psicosociales_convenios_financiados', 'AU');

      INSERT INTO public.heb412_gen_campoplantillahcm 
        (id, plantillahcm_id, nombrecampo, columna) VALUES 
        (3050, 48, 'oficina', 'AV');

    SQL
  end
  def down
    execute <<-SQL
      DELETE FROM public.heb412_gen_campoplantillahcm 
        WHERE id>=3000 AND id<=3050;

      DELETE FROM public.heb412_gen_plantillahcm WHERE id=48;
    SQL
  end
end
