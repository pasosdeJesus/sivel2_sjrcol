class EstatusPorDefecto < ActiveRecord::Migration
  def up
    execute <<-SQL
        ALTER TABLE sivel2_sjr_casosjr ALTER COLUMN id_statusmigratorio SET DEFAULT 0;
        UPDATE sivel2_sjr_casosjr SET id_statusmigratorio='0' WHERE id_statusmigratorio IS NULL;
    SQL
  end
  def down
    execute <<-SQL
        ALTER TABLE sivel2_sjr_casosjr ALTER COLUMN id_statusmigratorio SET DEFAULT NULL;
    SQL
  end
end
