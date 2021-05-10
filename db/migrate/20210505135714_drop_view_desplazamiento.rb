class DropViewDesplazamiento < ActiveRecord::Migration[6.1]
  def up
    execute "DROP VIEW IF EXISTS ultimodesplazamiento CASCADE"
  end
  def down
    execute "DROP VIEW IF EXISTS ultimodesplazamiento CASCADE"
  end
end
