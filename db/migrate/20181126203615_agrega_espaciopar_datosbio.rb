class AgregaEspacioparDatosbio < ActiveRecord::Migration[5.2]
  def change
    add_column :sip_datosbio, :espaciopart_id, :integer
    add_foreign_key :sip_datosbio, :espaciopart, column: :espaciopart_id
  end
end
