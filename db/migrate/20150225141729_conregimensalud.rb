class Conregimensalud < ActiveRecord::Migration
  def up
    execute <<-SQL
    ALTER TABLE sivel2_sjr_victimasjr 
        ADD CONSTRAINT victimasjr_id_regimensalud_fkey
        FOREIGN KEY (id_regimensalud) REFERENCES sivel2_sjr_regimensalud(id);
    SQL
  end
  def down
    execute <<-SQL
    ALTER TABLE sivel2_sjr_victimasjr 
        DROP CONSTRAINT victimasjr_id_regimensalud_fkey;
    SQL
  end
end
