class MejoraExpMigracion < ActiveRecord::Migration[6.1]
  def up
    p = Heb412Gen::Campoplantillahcm.find(308)
    p.nombrecampo = 'estatus_migratorio'
    p.save!
  end
  def down
    p = Heb412Gen::Campoplantillahcm.find(308)
    p.nombrecampo = 'statusmigratorio'
    p.save!
  end
end
