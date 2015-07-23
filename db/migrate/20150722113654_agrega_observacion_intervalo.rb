class AgregaObservacionIntervalo < ActiveRecord::Migration
  def change
    add_column :sivel2_gen_intervalo, :observaciones, :string, limit: 5000
  end
end
