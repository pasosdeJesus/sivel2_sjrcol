class AgregaCausaRefugioASivel2SjrMigracion < ActiveRecord::Migration[6.0]
  def change
    add_column :sivel2_sjr_migracion, :causa_refugio_id, :integer
    add_foreign_key :sivel2_sjr_migracion, :sivel2_gen_categoria, column: :causa_refugio_id
  end
end
