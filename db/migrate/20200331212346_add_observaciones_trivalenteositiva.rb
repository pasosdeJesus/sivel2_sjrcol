class AddObservacionesTrivalenteositiva < ActiveRecord::Migration[6.0]
  def change
    add_column :trivalentepositiva, :observaciones, :string, limit: 5000
  end
end
