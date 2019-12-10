class AgregaCausaRefugioASivel2SjrMigracion < ActiveRecord::Migration[6.0]
  def change
    add_column :sivel2_sjr_migracion, :causaRefugio_id, :integer
    add_foreign_key :sivel2_sjr_migracion, :sivel2_gen_categoria, 
      column: :causaRefugio_id
  end
end
