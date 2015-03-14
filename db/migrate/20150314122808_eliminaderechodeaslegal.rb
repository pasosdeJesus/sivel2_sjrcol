class Eliminaderechodeaslegal < ActiveRecord::Migration
  def change
    remove_column :sivel2_sjr_aslegal, :derecho_id, :integer
  end
end
