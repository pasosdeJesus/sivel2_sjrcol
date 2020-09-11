class LlenaMecanismodeentrega < ActiveRecord::Migration[6.0]
  def up
    execute <<-SQL
      INSERT INTO public.mecanismodeentrega (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES (1, 'Efectivo directo (en sobre, ventanilla, cajero, cuenta bancaria…)', null, '2020-09-11', null, '2020-09-11', '2020-09-11');
      INSERT INTO public.mecanismodeentrega (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES (2, 'Tarjeta pre-pago', null, '2020-09-11', null, '2020-09-11', '2020-09-11');
      INSERT INTO public.mecanismodeentrega (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES (3, 'Cuenta Teléfono Móvil', null, '2020-09-11', null, '2020-09-11', '2020-09-11');
      INSERT INTO public.mecanismodeentrega (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES (4, 'Cupón en papel', null, '2020-09-11', null, '2020-09-11', '2020-09-11');
      INSERT INTO public.mecanismodeentrega (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES (5, 'Cupón electrónico (tarjeta)', null, '2020-09-11', null, '2020-09-11', '2020-09-11');
      INSERT INTO public.mecanismodeentrega (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES (6, 'Otro', null, '2020-09-11', null, '2020-09-11', '2020-09-11');
      SELECT setval('public.mecanismodeentrega_id_seq', 100);
    SQL
  end

  def down
    execute <<-SQL
      DELETE FROM public.mecanismodeentrega WHERE id>='1' AND id<='6'
    SQL
  end
end
