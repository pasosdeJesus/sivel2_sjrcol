class LlenaFrecuanciaentrega < ActiveRecord::Migration[6.0]
  def up
    execute <<-SQL
      INSERT INTO public.frecuenciaentrega (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES (1, 'Una sola entrega', null, '2020-09-11', null, '2020-09-11', '2020-09-11');
      INSERT INTO public.frecuenciaentrega (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES (2, 'Semanal', null, '2020-09-11', null, '2020-09-11', '2020-09-11');
      INSERT INTO public.frecuenciaentrega (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES (3, 'Quincenal', null, '2020-09-11', null, '2020-09-11', '2020-09-11');
      INSERT INTO public.frecuenciaentrega (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES (4, 'Mensual', null, '2020-09-11', null, '2020-09-11', '2020-09-11');
      INSERT INTO public.frecuenciaentrega (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES (5, 'Bimensual', null, '2020-09-11', null, '2020-09-11', '2020-09-11');
      INSERT INTO public.frecuenciaentrega (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES (6, 'Trimestral', null, '2020-09-11', null, '2020-09-11', '2020-09-11');
      INSERT INTO public.frecuenciaentrega (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES (7, 'Anual', null, '2020-09-11', null, '2020-09-11', '2020-09-11');
      SELECT setval('public.frecuenciaentrega_id_seq', 100);
    SQL
  end

  def down
    execute <<-SQL
      DELETE FROM public.frecuenciaentrega WHERE id>='1' AND id<='7'
    SQL
  end
end
