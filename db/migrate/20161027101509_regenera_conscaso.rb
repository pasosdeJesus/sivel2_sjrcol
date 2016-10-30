class RegeneraConscaso < ActiveRecord::Migration[5.0]
  def up
    execute <<-SQL
    DROP MATERIALIZED VIEW IF EXISTS sivel2_gen_conscaso;
    DROP VIEW IF EXISTS sivel2_gen_conscaso1;
    SQL
  end
  def down
    execute <<-SQL
    DROP MATERIALIZED VIEW IF EXISTS sivel2_gen_conscaso;
    DROP VIEW IF EXISTS sivel2_gen_conscaso1;
    SQL
  end
end
