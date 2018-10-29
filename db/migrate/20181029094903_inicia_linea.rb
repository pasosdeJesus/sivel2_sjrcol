class IniciaLinea < ActiveRecord::Migration[5.2]
  def up
    execute <<-SQL
      INSERT INTO sip_lineaactorsocial(id, nombre, 
        fechacreacion, created_at, updated_at) VALUES (1, 'MEDIO AMBIENTE',
        '2018-10-29', '2018-10-29', '2018-10-29');
      INSERT INTO sip_lineaactorsocial(id, nombre, 
        fechacreacion, created_at, updated_at) VALUES (2, 'GENERO',
        '2018-10-29', '2018-10-29', '2018-10-29');
      INSERT INTO sip_lineaactorsocial(id, nombre, 
        fechacreacion, created_at, updated_at) VALUES (3, 'DESARROLLO ECONOMICO',
        '2018-10-29', '2018-10-29', '2018-10-29');
      INSERT INTO sip_lineaactorsocial(id, nombre, 
        fechacreacion, created_at, updated_at) VALUES (4, 'DERECHOS HUMANOS',
        '2018-10-29', '2018-10-29', '2018-10-29');
      INSERT INTO sip_lineaactorsocial(id, nombre, 
        fechacreacion, created_at, updated_at) VALUES (5, 'ESPIRITUALIDAD',
        '2018-10-29', '2018-10-29', '2018-10-29');
      INSERT INTO sip_lineaactorsocial(id, nombre, 
        fechacreacion, created_at, updated_at) VALUES (6, 'EDUCACIÓN',
        '2018-10-29', '2018-10-29', '2018-10-29');
      SELECT pg_catalog.setval('sip_lineaactorsocial_id_seq', 100, true);
    SQL
  end
  def down
    execute <<-SQL
      DELETE FROM sip_lineaactorsocial;
    SQL
  end
end
