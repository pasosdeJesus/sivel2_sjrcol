class LlenaTipoproteccion < ActiveRecord::Migration[6.0]
  def up
    execute <<-SQL
      INSERT INTO public.tipoproteccion (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES (1, 'Individual', null, '2020-08-07', null, '2020-08-07', '2020-08-07');
      INSERT INTO public.tipoproteccion (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES (2, 'Familiar', null, '2020-08-07', null, '2020-08-07', '2020-08-07');
      SELECT setval('public.tipoproteccion_id_seq', 100);
    SQL
  end

  def down
    execute <<-SQL
      DELETE FROM public.tipoproteccion WHERE id>='1' AND id<='2'
    SQL
  end
end
