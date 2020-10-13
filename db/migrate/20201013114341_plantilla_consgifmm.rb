class PlantillaConsgifmm < ActiveRecord::Migration[6.0]
  def up
    execute <<-SQL
      UPDATE heb412_gen_plantillahcm SET vista='Consgifmm' WHERE id=43;
    SQL
  end

  def down
    execute <<-SQL
      UPDATE heb412_gen_plantillahcm SET vista='Actividad' WHERE id=43;
    SQL
  end
end
