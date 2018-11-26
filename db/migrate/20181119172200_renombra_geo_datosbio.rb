class RenombraGeoDatosbio < ActiveRecord::Migration[5.2]
  def change
    rename_column :sip_datosbio, :departamentores_id, :res_departamento_id
    rename_column :sip_datosbio, :municipiores_id, :res_municipio_id
  end
end
