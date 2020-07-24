class AgregaOtracausaAMigracion < ActiveRecord::Migration[6.0]
  def change
    add_column :sivel2_sjr_migracion, :otracausa, :string
  end
end
