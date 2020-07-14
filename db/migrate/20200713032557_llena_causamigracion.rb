class LlenaCausamigracion < ActiveRecord::Migration[6.0]
  def up
    execute <<-SQL
      INSERT INTO public.causamigracion (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at) 
        VALUES (1, 'Reunificación familiar', null, '2020-07-13', null, '2020-07-13', '2020-07-13');
      INSERT INTO public.causamigracion (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at) 
        VALUES (2, 'Razones económicas (pobreza, falta de empleo, bajo salario)', null, '2020-07-13', null, '2020-07-13', '2020-07-13');
      INSERT INTO public.causamigracion (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at) 
        VALUES (3, 'Violencia social en su lugar de residencia (guerra, extorsión, abusos, inseguridad)', null, '2020-07-13', null, '2020-07-13', '2020-07-13');
      INSERT INTO public.causamigracion (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at) 
        VALUES (4, 'Violencia doméstica', null, '2020-07-13', null, '2020-07-13', '2020-07-13');
      INSERT INTO public.causamigracion (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at) 
        VALUES (5, 'Violación grave a los DDHH', null, '2020-07-13', null, '2020-07-13', '2020-07-13');
      INSERT INTO public.causamigracion (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at) 
        VALUES (6, 'Persecución (política, religiosa, étnica, sexual)', null, '2020-07-13', null, '2020-07-13', '2020-07-13');
      INSERT INTO public.causamigracion (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at) 
        VALUES (7, 'Problemas de salud', null, '2020-07-13', null, '2020-07-13', '2020-07-13');
      INSERT INTO public.causamigracion (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at) 
        VALUES (8, 'Para estudiar', null, '2020-07-13', null, '2020-07-13', '2020-07-13');
      INSERT INTO public.causamigracion (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at) 
        VALUES (9, 'Desastre natural', null, '2020-07-13', null, '2020-07-13', '2020-07-13');
      INSERT INTO public.causamigracion (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at) 
        VALUES (10, 'Intento de reclutamiento forzado', null, '2020-07-13', null, '2020-07-13', '2020-07-13');
      INSERT INTO public.causamigracion (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at) 
        VALUES (11, 'Otra', null, '2020-07-13', null, '2020-07-13', '2020-07-13');
      SELECT setval('public.causamigracion_id_seq', 100);
    SQL
  end

  def down
    execute <<-SQL
      DELETE FROM public.causamigracion WHERE id>='1' AND id<='100'
    SQL
  end
end
