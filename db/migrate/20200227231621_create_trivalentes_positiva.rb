class CreateTrivalentesPositiva < ActiveRecord::Migration[6.0]
  def up
    create_table :trivalentes_positiva do |t|
      t.string :nombre, limit: 100
      t.date :fechacreacion
      t.date :fechadeshabilitacion
      t.timestamp :created_at, null: false
      t.timestamp :updated_at, null: false
    end
    execute "ALTER SEQUENCE trivalentes_positiva_id_seq RENAME TO trivalentes_positiva_seq"
    execute <<-EOF
            INSERT INTO trivalentes_positiva (id, nombre, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (0, 'SIN INFORMACIÓN', '2020-02-27', NULL, '2020-02-27', '2020-02-27');
            INSERT INTO trivalentes_positiva (id, nombre, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (1, 'POSITIVA', '2020-02-27', NULL, '2020-02-27', '2020-02-27');
            INSERT INTO trivalentes_positiva (id, nombre, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (2, 'NEGATIVA', '2020-02-27', NULL, '2020-02-27', '2020-02-27');
    EOF
  end

  def down
    drop_table :trivalentes_positiva
  end
end
