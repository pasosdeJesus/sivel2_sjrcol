class PlantillaCasosEmah < ActiveRecord::Migration[6.0]
  def up

    if Heb412Gen::Plantillahcm.where(id: 1).count == 0
      execute <<-SQL
        INSERT INTO public.heb412_gen_plantillahcm (id, ruta, fuente, licencia, vista, nombremenu, filainicial) VALUES (1, 'Plantillas/Registro_de_casos_atendidos_EMAH_V4.ods', '', '', 'Caso', 'Registro de casos atendidos EMAH', 9);
  
        INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (1, 1, 'ultimaatencion_mes', 'A');
        INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (2, 1, 'ultimaatencion_fecha', 'B');
        INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (3, 1, 'contacto_nombres', 'C');
        INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (4, 1, 'contacto_apellidos', 'D');
        INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (5, 1, 'contacto_identificacion', 'E');
        INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (6, 1, 'contacto_sexo', 'F');
        INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (8, 1, 'contacto_etnia', 'H');
        INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (9, 1, 'beneficiarios_0_5', 'I');
        INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (10, 1, 'beneficiarios_6_12', 'J');
        INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (11, 1, 'beneficiarios_13_17', 'K');
        INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (12, 1, 'beneficiarios_18_26', 'L');
        INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (13, 1, 'beneficiarios_27_59', 'M');
        INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (14, 1, 'beneficiarios_60_', 'N');
        INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (15, 1, 'beneficiarias_0_5', 'O');
        INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (16, 1, 'beneficiarias_6_12', 'P');
        INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (17, 1, 'beneficiarias_13_17', 'Q');
        INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (18, 1, 'beneficiarias_18_26', 'R');
        INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (19, 1, 'beneficiarias_27_59', 'S');
        INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (20, 1, 'beneficiarias_60_', 'T');
        INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (21, 1, 'ultimaatencion_derechosvul', 'U');
        INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (22, 1, 'ultimaatencion_as_humanitaria', 'V');
        INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (23, 1, 'ultimaatencion_as_juridica', 'W');
        INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (24, 1, 'ultimaatencion_otros_ser_as', 'X');
        INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (25, 1, 'ultimaatencion_descripcion_at', 'Y');
        INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (26, 1, 'oficina', 'Z');
      SQL
    end
  end

  def down
    execute <<-SQL
      DELETE FROM public.heb412_gen_campoplantillahcm WHERE plantillahcm_id=1;
      DELETE FROM public.heb412_gen_plantillahcm WHERE id=1;
    SQL
  end
end
