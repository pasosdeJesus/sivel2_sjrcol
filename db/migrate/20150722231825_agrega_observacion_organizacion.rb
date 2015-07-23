class AgregaObservacionOrganizacion < ActiveRecord::Migration
  def change
    add_column :sivel2_gen_organizacion, :observaciones, :string, limit: 5000
  end
end
