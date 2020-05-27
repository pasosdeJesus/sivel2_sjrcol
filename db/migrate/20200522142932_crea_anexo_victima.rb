class CreaAnexoVictima < ActiveRecord::Migration[6.0]
  def change
    create_table :sivel2_gen_anexo_victima do |t|
      t.integer :anexo_id
      t.integer :victima_id
      t.date :fecha
    end
    add_foreign_key :sivel2_gen_anexo_victima, 
      :sip_anexo, column: :anexo_id
    add_foreign_key :sivel2_gen_anexo_victima, 
      :sivel2_gen_victima, column: :victima_id
  end
end
