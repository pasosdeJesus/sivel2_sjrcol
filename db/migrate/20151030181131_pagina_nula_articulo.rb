class PaginaNulaArticulo < ActiveRecord::Migration
  def up
    execute <<-SQL
      ALTER TABLE sal7711_gen_articulo ALTER COLUMN pagina DROP NOT NULL;
    SQL
  end
  def down
    execute <<-SQL
      ALTER TABLE sal7711_gen_articulo ALTER COLUMN pagina SET NOT NULL;
    SQL
  end

end
