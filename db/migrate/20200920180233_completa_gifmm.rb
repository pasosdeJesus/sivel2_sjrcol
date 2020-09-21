class CompletaGifmm < ActiveRecord::Migration[6.0]
  def up
    execute <<-SQL
      INSERT INTO public.heb412_gen_campoplantillahcm 
        (id, plantillahcm_id, nombrecampo,columna) VALUES 
        (432, 43, 'socio_implementador', 'C');

      INSERT INTO public.heb412_gen_campoplantillahcm 
        (id, plantillahcm_id, nombrecampo,columna) VALUES 
        (442, 43, 'detalleah_unidad', 'M');
      INSERT INTO public.heb412_gen_campoplantillahcm 
        (id, plantillahcm_id, nombrecampo,columna) VALUES 
        (443, 43, 'detalleah_cantidad', 'N');
      INSERT INTO public.heb412_gen_campoplantillahcm 
        (id, plantillahcm_id, nombrecampo,columna) VALUES 
        (444, 43, 'detalleah_modalidad', 'O');
      INSERT INTO public.heb412_gen_campoplantillahcm 
        (id, plantillahcm_id, nombrecampo,columna) VALUES 
        (445, 43, 'detalleah_tipo_transferencia', 'P');
      INSERT INTO public.heb412_gen_campoplantillahcm 
        (id, plantillahcm_id, nombrecampo,columna) VALUES 
        (446, 43, 'detalleah_mecanismo_entrega', 'Q');
      INSERT INTO public.heb412_gen_campoplantillahcm 
        (id, plantillahcm_id, nombrecampo,columna) VALUES 
        (447, 43, 'detalleah_frecuencia_entrega', 'R');
      INSERT INTO public.heb412_gen_campoplantillahcm 
        (id, plantillahcm_id, nombrecampo,columna) VALUES 
        (448, 43, 'detalleah_monto_por_persona', 'S');
      INSERT INTO public.heb412_gen_campoplantillahcm 
        (id, plantillahcm_id, nombrecampo,columna) VALUES 
        (449, 43, 'detalleah_numero_meses_cobertura', 'T');

      INSERT INTO public.heb412_gen_campoplantillahcm 
        (id, plantillahcm_id, nombrecampo,columna) VALUES 
        (450, 43, 'poblacion', 'U');
      INSERT INTO public.heb412_gen_campoplantillahcm 
        (id, plantillahcm_id, nombrecampo,columna) VALUES 
        (451, 43, 'poblacion_nuevos', 'V');

      INSERT INTO public.heb412_gen_campoplantillahcm 
        (id, plantillahcm_id, nombrecampo,columna) VALUES 
        (452, 43, 'poblacion_vocacion_permanencia', 'W');
      INSERT INTO public.heb412_gen_campoplantillahcm 
        (id, plantillahcm_id, nombrecampo,columna) VALUES 
        (453, 43, 'poblacion_transito', 'X');
      INSERT INTO public.heb412_gen_campoplantillahcm 
        (id, plantillahcm_id, nombrecampo,columna) VALUES 
        (454, 43, 'poblacion_pendulares', 'Y');
      INSERT INTO public.heb412_gen_campoplantillahcm 
        (id, plantillahcm_id, nombrecampo,columna) VALUES 
        (455, 43, 'poblacion_colombianos_retornados', 'Z');
        
      UPDATE public.heb412_gen_campoplantillahcm 
        SET nombrecampo='poblacion_com_acogida' WHERE id = 456;
      UPDATE public.heb412_gen_campoplantillahcm 
        SET nombrecampo='poblacion_ninas_adolescentes_y_se' WHERE id = 457;
      INSERT INTO public.heb412_gen_campoplantillahcm 
        (id, plantillahcm_id, nombrecampo,columna) VALUES 
        (458, 43, 'poblacion_mujeres_adultas', 'AC');

      UPDATE public.heb412_gen_campoplantillahcm 
        SET nombrecampo='poblacion_ninos_adolescentes_y_se' WHERE id = 464; --AI

      INSERT INTO public.heb412_gen_campoplantillahcm 
        (id, plantillahcm_id, nombrecampo,columna) VALUES 
        (485, 43, 'poblacion_hombres_adultos', 'AJ');

      UPDATE public.heb412_gen_campoplantillahcm 
        SET nombrecampo='poblacion_hombres_r_g1' WHERE id = 465; --AK
      
      UPDATE public.heb412_gen_campoplantillahcm 
        SET nombrecampo='poblacion_hombres_r_g5' WHERE id = 469; --AQ

      UPDATE public.heb412_gen_campoplantillahcm 
        SET nombrecampo='poblacion_menores_sin_sexo' WHERE id = 470; --AP
      UPDATE public.heb412_gen_campoplantillahcm 
        SET nombrecampo='poblacion_adultos_sin_sexo' WHERE id = 471; --AP

      INSERT INTO public.heb412_gen_campoplantillahcm 
        (id, plantillahcm_id, nombrecampo,columna) VALUES 
        (473, 43, 'num_con_discapacidad', 'AS');

      INSERT INTO public.heb412_gen_campoplantillahcm 
        (id, plantillahcm_id, nombrecampo,columna) VALUES 
        (479, 43, 'responsable', 'AY');
      INSERT INTO public.heb412_gen_campoplantillahcm 
        (id, plantillahcm_id, nombrecampo,columna) VALUES 
        (480, 43, 'oficina', 'AZ');
    SQL
  end
  def down
    execute <<-SQL
      DELETE FROM heb412_gen_campoplantillahcm WHERE 
      (id>=442 AND id<=455) OR id IN (432, 458, 465, 473, 479, 480, 485);
    SQL
  end
end
