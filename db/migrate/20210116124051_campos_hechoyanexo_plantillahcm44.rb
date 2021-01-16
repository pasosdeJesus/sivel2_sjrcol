class CamposHechoyanexoPlantillahcm44 < ActiveRecord::Migration[6.0]
  def up
    execute <<-SQL
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (520, 44, 'memo', 'ME');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (521, 44, 'numeroanexos', 'MF');
    SQL
  end

  def down
    execute <<-SQL
      DELETE FROM public.heb412_gen_campoplantillahcm WHERE id>='520' AND id<='521'
    SQL
  end
end
