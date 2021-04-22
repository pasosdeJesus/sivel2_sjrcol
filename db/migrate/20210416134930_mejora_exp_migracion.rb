class MejoraExpMigracion < ActiveRecord::Migration[6.1]
  def up
    p = Heb412Gen::Campoplantillahcm.where(id: 308)
    if !p.empty?
      p[0].nombrecampo = 'estatus_migratorio'
      p[0].save!
    end
  end
  def down
    p = Heb412Gen::Campoplantillahcm.where(id: 308)
    if !p.empty?
      p[0].nombrecampo = 'statusmigratorio'
      p[0].save!
    end
  end
end
