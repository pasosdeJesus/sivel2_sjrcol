class LlenaAutoridadrefugio < ActiveRecord::Migration[6.0]
  def up
    execute <<-SQL
      INSERT INTO public.autoridadrefugio (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES (1, 'Organismo internacional', null, '2020-08-07', null, '2020-08-07', '2020-08-07');
      INSERT INTO public.autoridadrefugio (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES (2, 'Gobierno', null, '2020-08-07', null, '2020-08-07', '2020-08-07');
      INSERT INTO public.autoridadrefugio (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES (3, 'ONG especializada', null, '2020-08-07', null, '2020-08-07', '2020-08-07');
      INSERT INTO public.autoridadrefugio (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES (4, 'Casa de migrantes', null, '2020-08-07', null, '2020-08-07', '2020-08-07');
      INSERT INTO public.autoridadrefugio (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES (5, 'Otra', null, '2020-08-07', null, '2020-08-07', '2020-08-07');
      SELECT setval('public.autoridadrefugio_id_seq', 100);
    SQL
  end
  def down
    execute <<-SQL
      DELETE FROM public.autoridadrefugio WHERE id>='1' AND id<='5'
    SQL
  end
end
