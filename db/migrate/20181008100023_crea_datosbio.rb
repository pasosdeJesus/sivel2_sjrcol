class CreaDatosbio < ActiveRecord::Migration[5.2]
  def change
    create_table :sip_datosbio do |t|
      t.integer :persona_id
      t.date :fecharecoleccion, null: false
      t.integer :departamento_res_id
      t.integer :municipio_res_id
      t.string :vereda_res, limit: 1000
      t.string :direccion_res, limit: 1000
      t.string :telefono, limit: 100
      t.string :correo, limit: 100
      t.string :discapacidad, limit: 1000
      t.integer :cvulnerabilidad_id
      t.integer :escolaridad_id
      t.integer :anio_aprobacion
      t.integer :nivelsisben
      t.string :eps, limit: 1000
      t.string :tipocotizante, limit: 1 # 'C', 'B'
      t.boolean :sistemapensional
      t.boolean :afiliadoarl
      t.string :subsidioestado
      t.integer :personashogar
      t.integer :menores12acargo
      t.integer :mayores60acargo
      t.boolean :espaciopp
      t.string :nombreespaciopp, limit: 1000
      t.date :fechaingespaciopp
    end
    add_foreign_key :sip_datosbio, :sip_persona, column: :persona_id
    add_foreign_key :sip_datosbio, :sip_departamento, 
      column: :departamento_res_id
    add_foreign_key :sip_datosbio, :sip_municipio, column: :municipio_res_id
  end
end
