class HomologaActividadActividadpf < ActiveRecord::Migration[5.2]
  def up
    execute <<-SQL
      INSERT INTO cor1440_gen_actividad_proyectofinanciero (actividad_id, proyectofinanciero_id) (SELECT DISTINCT actividad_id, 10 FROM cor1440_gen_actividad_actividadtipo);
      INSERT INTO cor1440_gen_actividad_actividadpf (actividad_id, actividadpf_id) (SELECT actividad_id, actividadtipo_id+50 FROM cor1440_gen_actividad_actividadtipo);
    SQL
  end
  def down
    execute <<-SQL
      DELETE FROM cor1440_gen_actividad_actividadpf WHERE (actividad_id, actividadpf_id) IN (SELECT actividad_id, actividadtipo_id+50 FROM cor1440_gen_actividad_actividadtipo);
      DELETE FROM cor1440_gen_actividad_proyectofinanciero WHERE (actividad_id, proyectofinanciero_id) IN (SELECT actividad_id, 10 FROM cor1440_gen_actividad_actividadtipo);
    SQL
  end
end
