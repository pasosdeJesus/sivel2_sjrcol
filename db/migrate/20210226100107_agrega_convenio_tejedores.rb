class AgregaConvenioTejedores < ActiveRecord::Migration[6.1]
  def up
    execute <<-SQL
      INSERT INTO cor1440_gen_beneficiariopf (persona_id, proyectofinanciero_id)
        (SELECT DISTINCT persona_id, 142 
          FROM cor1440_gen_caracterizacionpersona AS c
          JOIN mr519_gen_respuestafor AS r ON r.id=c.respuestafor_id
          WHERE formulario_id=101 AND
          persona_id NOT IN (SELECT persona_id FROM cor1440_gen_beneficiariopf
            WHERE proyectofinanciero_id=142));
    SQL
  end
  def down
  end
end
