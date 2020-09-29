class CreateDetallefinancieroPersona < ActiveRecord::Migration[6.0]
  def change
    create_table :detallefinanciero_persona do |t|
      t.integer :detallefinanciero_id, null: false
      t.integer :persona_id
    end
    add_foreign_key :detallefinanciero_persona, :detallefinanciero
    add_foreign_key :detallefinanciero_persona, :sip_persona, 
      column: :persona_id
  end
end
