class LlenaViadeingreso < ActiveRecord::Migration[6.0]
  def up
    execute <<-SQL
      INSERT INTO public.viadeingreso (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at) 
        VALUES (1, 'Puente oficial', null, '2020-07-11', null, '2020-07-11', '2020-07-11');
      INSERT INTO public.viadeingreso (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at) 
        VALUES (2, 'Trocha', null, '2020-07-11', null, '2020-07-11', '2020-07-11');
    SQL
  end

  def down
    execute <<-SQL
      DELETE FROM public.viadeingreso WHERE id>='1' AND id<='2'
    SQL
  end
end
