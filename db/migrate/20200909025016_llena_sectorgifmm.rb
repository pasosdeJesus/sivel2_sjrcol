class LlenaSectorgifmm < ActiveRecord::Migration[6.0]
  def up
    execute <<-SQL
      INSERT INTO public.sectorgifmm (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES (1, 'Agua_y_saneamiento', null, '2020-09-08', null, '2020-09-08', '2020-09-08');
      INSERT INTO public.sectorgifmm (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES (2, 'Albergue', null, '2020-09-08', null, '2020-09-08', '2020-09-08');
      INSERT INTO public.sectorgifmm (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES (3, 'Comunicación', null, '2020-09-08', null, '2020-09-08', '2020-09-08');
      INSERT INTO public.sectorgifmm (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES (4, 'Comunicación_con_Comunidades', null, '2020-09-08', null, '2020-09-08', '2020-09-08');
      INSERT INTO public.sectorgifmm (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES (5, 'Coordinación', null, '2020-09-08', null, '2020-09-08', '2020-09-08');
      INSERT INTO public.sectorgifmm (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES (6, 'Educación', null, '2020-09-08', null, '2020-09-08', '2020-09-08');
      INSERT INTO public.sectorgifmm (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES (7, 'Integración', null, '2020-09-08', null, '2020-09-08', '2020-09-08');
      INSERT INTO public.sectorgifmm (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES (8, 'Manejo_de_Información', null, '2020-09-08', null, '2020-09-08', '2020-09-08');
      INSERT INTO public.sectorgifmm (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES (9, 'Multipurpose_CBI', null, '2020-09-08', null, '2020-09-08', '2020-09-08');
      INSERT INTO public.sectorgifmm (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES (10, 'NFI', null, '2020-09-08', null, '2020-09-08', '2020-09-08');
      INSERT INTO public.sectorgifmm (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES (11, 'Nutrición', null, '2020-09-08', null, '2020-09-08', '2020-09-08');
      INSERT INTO public.sectorgifmm (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES (12, 'Otro', null, '2020-09-08', null, '2020-09-08', '2020-09-08');
      INSERT INTO public.sectorgifmm (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES (13, 'PEAS', null, '2020-09-08', null, '2020-09-08', '2020-09-08');
      INSERT INTO public.sectorgifmm (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES (14, 'Protección', null, '2020-09-08', null, '2020-09-08', '2020-09-08');
      INSERT INTO public.sectorgifmm (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES (15, 'Protección_NNA', null, '2020-09-08', null, '2020-09-08', '2020-09-08');
      INSERT INTO public.sectorgifmm (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES (16, 'Recaudación_fondos', null, '2020-09-08', null, '2020-09-08', '2020-09-08');
      INSERT INTO public.sectorgifmm (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES (17, 'Salud', null, '2020-09-08', null, '2020-09-08', '2020-09-08');
      INSERT INTO public.sectorgifmm (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES (18, 'Seguridad_Alimentaria', null, '2020-09-08', null, '2020-09-08', '2020-09-08');
      INSERT INTO public.sectorgifmm (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES (19, 'Transporte_Humanitario', null, '2020-09-08', null, '2020-09-08', '2020-09-08');
      INSERT INTO public.sectorgifmm (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES (20, 'Trata_de_Personas', null, '2020-09-08', null, '2020-09-08', '2020-09-08');
      INSERT INTO public.sectorgifmm (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES (21, 'VBG', null, '2020-09-08', null, '2020-09-08', '2020-09-08');
      SELECT setval('public.sectorgifmm_id_seq', 100);
    SQL
  end

  def down
    execute <<-SQL
      DELETE FROM public.sectorgifmm WHERE id>='1' AND id<='21'
    SQL
  end
end
