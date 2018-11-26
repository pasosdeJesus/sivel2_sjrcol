class AsociaActorsocialTipoactorsocial < ActiveRecord::Migration[5.2]
  def change
    add_column :sip_actorsocial, :tipoactorsocial_id, :integer
    add_foreign_key :sip_actorsocial, :sip_tipoactorsocial, 
      column: :tipoactorsocial_id
  end
end
