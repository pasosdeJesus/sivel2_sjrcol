class LlenaTipoanexo < ActiveRecord::Migration[6.0]
  def up
    execute <<-SQL
      INSERT INTO sip_tipoanexo (id, nombre, fechacreacion, created_at, updated_at) 
        VALUES (1, 'ANEXO DE VICTIMA', '2016-03-08', '2016-03-08', '2016-03-18');
      INSERT INTO sip_tipoanexo (id, nombre, fechacreacion, created_at, updated_at) 
        VALUES (2, 'CONSENTIMIENTO DE DATOS', '2016-03-08', '2016-03-08', '2016-03-08');
    SQL
  end
  def down
    execute <<-SQL
      DELETE FROM sip_tipoanexo WHERE id>='1' AND id<='2';
    SQL
  end
end
