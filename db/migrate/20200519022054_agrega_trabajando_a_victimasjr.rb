class AgregaTrabajandoAVictimasjr < ActiveRecord::Migration[6.0]
  def change
    add_column :sivel2_sjr_victimasjr, :actualtrabajando, :boolean
  end
end
