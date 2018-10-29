class AsociaActorsocialLineaactorsocial < ActiveRecord::Migration[5.2]
  def change
    add_column :sip_actorsocial, :lineaactorsocial_id, :integer
    add_foreign_key :sip_actorsocial, :sip_lineaactorsocial, 
      column: :lineaactorsocial_id
  end
end
