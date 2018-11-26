class LlenaTipoactorsocial < ActiveRecord::Migration[5.2]
  def up
    execute <<-SQL
      INSERT INTO sip_tipoactorsocial(id, nombre, 
        fechacreacion, created_at, updated_at) VALUES (1, 'SIN INFORMACIÓN',
        '2018-10-29', '2018-10-29', '2018-10-29');
      INSERT INTO sip_tipoactorsocial(id, nombre, 
        fechacreacion, created_at, updated_at) VALUES (2, 'ONG',
        '2018-10-29', '2018-10-29', '2018-10-29');
      INSERT INTO sip_tipoactorsocial(id, nombre, 
        fechacreacion, created_at, updated_at) VALUES (3, 'ENTIDAD GUBERNAMENTAL',
        '2018-10-29', '2018-10-29', '2018-10-29');
      INSERT INTO sip_tipoactorsocial(id, nombre, 
        fechacreacion, created_at, updated_at) VALUES (4, 'FUNDACIÓN',
        '2018-10-29', '2018-10-29', '2018-10-29');
      INSERT INTO sip_tipoactorsocial(id, nombre, 
        fechacreacion, created_at, updated_at) VALUES (5, 'ORGANISMO DE COOPERACIÓN',
        '2018-10-29', '2018-10-29', '2018-10-29');
      INSERT INTO sip_tipoactorsocial(id, nombre, 
        fechacreacion, created_at, updated_at) VALUES (6, 'CANCILLERÍA',
        '2018-10-29', '2018-10-29', '2018-10-29');
      INSERT INTO sip_tipoactorsocial(id, nombre, 
        fechacreacion, created_at, updated_at) VALUES (7, 'EMBAJADA',
        '2018-10-29', '2018-10-29', '2018-10-29');
      INSERT INTO sip_tipoactorsocial(id, nombre, 
        fechacreacion, created_at, updated_at) VALUES (8, 'ORGANIZACIÓN SOCIAL',
        '2018-10-29', '2018-10-29', '2018-10-29');
      INSERT INTO sip_tipoactorsocial(id, nombre, 
        fechacreacion, created_at, updated_at) VALUES (9, 'INSTITUCIÓN EDUCATIVA',
        '2018-10-29', '2018-10-29', '2018-10-29');

      SELECT pg_catalog.setval('sip_tipoactorsocial_id_seq', 100, true);
    SQL
  end
  def down
    execute <<-SQL
      DELETE FROM sip_tipoactorsocial;
    SQL
  end
end
