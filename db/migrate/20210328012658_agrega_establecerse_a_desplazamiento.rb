class AgregaEstablecerseADesplazamiento < ActiveRecord::Migration[6.1]
  def change
    add_column :sivel2_sjr_desplazamiento, :establecerse, :boolean
  end
end
