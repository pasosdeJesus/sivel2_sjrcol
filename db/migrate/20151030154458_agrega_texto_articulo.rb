class AgregaTextoArticulo < ActiveRecord::Migration
  def change
    add_column :sal7711_gen_articulo, :texto, :text
  end
end
