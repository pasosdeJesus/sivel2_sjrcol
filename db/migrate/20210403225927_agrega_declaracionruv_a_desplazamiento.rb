class AgregaDeclaracionruvADesplazamiento < ActiveRecord::Migration[6.1]
  def change
    add_column :sivel2_sjr_desplazamiento, :declaracionruv_id, :integer
    add_foreign_key :sivel2_sjr_desplazamiento, :declaracionruv, column: :declaracionruv_id
  end
end
