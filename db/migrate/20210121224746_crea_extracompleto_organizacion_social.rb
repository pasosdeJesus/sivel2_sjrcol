class CreaExtracompletoOrganizacionSocial < ActiveRecord::Migration[6.0]

  def up
    execute <<-SQL

      INSERT INTO public.heb412_gen_plantillahcm 
      (id, ruta, fuente, licencia, vista, nombremenu, filainicial) VALUES 
      (49, 'Plantillas/listado_extracompleto_de_organizaciones_sociales.ods', 
      '', '', 'Actorsocial', 'Listado extracompleto de organizaciones sociales', 4);

      INSERT INTO public.heb412_gen_campoplantillahcm 
        (id, plantillahcm_id, nombrecampo, columna) VALUES 
        (3300, 49, 'id', 'A');
      INSERT INTO public.heb412_gen_campoplantillahcm 
        (id, plantillahcm_id, nombrecampo, columna) VALUES 
        (3301, 49, 'nombre', 'B');
      INSERT INTO public.heb412_gen_campoplantillahcm 
        (id, plantillahcm_id, nombrecampo, columna) VALUES 
        (3302, 49, 'anotaciones', 'C');
      INSERT INTO public.heb412_gen_campoplantillahcm 
        (id, plantillahcm_id, nombrecampo, columna) VALUES 
        (3303, 49, 'tipo', 'D');
      INSERT INTO public.heb412_gen_campoplantillahcm 
        (id, plantillahcm_id, nombrecampo, columna) VALUES 
        (3304, 49, 'población_relacionada', 'E');
      INSERT INTO public.heb412_gen_campoplantillahcm 
        (id, plantillahcm_id, nombrecampo, columna) VALUES 
        (3305, 49, 'email', 'F');
      INSERT INTO public.heb412_gen_campoplantillahcm 
        (id, plantillahcm_id, nombrecampo, columna) VALUES 
        (3306, 49, 'web', 'G');
      INSERT INTO public.heb412_gen_campoplantillahcm 
        (id, plantillahcm_id, nombrecampo, columna) VALUES 
        (3307, 49, 'teléfono', 'H');
      INSERT INTO public.heb412_gen_campoplantillahcm 
        (id, plantillahcm_id, nombrecampo, columna) VALUES 
        (3308, 49, 'fax', 'I');
      INSERT INTO public.heb412_gen_campoplantillahcm 
        (id, plantillahcm_id, nombrecampo, columna) VALUES 
        (3309, 49, 'país', 'J');
      INSERT INTO public.heb412_gen_campoplantillahcm 
        (id, plantillahcm_id, nombrecampo, columna) VALUES 
        (3310, 49, 'departamento', 'K');
      INSERT INTO public.heb412_gen_campoplantillahcm 
        (id, plantillahcm_id, nombrecampo, columna) VALUES 
        (3311, 49, 'municipio', 'L');
      INSERT INTO public.heb412_gen_campoplantillahcm 
        (id, plantillahcm_id, nombrecampo, columna) VALUES 
        (3312, 49, 'dirección', 'M');
      INSERT INTO public.heb412_gen_campoplantillahcm 
        (id, plantillahcm_id, nombrecampo, columna) VALUES 
        (3313, 49, 'nit', 'N');
      INSERT INTO public.heb412_gen_campoplantillahcm 
        (id, plantillahcm_id, nombrecampo, columna) VALUES 
        (3314, 49, 'creación', 'O');
      INSERT INTO public.heb412_gen_campoplantillahcm 
        (id, plantillahcm_id, nombrecampo, columna) VALUES 
        (3315, 49, 'actualización', 'P');

    SQL
  end
  def down
    execute <<-SQL
      DELETE FROM public.heb412_gen_campoplantillahcm 
        WHERE id>=3300 AND id<=3350;

      DELETE FROM public.heb412_gen_plantillahcm WHERE id=49;
    SQL
  end
end
