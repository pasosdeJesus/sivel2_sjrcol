class AgregaUbipreADesplazamiento < ActiveRecord::Migration[6.1]
  def change
    add_column :sivel2_sjr_desplazamiento, :expulsionubicacionpre_id, :integer
    add_foreign_key :sivel2_sjr_desplazamiento, :sip_ubicacionpre, column: :expulsionubicacionpre_id
    add_column :sivel2_sjr_desplazamiento, :llegadaubicacionpre_id, :integer
    add_foreign_key :sivel2_sjr_desplazamiento, :sip_ubicacionpre, column: :llegadaubicacionpre_id
  end
end
