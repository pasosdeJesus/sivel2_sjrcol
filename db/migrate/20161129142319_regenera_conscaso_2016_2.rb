class RegeneraConscaso20162 < ActiveRecord::Migration[5.0]
  def up
    execute <<-SQL
    DROP VIEW IF EXISTS sivel2_sjr_ultimaatencion CASCADE;
    SQL
  end
  def down
    execute <<-SQL
    DROP VIEW IF EXISTS sivel2_sjr_ultimaatencion CASCADE;
    SQL
  end
end
