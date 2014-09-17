class AgregaMontaarARespuesta < ActiveRecord::Migration
  def change
    add_column :respuesta, :montoar, :integer
  end
end
