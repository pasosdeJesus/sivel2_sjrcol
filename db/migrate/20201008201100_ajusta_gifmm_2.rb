class AjustaGifmm2 < ActiveRecord::Migration[6.0]
  def up
    execute <<-SQL
      UPDATE public.heb412_gen_campoplantillahcm 
        SET nombrecampo='departamento_gifmm' WHERE id = 433;
      UPDATE public.heb412_gen_campoplantillahcm 
        SET nombrecampo='municipio_gifmm' WHERE id = 434;

      UPDATE public.tipotransferencia 
 	SET nombre='Sin condiciones' WHERE id=2;
    SQL
  end
  def down
    execute <<-SQL
      UPDATE public.heb412_gen_campoplantillahcm 
        SET nombrecampo='departamento' WHERE id = 433;
      UPDATE public.heb412_gen_campoplantillahcm 
        SET nombrecampo='municipio' WHERE id = 434;

      UPDATE public.tipotransferencia 
 	SET nombre='Sin Condiciones' WHERE id=2;
    SQL
  end

end
