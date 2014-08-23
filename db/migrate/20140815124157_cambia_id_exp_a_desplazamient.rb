class CambiaIdExpADesplazamient < ActiveRecord::Migration
  def change
    rename_column :desplazamiento, :expulsion, :id_expulsion
    rename_column :desplazamiento, :llegada, :id_llegada
  end
end
