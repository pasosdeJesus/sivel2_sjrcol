class LlenaModalidadentrega < ActiveRecord::Migration[6.0]
  def up
    execute <<-SQL
      INSERT INTO public.modalidadentrega (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES (1, 'En especie', null, '2020-09-12', null, '2020-09-12', '2020-09-12');
      INSERT INTO public.modalidadentrega (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES (2, 'Transferencia', null, '2020-09-12', null, '2020-09-12', '2020-09-12');
      SELECT setval('public.modalidadentrega_id_seq', 100);
    SQL
  end

  def down
    execute <<-SQL
      DELETE FROM public.modalidadentrega WHERE id>='1' AND id<='2'
    SQL
  end
end
