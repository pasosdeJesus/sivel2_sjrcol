class DropViewDesplazamiento < ActiveRecord::Migration[6.1]
  def change
    execute "DROP VIEW ultimodesplazamiento CASCADE"
  end
end
