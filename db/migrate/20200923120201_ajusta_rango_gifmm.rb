class AjustaRangoGifmm < ActiveRecord::Migration[6.0]
  def up
    execute <<-SQL
      UPDATE public.heb412_gen_campoplantillahcm 
        SET nombrecampo='poblacion_hombres_r_g_4_5' WHERE id = 468; --AN
      UPDATE public.heb412_gen_campoplantillahcm 
        SET nombrecampo='poblacion_hombres_r_g6' WHERE id = 469; --AN
      UPDATE public.heb412_gen_campoplantillahcm 
        SET nombrecampo='poblacion_mujeres_r_g_4_5' WHERE id = 462; --AG
      UPDATE public.heb412_gen_campoplantillahcm 
        SET nombrecampo='poblacion_mujeres_r_g6' WHERE id = 463; --AH

      UPDATE public.heb412_gen_campoplantillahcm 
        SET nombrecampo='poblacion_niñas_adolescentes_y_se' WHERE id = 457; 
      UPDATE public.heb412_gen_campoplantillahcm 
        SET nombrecampo='poblacion_niños_adolescentes_y_se' WHERE id = 464; --AI
      
      UPDATE public.heb412_gen_campoplantillahcm 
        SET nombrecampo='poblacion_sinsexo_adultos' WHERE id = 470; --AP
      UPDATE public.heb412_gen_campoplantillahcm 
        SET nombrecampo='poblacion_sinsexo_menores' WHERE id = 471; --AQ

    SQL
  end
  def down
  end
end
