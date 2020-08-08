class ModificaDatosDeStatusmigratorio < ActiveRecord::Migration[6.0]
  def up
    execute <<-SQL
      UPDATE public.sivel2_sjr_statusmigratorio SET fechadeshabilitacion='2020-08-04' WHERE id=5;
      UPDATE public.sivel2_sjr_statusmigratorio SET fechadeshabilitacion='2020-08-04' WHERE id=6;
      INSERT INTO public.sivel2_sjr_statusmigratorio (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES (9, 'COLOMBIANO DEPORTADO', null, '2020-08-05', null, '2020-08-05', '2020-08-05');
      INSERT INTO public.sivel2_sjr_statusmigratorio (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES (10, 'COLOMBIANO EXPULSADO', null, '2020-08-05', null, '2020-08-05', '2020-08-05');
      INSERT INTO public.sivel2_sjr_statusmigratorio (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES (11, 'COLOMBIANO RETORNADO', null, '2020-08-05', null, '2020-08-05', '2020-08-05');
    SQL
  end

  def down
    execute <<-SQL
      DELETE FROM public.sivel2_sjr_statusmigratorio WHERE id>='9' AND id<='11';
      UPDATE public.sivel2_sjr_statusmigratorio 
        SET fechadeshabilitacion=null WHERE id=5;
      UPDATE public.sivel2_sjr_statusmigratorio 
        SET fechadeshabilitacion=null WHERE id=6;

    SQL
  end
end
