class AgregaUrlArticulo < ActiveRecord::Migration
  def change
    add_column :sal7711_gen_articulo, :url, :string, limit: 5000
  end
end
