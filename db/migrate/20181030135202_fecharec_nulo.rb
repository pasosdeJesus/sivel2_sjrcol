class FecharecNulo < ActiveRecord::Migration[5.2]
  def change
    change_column :sip_datosbio, :fecharecoleccion, :date, :null => true
  end
end
