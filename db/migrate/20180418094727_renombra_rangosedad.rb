class RenombraRangosedad < ActiveRecord::Migration[5.2]
  def up
    execute <<-SQL
      UPDATE sivel2_gen_rangoedad SET nombre=rango;
    SQL
  end
  def down
  end
end
