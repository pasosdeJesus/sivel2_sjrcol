class AgregaDiscapacidadAVictima < ActiveRecord::Migration[6.0]
  def change
    add_column :sivel2_sjr_victimasjr, :discapacidad_id, :integer
    add_foreign_key :sivel2_sjr_victimasjr, :discapacidad, column: :discapacidad_id
  end
end
