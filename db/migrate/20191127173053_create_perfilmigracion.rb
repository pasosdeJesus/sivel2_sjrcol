class CreatePerfilmigracion < ActiveRecord::Migration[6.0]
  def change
    create_table :perfilmigracion do |t|
      t.string :nombre, limit: 500, null: false
      t.string :observaciones, limit: 5000
      t.date :fechacreacion, null: false
      t.date :fechadeshabilitacion
      t.timestamp :created_at, null: false
      t.timestamp :updated_at, null: false
    end
    add_column :sivel2_sjr_migracion, :perfilmigracion_id, :integer
    add_foreign_key :sivel2_sjr_migracion, :perfilmigracion, column: :perfilmigracion_id
  end
end
