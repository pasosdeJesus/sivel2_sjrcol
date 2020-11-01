class AgregaFincontratoAUsuario < ActiveRecord::Migration[6.0]
  def change
    add_column :usuario, :fincontrato, :date
  end
end
