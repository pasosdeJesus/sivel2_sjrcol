class AgregaPospresInclusion < ActiveRecord::Migration[6.1]
  def up
    add_column :sivel2_sjr_inclusion, :pospres, :integer
    execute <<-SQL
      UPDATE sivel2_sjr_inclusion 
        SET pospres='1' WHERE id='2';
      UPDATE sivel2_sjr_inclusion 
        SET pospres='2' WHERE id='3';
      UPDATE sivel2_sjr_inclusion 
        SET pospres='3' WHERE id='1';
      UPDATE sivel2_sjr_inclusion 
        SET pospres='4' WHERE id='4';
      UPDATE sivel2_sjr_inclusion 
        SET pospres='5' WHERE id='5';
    SQL
  end
  def down
    remove_column :sivel2_sjr_inclusion, :pospres, :integer
  end
end
