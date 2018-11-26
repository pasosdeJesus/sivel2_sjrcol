class RenombraOtraDiscapacidad < ActiveRecord::Migration[5.2]
  def change
    rename_column :sip_datosbio, :discapacidad, :otradiscapacidad
  end
end
