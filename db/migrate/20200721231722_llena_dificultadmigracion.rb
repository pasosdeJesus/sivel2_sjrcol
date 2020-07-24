class LlenaDificultadmigracion < ActiveRecord::Migration[6.0]
  def up
    execute <<-SQL
      INSERT INTO public.dificultadmigracion (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES (1, 'Caída', null, '2020-07-21', null, '2020-07-21', '2020-07-21');
      INSERT INTO public.dificultadmigracion (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES (2, 'Golpe accidental', null, '2020-07-21', null, '2020-07-21', '2020-07-21');
      INSERT INTO public.dificultadmigracion (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES (3, 'Incapacidad de hacer las necesidades fisiológicas', null, '2020-07-21', null, '2020-07-21', '2020-07-21');
      INSERT INTO public.dificultadmigracion (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES (4, 'Incomodidad al dormir', null, '2020-07-21', null, '2020-07-21', '2020-07-21');
      INSERT INTO public.dificultadmigracion (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES (5, 'No acceso a medicamentos', null, '2020-07-21', null, '2020-07-21', '2020-07-21');
      INSERT INTO public.dificultadmigracion (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES (6, 'No acceso a alimentos', null, '2020-07-21', null, '2020-07-21', '2020-07-21');
      SELECT setval('public.dificultadmigracion_id_seq', 100);
    SQL
  end
  
  def down
    execute <<-SQL
      DELETE FROM public.dificultadmigracion WHERE id>='1' AND id<='6'
    SQL
  end
end
