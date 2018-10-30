class IniciaPoblacionRelacionada < ActiveRecord::Migration[5.2]
  def up
    execute <<-SQL
      INSERT INTO sip_sectoractor (id, nombre, fechacreacion, 
        created_at, updated_at) VALUES ( 5, 'NNAJ', 
        '2018-10-30', '2018-10-30', '2018-10-30');
      INSERT INTO sip_sectoractor (id, nombre, fechacreacion, 
        created_at, updated_at) VALUES ( 6, 'AFRODESCENDIENTES', 
        '2018-10-30', '2018-10-30', '2018-10-30');
      INSERT INTO sip_sectoractor (id, nombre, fechacreacion, 
        created_at, updated_at) VALUES (7, 'CONDICIÓN DE DISCAPACIDAD', 
        '2018-10-30', '2018-10-30', '2018-10-30');
      INSERT INTO sip_sectoractor (id, nombre, fechacreacion, 
        created_at, updated_at) VALUES (8, 'LGBTIQ', 
        '2018-10-30', '2018-10-30', '2018-10-30');
      INSERT INTO sip_sectoractor (id, nombre, fechacreacion, 
        created_at, updated_at) VALUES (9, 'POBLACIÓN URBANA', 
        '2018-10-30', '2018-10-30', '2018-10-30');
    SQL
  end
  def down
    execute <<-SQL
      DELETE FROM sip_sectoractor WHERE id>='5' AND id<='9';
    SQL
  end
end
