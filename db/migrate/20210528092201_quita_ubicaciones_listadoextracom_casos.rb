class QuitaUbicacionesListadoextracomCasos < ActiveRecord::Migration[6.1]
  def up
    execute <<-SQL
      DELETE FROM public.heb412_gen_campoplantillahcm WHERE id>='267' AND id<='284';
      DELETE FROM public.heb412_gen_campoplantillahcm WHERE id='219';
    SQL
  end
  def down
    execute <<-SQL
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (267, 44, 'ubicacion1_pais', 'GE');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (268, 44, 'ubicacion1_departamento', 'GF');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (269, 44, 'ubicacion1_municipio', 'GG');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (270, 44, 'ubicacion1_clase', 'GH');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (271, 44, 'ubicacion1_longitud', 'GI');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (272, 44, 'ubicacion1_latitud', 'GJ');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (273, 44, 'ubicacion1_lugar', 'GK');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (274, 44, 'ubicacion1_sitio', 'GL');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (275, 44, 'ubicacion1_tsitio', 'GM');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (219, 44, 'ubicacion2_pais', 'GN');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (276, 44, 'ubicacion2_departamento', 'GO');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (277, 44, 'ubicacion2_municipio', 'GP');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (278, 44, 'ubicacion2_clase', 'GQ');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (279, 44, 'ubicacion2_longitud', 'GR');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (280, 44, 'ubicacion2_latitud', 'GS');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (281, 44, 'ubicacion2_lugar', 'GT');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (282, 44, 'ubicacion2_sitio', 'GU');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (283, 44, 'ubicacion2_tsitio', 'GV');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (284, 44, 'fechasalida', 'HF');
    SQL
  end
end
