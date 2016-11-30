class IndiceContacto < ActiveRecord::Migration[5.0]
  def up
    execute <<-SQL
        CREATE UNIQUE INDEX sivel2_sjr_casosjr_contacto_idx ON sivel2_sjr_casosjr (contacto);
    SQL
  end
  def down
    execute <<-SQL
        DROP INDEX sivel2_sjr_casosjr_contacto_idx;
    SQL
  end
end
