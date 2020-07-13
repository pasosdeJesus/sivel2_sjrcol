class CreateCausamigracion < ActiveRecord::Migration[6.0]
  def change
    create_table :causamigracion do |t|
      t.string :nombre, limit: 500
      t.string :observaciones, limit: 5000
      t.date :fechacreacion
      t.date :fechadeshabilitacion
      t.timestamp :created_at
      t.timestamp :updated_at
    end
  end
end
