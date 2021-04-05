class AgregaMasdeclaraADesplazamiento < ActiveRecord::Migration[6.1]
  def change
    add_column :sivel2_sjr_desplazamiento, :fechadeclaro, :date
    add_column :sivel2_sjr_desplazamiento, :autoridaddeclaro, :string, limit: 5000
    add_column :sivel2_sjr_desplazamiento, :acreditacionestado, :string, limit: 5000
  end
end
