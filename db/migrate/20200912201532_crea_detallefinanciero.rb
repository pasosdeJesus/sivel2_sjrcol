class CreaDetallefinanciero < ActiveRecord::Migration[6.0]
  def up
    create_table :detallefinanciero do |t|
      t.integer :actividad_id, null: false
      t.integer :proyectofinanciero_id, null: false
      t.integer :actividadpf_id, null: false
      t.integer :unidadayuda_id, null: false
      t.integer :cantidad, null: false
      t.integer :valorunitario, null: false
      t.integer :valortotal, null: false
      t.integer :mecanismodeentrega_id, null: false
      t.integer :modalidadentrega_id, null: false
      t.integer :tipotransferencia_id, null: false
      t.integer :frecuenciaentrega_id, null: false
      t.integer :numeromeses, null: false
      t.integer :numeroasistencia, null: false
      t.timestamp :created_at, null: false
      t.timestamp :updated_at, null: false
    end
    add_foreign_key :detallefinanciero, :cor1440_gen_actividad, column: :actividad_id
    add_foreign_key :detallefinanciero, :cor1440_gen_proyectofinanciero, column: :proyectofinanciero_id
    add_foreign_key :detallefinanciero, :cor1440_gen_actividadpf, column: :actividadpf_id
    add_foreign_key :detallefinanciero, :unidadayuda, column: :unidadayuda_id
    add_foreign_key :detallefinanciero, :mecanismodeentrega, column: :mecanismodeentrega_id
    add_foreign_key :detallefinanciero, :modalidadentrega, column: :modalidadentrega_id
    add_foreign_key :detallefinanciero, :tipotransferencia, column: :tipotransferencia_id
    add_foreign_key :detallefinanciero, :frecuenciaentrega, column: :frecuenciaentrega_id
  end

  def down
    drop_table :detallefinanciero
  end
end
