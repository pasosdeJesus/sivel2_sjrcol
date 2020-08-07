class AgregaAgresionenpaisAMigracion < ActiveRecord::Migration[6.0]
  def change
    create_table :sivel2_sjr_agreenpais_migracion, id: false do |t|
      t.integer :agreenpais_id
      t.integer :migracion_id
      t.index :agreenpais_id
      t.index :migracion_id
    end
    add_foreign_key :sivel2_sjr_agreenpais_migracion, 
      :agresionmigracion, column: :agreenpais_id
    add_foreign_key :sivel2_sjr_agreenpais_migracion, 
      :sivel2_sjr_migracion, column: :migracion_id
  end
end
