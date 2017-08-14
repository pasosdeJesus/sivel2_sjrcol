class RegeneraVistaUltimaatencion < ActiveRecord::Migration[5.1]
  def up
    execute <<-SQL
    DROP MATERIALIZED VIEW sivel2_gen_consexpcaso CASCADE;
    DROP MATERIALIZED VIEW sivel2_gen_conscaso CASCADE;
    DROP VIEW sivel2_gen_conscaso1 CASCADE;
    DROP VIEW sivel2_sjr_ultimaatencion CASCADE;
    SQL
  end
  def down
  end
end
