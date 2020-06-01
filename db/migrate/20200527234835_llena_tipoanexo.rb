class LlenaTipoanexo < ActiveRecord::Migration[6.0]
  def up
    execute <<-SQL
      INSERT INTO sip_tipoanexo (id, nombre, fechacreacion, created_at, updated_at) 
        VALUES (10, 'ANEXO DE VICTIMA', '2020-05-27', '2020-05-27', '2020-03-18');
      INSERT INTO sip_tipoanexo (id, nombre, fechacreacion, created_at, updated_at) 
        VALUES (11, 'CONSENTIMIENTO DE DATOS', '2020-05-27', '2020-05-27', '2020-05-27');
      INSERT INTO sip_tipoanexo (id, nombre, fechacreacion, created_at, updated_at)
        VALUES (12, 'OTRO', '2020-05-27', '2020-05-27', '2020-05-27');
    SQL
  end
  def down
    execute <<-SQL
      DELETE FROM sip_tipoanexo WHERE id>='10' AND id<='12';
    SQL
  end
end
