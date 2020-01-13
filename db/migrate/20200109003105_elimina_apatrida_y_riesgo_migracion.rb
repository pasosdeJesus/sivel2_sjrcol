class EliminaApatridaYRiesgoMigracion < ActiveRecord::Migration[6.0]
  def change
    remove_column :sivel2_sjr_migracion, :apatrida, :boolean
    remove_column :sivel2_sjr_migracion, :riesgoApatridia, :boolean
  end
end
