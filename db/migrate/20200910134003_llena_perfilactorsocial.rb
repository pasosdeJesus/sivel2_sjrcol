class LlenaPerfilactorsocial < ActiveRecord::Migration[6.0]
  def up
    execute <<-SQL
      INSERT INTO public.sip_perfilactorsocial (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES (1, 'Vocacion de permanencia', null, '2020-09-10', null, '2020-09-10', '2020-09-10');
      INSERT INTO public.sip_perfilactorsocial (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES (2, 'Tránsito', null, '2020-09-10', null, '2020-09-10', '2020-09-10');
      INSERT INTO public.sip_perfilactorsocial (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES (3, 'Pendular', null, '2020-09-10', null, '2020-09-10', '2020-09-10');
      INSERT INTO public.sip_perfilactorsocial (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES (4, 'Comunidad de acogida', null, '2020-09-10', null, '2020-09-10', '2020-09-10');
      SELECT setval('public.sip_perfilactorsocial_id_seq', 100);
    SQL
  end

  def down
    execute <<-SQL
      DELETE FROM public.sip_perfilactorsocial WHERE id>='1' AND id<='4'
    SQL
  end
end
