class LlenaTipotranferencia < ActiveRecord::Migration[6.0]
  def up
    execute <<-SQL
      INSERT INTO public.tipotransferencia (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES (1, 'Condicionada', null, '2020-09-12', null, '2020-09-12', '2020-09-12');
      INSERT INTO public.tipotransferencia (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES (2, 'Sin Condiciones', null, '2020-09-12', null, '2020-09-12', '2020-09-12');
      SELECT setval('public.tipotransferencia_id_seq', 100);
    SQL
  end

  def down
    execute <<-SQL
      DELETE FROM public.tipotransferencia WHERE id>='1' AND id<='2'
    SQL
  end
end
