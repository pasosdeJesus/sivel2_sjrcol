# encoding: utf-8

class QuitaAccionRepetida < ActiveRecord::Migration[5.1]
  def up
    execute <<-SQL
      DELETE FROM sivel2_sjr_accionjuridica WHERE id='17' AND nombre='APELACIÓN';
    SQL
  end

  def down
    execute <<-SQL
      INSERT INTO sivel2_sjr_accionjuridica (id, nombre, fechacreacion, created_at, updated_at)
        VALUES (17, 'APELACIÓN', '2017-08-29', '2017-08-29', '2017-08-29');
    SQL
  end
end
