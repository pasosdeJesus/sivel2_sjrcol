class AgregaObservacionSectorsocial < ActiveRecord::Migration
  def change
    add_column :sivel2_gen_sectorsocial, :observaciones, :string, limit: 5000
  end
end
