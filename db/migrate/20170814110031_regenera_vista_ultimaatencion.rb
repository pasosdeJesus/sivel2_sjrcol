class RegeneraVistaUltimaatencion < ActiveRecord::Migration[5.1]
  def up
    execute <<-SQL
    DROP VIEW sivel2_sjr_ultimaatencion CASCADE;
    SQL
  end
  def down
  end
end
