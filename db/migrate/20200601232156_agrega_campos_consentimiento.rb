class AgregaCamposConsentimiento < ActiveRecord::Migration[6.0]
  def up
    execute <<-SQL
      INSERT INTO heb412_gen_campoplantillahcr (id, plantillahcr_id, nombrecampo, columna, fila)
        VALUES (51, 11, 'contacto_nombres', 'B', 5);
      INSERT INTO heb412_gen_campoplantillahcr (id, plantillahcr_id, nombrecampo, columna, fila)
        VALUES (52, 11, 'contacto_identificacion', 'D', 5);
      INSERT INTO heb412_gen_campoplantillahcr (id, plantillahcr_id, nombrecampo, columna, fila)
        VALUES (53, 11, 'caso_id', 'E', 7);
      INSERT INTO heb412_gen_campoplantillahcr (id, plantillahcr_id, nombrecampo, columna, fila)
        VALUES (54, 11, 'contacto_nombres', 'B', 12);
      INSERT INTO heb412_gen_campoplantillahcr (id, plantillahcr_id, nombrecampo, columna, fila)
        VALUES (55, 11, 'contacto_identificacion', 'B', 13);
    SQL
  end

  def down
    execute <<-SQL
      DELETE FROM heb412_gen_campoplantillahcr WHERE id>='1' AND id<='5'
    SQL
  end
end
