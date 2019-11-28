class AgregaUbicacionOficina < ActiveRecord::Migration[6.0]
  def change
    add_column :sip_oficina, :pais_id, :integer
    add_column :sip_oficina, :departamento_id, :integer
    add_column :sip_oficina, :municipio_id, :integer
    add_column :sip_oficina, :clase_id, :integer
    add_foreign_key :sip_oficina, :sip_pais, column: :pais_id
    add_foreign_key :sip_oficina, :sip_departamento, column: :departamento_id
    add_foreign_key :sip_oficina, :sip_municipio, column: :municipio_id
    add_foreign_key :sip_oficina, :sip_clase, column: :clase_id
  end
end
