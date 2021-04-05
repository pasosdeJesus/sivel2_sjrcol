class AgregaAnexosADesplazamiento < ActiveRecord::Migration[6.1]
  def up
    create_table :sivel2_sjr_anexo_desplazamiento do |t|
      t.date :fecha
      t.integer :desplazamiento_id, null: false
      t.integer :anexo_id, null: false
      t.timestamp :created_at, null: false
      t.timestamp :updated_at, null: false
    end
    add_foreign_key :sivel2_sjr_anexo_desplazamiento, :sivel2_sjr_desplazamiento, column: :desplazamiento_id
    add_foreign_key :sivel2_sjr_anexo_desplazamiento, :sip_anexo, column: :anexo_id
  end

  def down
    drop_table :sivel2_sjr_anexo_desplazamiento
  end
end
