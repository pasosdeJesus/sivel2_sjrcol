class AgregaNombregifmmAFinanciador < ActiveRecord::Migration[6.0]
  def change
    add_column :cor1440_gen_financiador, :nombregifmm, :string, limit: 256
  end
end
