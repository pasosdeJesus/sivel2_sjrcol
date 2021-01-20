class PlantillaCasoEnRecepcion < ActiveRecord::Migration[6.0]
  def up
    execute <<-SQL
      INSERT INTO public.heb412_gen_plantillahcm (id, ruta, fuente, licencia, vista, nombremenu, filainicial) VALUES (47, 'Plantillas/InformacionCasoEnRecepcion.ods', '', '', 'Caso', 'Información del caso durante recepción', 10);

      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (2800, 47, 'caso_id', 'A');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (2801, 47, 'fecharecepcion', 'B');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (2802, 47, 'contacto_nombres', 'C');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (2803, 47, 'contacto_apellidos', 'D');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (2804, 47, 'contacto_identificacion', 'E');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (2805, 47, 'contacto_edad_fecharec', 'F');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (2806, 47, 'contacto_sexo', 'G');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (2807, 47, 'beneficiarios_0_5', 'H');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (2808, 47, 'beneficiarios_6_12', 'I');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (2809, 47, 'beneficiarios_13_17', 'J');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (2810, 47, 'beneficiarios_18_26', 'K');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (2811, 47, 'beneficiarios_27_59', 'L');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (2812, 47, 'beneficiarios_60_', 'M');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (2813, 47, 'beneficiarios_se', 'N');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (2814, 47, 'beneficiarias_0_5', 'O');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (2815, 47, 'beneficiarias_6_12', 'P');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (2816, 47, 'beneficiarias_13_17', 'Q');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (2817, 47, 'beneficiarias_18_26', 'R');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (2818, 47, 'beneficiarias_27_59', 'S');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (2819, 47, 'beneficiarias_60_', 'T');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (2820, 47, 'beneficiarias_se', 'U');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (2821, 47, 'beneficiarios_ss_0_5', 'V');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (2822, 47, 'beneficiarios_ss_6_12', 'W');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (2823, 47, 'beneficiarios_ss_13_17', 'X');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (2824, 47, 'beneficiarios_ss_18_26', 'Y');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (2825, 47, 'beneficiarios_ss_27_59', 'Z');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (2827, 47, 'beneficiarios_ss_60_', 'AA');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (2828, 47, 'beneficiarios_ss_se', 'AB');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (2829, 47, 'descripcion', 'AC');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (2830, 47, 'oficina', 'AD');

      DROP MATERIALIZED VIEW IF EXISTS sivel2_gen_consexpcaso;
    SQL
  end
  def down
    execute <<-SQL
      DELETE FROM public.heb412_gen_campoplantillahcm 
        WHERE id>=2800 AND id<=2830;

      DELETE FROM public.heb412_gen_plantillahcm WHERE id=47;

      DROP MATERIALIZED VIEW IF EXISTS sivel2_gen_consexpcaso;
    SQL
  end
end
