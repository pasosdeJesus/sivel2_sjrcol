class AgregaDiscapacidadDatosbio < ActiveRecord::Migration[5.2]
  def change
    add_column :sip_datosbio, :discapacidad_id, :integer
    add_foreign_key :sip_datosbio, :discapacidad, column: :discapacidad_id
  end
end
