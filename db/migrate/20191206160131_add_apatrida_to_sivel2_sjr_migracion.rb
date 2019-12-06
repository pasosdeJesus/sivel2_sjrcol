class AddApatridaToSivel2SjrMigracion < ActiveRecord::Migration[6.0]
  def change
    add_column :sivel2_sjr_migracion, :apatrida, :boolean
  end
end
