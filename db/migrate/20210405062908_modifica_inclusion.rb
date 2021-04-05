class ModificaInclusion < ActiveRecord::Migration[6.1]
  def up
    execute <<-SQL
      UPDATE public.sivel2_sjr_inclusion SET nombre='SIN RESPUESTA' WHERE id=3;
      UPDATE public.sivel2_sjr_inclusion SET nombre='INCLUIDO' WHERE id=1;
      UPDATE public.sivel2_sjr_inclusion SET nombre='NO INCLUIDO' WHERE id=2;
      UPDATE public.sivel2_sjr_inclusion SET nombre='EN VALORACIÓN' WHERE id=4;
      UPDATE public.sivel2_sjr_inclusion SET nombre='EXCLUIDO' WHERE id=5;
    SQL
  end

  def down
    execute <<-SQL
      UPDATE public.sivel2_sjr_inclusion SET nombre='SIN RESPUESTA' WHERE id=1;
      UPDATE public.sivel2_sjr_inclusion SET nombre='INCLUIDO' WHERE id=2;
      UPDATE public.sivel2_sjr_inclusion SET nombre='NO INCLUIDO' WHERE id=3;
      UPDATE public.sivel2_sjr_inclusion SET nombre='EN VALORACIÓN' WHERE id=4;
      UPDATE public.sivel2_sjr_inclusion SET nombre='EXCLUIDO' WHERE id=5;
    SQL
  end
end
