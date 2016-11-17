class AceleraConscaso < ActiveRecord::Migration[5.0]
  def up
    execute <<-SQL
      CREATE UNIQUE index ON sivel2_sjr_casosjr(id_caso);
      CREATE INDEX ON sip_persona(tdocumento_id);
      CREATE UNIQUE index ON sivel2_gen_victima(id_caso, id_persona);
    SQL
  end
end
