class MasIndicesRespuesta < ActiveRecord::Migration[5.0]
  def up
    execute <<-SQL
        CREATE UNIQUE INDEX sivel2_sjr_respuesta_id_caso_fechaatencion_idx ON sivel2_sjr_respuesta (id_caso, fechaatencion);
    SQL
  end
  def down
    execute <<-SQL
        DROP INDEX sivel2_sjr_respuesta_id_caso_fechaatencion_idx ;
    SQL
  end
end
