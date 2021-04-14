class AgregaDestinoubicacionpreADesplazamiento < ActiveRecord::Migration[6.1]
  def change
    add_column :sivel2_sjr_desplazamiento, :destinoubicacionpre_id, :integer
    add_foreign_key :sivel2_sjr_desplazamiento, :sip_ubicacionpre, 
      column: :destinoubicacionpre_id
  end
end
