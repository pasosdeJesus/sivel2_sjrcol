class CreateSectorgifmm < ActiveRecord::Migration[6.0]
  include Sip::MigracionHelper
  def up
    create_table :sectorgifmm do |t|
      t.string :nombre, limit: 500, null: false
      t.string :observaciones, limit: 5000
      t.date :fechacreacion, null: false
      t.date :fechadeshabilitacion
      t.timestamp :created_at, null: false
      t.timestamp :updated_at, null: false
    end
    cambiaCotejacion('sectorgifmm', 'nombre', 500, 'es_co_utf_8')
  end

  def down
    drop_table :sectorgifmm
  end
end
