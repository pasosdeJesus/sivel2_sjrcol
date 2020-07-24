class LlenaAgresionmigracion < ActiveRecord::Migration[6.0]
  def up
    execute <<-SQL
      INSERT INTO public.agresionmigracion (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES (1, 'Asalto', null, '2020-07-22', null, '2020-07-22', '2020-07-22');
      INSERT INTO public.agresionmigracion (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES (2, 'Robo', null, '2020-07-22', null, '2020-07-22', '2020-07-22');
      INSERT INTO public.agresionmigracion (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES (3, 'Extorsión', null, '2020-07-22', null, '2020-07-22', '2020-07-22');
      INSERT INTO public.agresionmigracion (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES (4, 'Violencia física', null, '2020-07-22', null, '2020-07-22', '2020-07-22');
      INSERT INTO public.agresionmigracion (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES (5, 'Violencia verbal', null, '2020-07-22', null, '2020-07-22', '2020-07-22');
      INSERT INTO public.agresionmigracion (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES (6, 'Violencia psicológica', null, '2020-07-22', null, '2020-07-22', '2020-07-22');
      INSERT INTO public.agresionmigracion (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES (7, 'Abuso / violencia sexual', null, '2020-07-22', null, '2020-07-22', '2020-07-22');
      INSERT INTO public.agresionmigracion (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES (8, 'Secuestro', null, '2020-07-22', null, '2020-07-22', '2020-07-22');
      INSERT INTO public.agresionmigracion (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES (9, 'Obligación a realizar actividades ilícitas', null, '2020-07-22', null, '2020-07-22', '2020-07-22');
      INSERT INTO public.agresionmigracion (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES (10, 'Privación o retención de la documentación', null, '2020-07-22', null, '2020-07-22', '2020-07-22');
      INSERT INTO public.agresionmigracion (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES (11, 'Negación de atención (educación, salud, justicia, documentación)', null, '2020-07-22', null, '2020-07-22', '2020-07-22');
      INSERT INTO public.agresionmigracion (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES (12, 'Abuso de autoridad', null, '2020-07-22', null, '2020-07-22', '2020-07-22');
      INSERT INTO public.agresionmigracion (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES (13, 'Otra', null, '2020-07-22', null, '2020-07-22', '2020-07-22');
      SELECT setval('public.agresionmigracion_id_seq', 100);
    SQL
  end

  def down
    execute <<-SQL
      DELETE FROM public.agresionmigracion WHERE id>='1' AND id<='13'
    SQL
  end
end
