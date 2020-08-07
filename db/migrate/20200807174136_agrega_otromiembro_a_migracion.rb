class AgregaOtromiembroAMigracion < ActiveRecord::Migration[6.0]
  def change
    add_column :sivel2_sjr_migracion, :otromiembro, :string
  end
end
