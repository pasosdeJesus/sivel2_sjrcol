class LlenaPerfilactorsocial < ActiveRecord::Migration[6.0]
  def up
    execute <<-SQL
      INSERT INTO public.sip_perfilactorsocial (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES (10, 'Vocacion de permanencia', null, '2020-09-10', null, '2020-09-10', '2020-09-10');
      INSERT INTO public.sip_perfilactorsocial (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES (11, 'Tránsito', null, '2020-09-10', null, '2020-09-10', '2020-09-10');
      INSERT INTO public.sip_perfilactorsocial (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES (12, 'Pendular', null, '2020-09-10', null, '2020-09-10', '2020-09-10');
      INSERT INTO public.sip_perfilactorsocial (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES (13, 'Comunidad de acogida', null, '2020-09-10', null, '2020-09-10', '2020-09-10');
      SELECT setval('public.sip_perfilactorsocial_id_seq', 100);
    SQL
  end

  def down
    execute <<-SQL
      DELETE FROM public.sip_perfilactorsocial WHERE id>='10' AND id<='13'
    SQL
  end
end
