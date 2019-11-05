class CreaMigracion < ActiveRecord::Migration[6.0]
  def change
    create_table :sivel2_sjr_migracion do |t|
      t.integer :caso_id, null: false
      t.date :fechasalida, null: false
      t.date :fechallegada
      t.integer :salida_pais_id
      t.integer :salida_departamento_id
      t.integer :salida_municipio_id
      t.integer :salida_clase_id
      t.integer :llegada_pais_id
      t.integer :llegada_departamento_id
      t.integer :llegada_municipio_id
      t.integer :llegada_clase_id
      t.boolean :se_establece_en_sitio_llegada
      t.integer :destino_pais_id
      t.integer :destino_departamento_id
      t.integer :destino_municipio_id
      t.integer :destino_clase_id
  end
    add_foreign_key :sivel2_sjr_migracion, :sivel2_gen_caso, column: :caso_id
    add_foreign_key :sivel2_sjr_migracion, :sip_pais, column: :salida_pais_id
    add_foreign_key :sivel2_sjr_migracion, :sip_departamento, column: :salida_departamento_id
    add_foreign_key :sivel2_sjr_migracion, :sip_municipio, column: :salida_municipio_id
    add_foreign_key :sivel2_sjr_migracion, :sip_clase, column: :salida_clase_id
    add_foreign_key :sivel2_sjr_migracion, :sip_pais, column: :llegada_pais_id
    add_foreign_key :sivel2_sjr_migracion, :sip_departamento, column: :llegada_departamento_id
    add_foreign_key :sivel2_sjr_migracion, :sip_municipio, column: :llegada_municipio_id
    add_foreign_key :sivel2_sjr_migracion, :sip_clase, column: :llegada_clase_id
    add_foreign_key :sivel2_sjr_migracion, :sip_pais, column: :destino_pais_id
    add_foreign_key :sivel2_sjr_migracion, :sip_departamento, column: :destino_departamento_id
    add_foreign_key :sivel2_sjr_migracion, :sip_municipio, column: :destino_municipio_id
    add_foreign_key :sivel2_sjr_migracion, :sip_clase, column: :destino_clase_id
  end
end
