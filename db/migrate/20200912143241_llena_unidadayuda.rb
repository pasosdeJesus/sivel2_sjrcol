class LlenaUnidadayuda < ActiveRecord::Migration[6.0]
  def up
    execute <<-SQL
      INSERT INTO public.unidadayuda (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES (1, 'Actores/ Docentes / Trabajadores Comunitarios', null, '2020-09-12', null, '2020-09-12', '2020-09-12');
      INSERT INTO public.unidadayuda (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES (2, 'Alianzas público-privadas', null, '2020-09-12', null, '2020-09-12', '2020-09-12');
      INSERT INTO public.unidadayuda (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES (3, 'Atenciones', null, '2020-09-12', null, '2020-09-12', '2020-09-12');
      INSERT INTO public.unidadayuda (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES (4, 'Campañas /iniciativas de cohesión social', null, '2020-09-12', null, '2020-09-12', '2020-09-12');
      INSERT INTO public.unidadayuda (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES (5, 'Casos/Brotes', null, '2020-09-12', null, '2020-09-12', '2020-09-12');
      INSERT INTO public.unidadayuda (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES (6, 'Donantes', null, '2020-09-12', null, '2020-09-12', '2020-09-12');
      INSERT INTO public.unidadayuda (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES (7, 'Funcionarios', null, '2020-09-12', null, '2020-09-12', '2020-09-12');
      INSERT INTO public.unidadayuda (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES (8, 'Insumos y equipos', null, '2020-09-12', null, '2020-09-12', '2020-09-12');
      INSERT INTO public.unidadayuda (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES (9, 'Kits', null, '2020-09-12', null, '2020-09-12', '2020-09-12');
      INSERT INTO public.unidadayuda (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES (10, 'Medicamentos', null, '2020-09-12', null, '2020-09-12', '2020-09-12');
      INSERT INTO public.unidadayuda (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES (11, 'Planes de contingencia', null, '2020-09-12', null, '2020-09-12', '2020-09-12');
      INSERT INTO public.unidadayuda (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES (12, 'Productos (informes, recomendaciones, boletines, páginas web, etc.)', null, '2020-09-12', null, '2020-09-12', '2020-09-12');
      INSERT INTO public.unidadayuda (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES (13, 'Remisiones entre actores/sectores', null, '2020-09-12', null, '2020-09-12', '2020-09-12');
      INSERT INTO public.unidadayuda (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES (14, 'Reuniones/sesiones de trabajo/talleres', null, '2020-09-12', null, '2020-09-12', '2020-09-12');
      INSERT INTO public.unidadayuda (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES (15, 'Seguimiento/control médico', null, '2020-09-12', null, '2020-09-12', '2020-09-12');
      INSERT INTO public.unidadayuda (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES (16, 'Servicio/procedimiento médico', null, '2020-09-12', null, '2020-09-12', '2020-09-12');
      INSERT INTO public.unidadayuda (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES (17, 'Unidades productivas', null, '2020-09-12', null, '2020-09-12', '2020-09-12');
      SELECT setval('public.unidadayuda_id_seq', 100);
    SQL
  end

  def down
    execute <<-SQL
      DELETE FROM public.unidadayuda WHERE id>='1' AND id<='17'
    SQL
  end
end
