class RenombraCamposDatosbio < ActiveRecord::Migration[5.2]
  def change
    rename_column :sip_datosbio, :departamento_res_id, :departamentores_id
    rename_column :sip_datosbio, :municipio_res_id, :municipiores_id
    rename_column :sip_datosbio, :vereda_res, :veredares
    rename_column :sip_datosbio, :direccion_res, :direccionres
    rename_column :sip_datosbio, :anio_aprobacion, :anioaprobacion
  end
end
