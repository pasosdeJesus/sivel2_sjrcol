class LlenaCausaagresion < ActiveRecord::Migration[6.0]
  def up
    execute <<-SQL
      INSERT INTO public.causaagresion (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
       VALUES (1, 'Nacionalidad / por ser migrante', null, '2020-07-22', null, '2020-07-22', '2020-07-22');
      INSERT INTO public.causaagresion (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
       VALUES (2, 'Raza, color de piel, origen étnico', null, '2020-07-22', null, '2020-07-22', '2020-07-22');
      INSERT INTO public.causaagresion (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
       VALUES (3, 'Edad', null, '2020-07-22', null, '2020-07-22', '2020-07-22');
      INSERT INTO public.causaagresion (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
       VALUES (4, 'Sexo / Orientación sexual', null, '2020-07-22', null, '2020-07-22', '2020-07-22');
      INSERT INTO public.causaagresion (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
       VALUES (5, 'No tener documentación migratoria', null, '2020-07-22', null, '2020-07-22', '2020-07-22');
      INSERT INTO public.causaagresion (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
       VALUES (6, 'Religión', null, '2020-07-22', null, '2020-07-22', '2020-07-22');
      INSERT INTO public.causaagresion (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
       VALUES (7, 'Limitación física/psíquica', null, '2020-07-22', null, '2020-07-22', '2020-07-22');
      INSERT INTO public.causaagresion (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
       VALUES (8, 'Otra', null, '2020-07-22', null, '2020-07-22', '2020-07-22');
      SELECT setval('public.causaagresion_id_seq', 100);
    SQL
  end

  def down
    execute <<-SQL
      DELETE FROM public.causaagresion WHERE id>='1' AND id<='8'
    SQL
  end
end
