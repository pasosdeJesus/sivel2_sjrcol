class CreateSivel2SjrAccionjuridicaRespuesta < ActiveRecord::Migration[5.1]
  def change
    create_table :sivel2_sjr_accionjuridica_respuesta do |t|
      t.integer :accionjuridica_id, null: false
      t.integer :respuesta_id, null: false
      t.boolean :favorable
    end
    add_foreign_key :sivel2_sjr_accionjuridica_respuesta,
      :sivel2_sjr_accionjuridica, column: :accionjuridica_id
    add_foreign_key :sivel2_sjr_accionjuridica_respuesta,
      :sivel2_sjr_respuesta, column: :respuesta_id
  end
end
