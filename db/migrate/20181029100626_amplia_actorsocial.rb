class AmpliaActorsocial < ActiveRecord::Migration[5.2]
  def change
    add_column :sip_actorsocial, :departamento_id, :integer
    add_column :sip_actorsocial, :municipio_id, :integer
    add_column :sip_actorsocial, :email, :string, limit: 128
    add_column :sip_actorsocial, :nit, :string, limit: 128
    add_foreign_key :sip_actorsocial, :sip_departamento, 
      column: :departamento_id
    add_foreign_key :sip_actorsocial, :sip_municipio, 
      column: :municipio_id
  end
end
