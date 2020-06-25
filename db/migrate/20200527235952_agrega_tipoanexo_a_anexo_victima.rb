class AgregaTipoanexoAAnexoVictima < ActiveRecord::Migration[6.0]
  def change
    add_column :sivel2_gen_anexo_victima, :tipoanexo_id, :integer
    add_foreign_key :sivel2_gen_anexo_victima, :sip_tipoanexo, column: :tipoanexo_id
  end
end
