class AgregaMemo1612 < ActiveRecord::Migration
  def change
    add_column :sivel2_sjr_casosjr, :memo1612, :string, limit: 5000
  end
end
