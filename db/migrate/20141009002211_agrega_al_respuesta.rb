class AgregaAlRespuesta < ActiveRecord::Migration
  def change
    add_column :respuesta, :montoal, :integer
    add_column :respuesta, :detalleal, :string, limit: 5000
  end
end
