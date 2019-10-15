class EliminaConsexpcasoEtniaNoNulo < ActiveRecord::Migration[6.0]
  def up
    execute <<-SQL
      DROP MATERIALIZED VIEW IF EXISTS sivel2_gen_consexpcaso;
    SQL
  end
end
