class AgregaOrdenUnidad < ActiveRecord::Migration[6.0]
  def up
    add_column :unidadayuda, :orden, :integer
    execute <<-SQL
      UPDATE unidadayuda SET orden=id;
    SQL
  end
  def down
    remove_column :unidadayuda, :orden
  end
end
