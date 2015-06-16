class AgregaObservacionesSjrcol < ActiveRecord::Migration
  def change

    add_column :sivel2_gen_filiacion, :observaciones, :string, limit: 5000
    add_column :sivel2_gen_vinculoestado, :observaciones, :string, limit: 5000
    add_column :sivel2_sjr_regimensalud, :observaciones, :string, limit: 5000
  end
end
