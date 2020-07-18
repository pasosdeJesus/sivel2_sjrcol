class AgregaPagoingresoAMigracion < ActiveRecord::Migration[6.0]
  def change
    add_column :sivel2_sjr_migracion, :pagoingreso_id, :integer, default: 1
    add_foreign_key :sivel2_sjr_migracion, :sip_trivalente, column: :pagoingreso_id
  end
end
