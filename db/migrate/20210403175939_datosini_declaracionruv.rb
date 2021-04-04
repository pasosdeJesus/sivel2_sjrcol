class DatosiniDeclaracionruv < ActiveRecord::Migration[6.1]
  def up
    execute <<-SQL
      INSERT INTO declaracionruv (id, nombre, observaciones, fechacreacion, created_at, updated_at)    
        VALUES (1,'Si', '', '2021-04-04', '2021-04-04', '2021-04-04');
      INSERT INTO declaracionruv (id, nombre, observaciones, fechacreacion, created_at, updated_at)    
        VALUES (2,'No', '', '2021-04-04', '2021-04-04', '2021-04-04');
      INSERT INTO declaracionruv (id, nombre, observaciones, fechacreacion, created_at, updated_at)    
        VALUES (3,'No responde', '', '2021-04-04', '2021-04-04', '2021-04-04');
      INSERT INTO declaracionruv (id, nombre, observaciones, fechacreacion, created_at, updated_at)    
        VALUES (4,'En valoración', '', '2021-04-04', '2021-04-04', '2021-04-04');
        SELECT setval('declaracionruv_id_seq', 100);
    SQL
  end

  def down
    execute <<-SQL
      DELETE FROM declaracionruv WHERE id>=1 AND id<=4;
    SQL
  end
end
