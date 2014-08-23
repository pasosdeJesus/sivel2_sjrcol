#encoding: UTF-8
class AgregaRefidVictima < ActiveRecord::Migration
  def up
    execute <<-SQL
        ALTER TABLE victimasjr 
            DROP CONSTRAINT IF EXISTS victimasjr_id_persona_fkey1;
        ALTER TABLE victimasjr ADD CONSTRAINT victima_fkey
            FOREIGN KEY (id_caso, id_persona) 
            REFERENCES victima(id_caso, id_persona);
        ALTER TABLE victimasjr ADD COLUMN id_victima INTEGER 
            REFERENCES victima(id);
        UPDATE victimasjr SET id_victima=victima.id FROM victima 
            WHERE victimasjr.id_persona=victima.id_persona 
            AND victimasjr.id_caso=victima.id_caso;
        ALTER TABLE victimasjr DROP CONSTRAINT victimasjr_pkey;
        ALTER TABLE victimasjr ADD CONSTRAINT victimasjr_pkey 
            PRIMARY KEY (id_victima);
        ALTER TABLE victimasjr DROP COLUMN id_persona;
        ALTER TABLE victimasjr DROP COLUMN id_caso;
   SQL
  end
  def down
    raise ActiveRecord::IrreversibleMigration    
  end
end
