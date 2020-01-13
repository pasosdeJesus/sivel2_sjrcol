class EliminaNpiBooleano < ActiveRecord::Migration[6.0]
  def change
    remove_column :sivel2_sjr_migracion, :npi
  end
end
