class LlenaMiembrofamiliar < ActiveRecord::Migration[6.0]
  def up
    execute <<-SQL
      INSERT INTO public.miembrofamiliar (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES (1, 'Pareja sentimental', null, '2020-08-07', null, '2020-08-07', '2020-08-07');
      INSERT INTO public.miembrofamiliar (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES (2, 'Madre-Padre', null, '2020-08-07', null, '2020-08-07', '2020-08-07');
      INSERT INTO public.miembrofamiliar (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES (3, 'Hijo/s-Hija/s', null, '2020-08-07', null, '2020-08-07', '2020-08-07');
      INSERT INTO public.miembrofamiliar (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES (4, 'Abuelo-abuela', null, '2020-08-07', null, '2020-08-07', '2020-08-07');
      INSERT INTO public.miembrofamiliar (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES (5, 'Hermana/s - Hermano/s', null, '2020-08-07', null, '2020-08-07', '2020-08-07');
      INSERT INTO public.miembrofamiliar (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES (6, 'Otros', null, '2020-08-07', null, '2020-08-07', '2020-08-07');
      SELECT setval('public.miembrofamiliar_id_seq', 100);
    SQL
  end

  def down
    execute <<-SQL
      DELETE FROM public.miembrofamiliar WHERE id>='1' AND id<='6'
    SQL
  end
end
