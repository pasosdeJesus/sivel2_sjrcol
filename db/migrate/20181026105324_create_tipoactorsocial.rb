class CreateTipoactorsocial < ActiveRecord::Migration[5.2]
  def change
    create_table :sip_tipoactorsocial do |t|
      t.string :nombre, limit: 500, null: false
      t.string :observaciones, limit: 5000
      t.date :fechacreacion, null: false
      t.date :fechadeshabilitacion
      t.timestamp :created_at, null: false
      t.timestamp :updated_at, null: false
    end
  end
end
