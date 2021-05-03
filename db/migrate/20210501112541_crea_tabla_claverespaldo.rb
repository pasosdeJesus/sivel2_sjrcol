class CreaTablaClaverespaldo < ActiveRecord::Migration[6.1]
  def change
    create_table :sip_claverespaldo do |t|
      t.string :clave, null: false
      t.timestamps
    end
  end
end
