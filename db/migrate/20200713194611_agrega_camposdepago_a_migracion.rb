class AgregaCamposdepagoAMigracion < ActiveRecord::Migration[6.0]
  def change
    add_column :sivel2_sjr_migracion, :valor_pago, :string
    add_column :sivel2_sjr_migracion, :concepto_pago, :string
    add_column :sivel2_sjr_migracion, :actor_pago, :string
  end
end
