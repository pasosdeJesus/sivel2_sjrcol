class ActualizaConscasoSepConsexp < ActiveRecord::Migration[5.1]
  def up
    execute <<-SQL
      DROP MATERIALIZED VIEW sivel2_gen_conscaso;
      DROP VIEW sivel2_gen_conscaso1;
    SQL
  end
  def down
  end
end
