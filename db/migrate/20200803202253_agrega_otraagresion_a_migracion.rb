class AgregaOtraagresionAMigracion < ActiveRecord::Migration[6.0]
  def change
    add_column :sivel2_sjr_migracion, :otraagresion, :string
  end
end
