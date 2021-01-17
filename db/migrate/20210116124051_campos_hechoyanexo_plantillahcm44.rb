class CamposHechoyanexoPlantillahcm44 < ActiveRecord::Migration[6.0]
  def up
    execute <<-SQL
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (950, 44, 'memo', 'ME');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (951, 44, 'numeroanexos', 'MF');
    SQL
  end

  def down
    execute <<-SQL
      DELETE FROM public.heb412_gen_campoplantillahcm WHERE id>='950' AND id<='951'
    SQL
  end
end
