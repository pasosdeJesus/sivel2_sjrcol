class AjustaGifmm2 < ActiveRecord::Migration[6.0]
  def up
    execute <<-SQL
      UPDATE public.heb412_gen_campoplantillahcm 
        SET nombrecampo='departamento_altas_bajas' WHERE id = 433;
      UPDATE public.heb412_gen_campoplantillahcm 
        SET nombrecampo='municipio_altas_bajas' WHERE id = 434;
    SQL
  end
  def down
    execute <<-SQL
      UPDATE public.heb412_gen_campoplantillahcm 
        SET nombrecampo='departamento' WHERE id = 433;
      UPDATE public.heb412_gen_campoplantillahcm 
        SET nombrecampo='municipio' WHERE id = 434;
    SQL
  end

end
