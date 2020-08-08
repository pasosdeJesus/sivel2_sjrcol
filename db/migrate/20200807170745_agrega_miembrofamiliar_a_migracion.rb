class AgregaMiembrofamiliarAMigracion < ActiveRecord::Migration[6.0]
  def change
    add_column :sivel2_sjr_migracion, :miembrofamiliar_id, :integer
    add_foreign_key :sivel2_sjr_migracion, :miembrofamiliar, column: :miembrofamiliar_id
  end
end
