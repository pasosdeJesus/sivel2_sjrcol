class ActualizaNombreCampo < ActiveRecord::Migration[6.0]
  def up
    execute <<-SQL
      UPDATE heb412_gen_campoplantillahcm
        SET nombrecampo='ultimaatencion_objetivo'
        WHERE nombrecampo='ultimaatencion_descripcion_at';

      UPDATE heb412_gen_campoplantillahcm
        SET nombrecampo='statusmigratorio'
        WHERE nombrecampo='estatus_migratorio';

    SQL
  end
  def down
    execute <<-SQL

      UPDATE heb412_gen_campoplantillahcm
        SET nombrecampo='ultimaatencion_descripcion_at'
        WHERE nombrecampo='ultimaatencion_objetivo';


      UPDATE heb412_gen_campoplantillahcm
        SET nombrecampo='estatus_migratorio'
        WHERE nombrecampo='statusmigratorio';
    SQL
  end
end
