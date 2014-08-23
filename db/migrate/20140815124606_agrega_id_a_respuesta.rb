class AgregaIdARespuesta < ActiveRecord::Migration
  def up
    execute <<-SQL
        CREATE SEQUENCE respuesta_seq;
        ALTER TABLE respuesta ADD COLUMN 
            id INTEGER NOT NULL UNIQUE DEFAULT(nextval('respuesta_seq'));
        DROP VIEW IF EXISTS cres1 CASCADE;
    SQL
    ['ayudaestado', 'ayudasjr', 'derecho', 'motivosjr', 'progestado'].each do |t|
      execute <<-SQL
        ALTER TABLE #{t}_respuesta ADD COLUMN 
            id_respuesta INTEGER REFERENCES respuesta(id);
        UPDATE #{t}_respuesta SET id_respuesta=id FROM respuesta
            WHERE #{t}_respuesta.id_caso=respuesta.id_caso 
            AND #{t}_respuesta.fechaatencion = respuesta.fechaatencion ;
        ALTER TABLE #{t}_respuesta DROP CONSTRAINT #{t}_respuesta_pkey;
        ALTER TABLE #{t}_respuesta ADD PRIMARY KEY (id_respuesta, id_#{t});
        ALTER TABLE #{t}_respuesta DROP COLUMN id_caso;
        ALTER TABLE #{t}_respuesta DROP COLUMN fechaatencion
      SQL
    end
    execute <<-SQL
        ALTER TABLE respuesta 
            DROP CONSTRAINT respuesta_pkey;
        ALTER TABLE respuesta ADD PRIMARY KEY (id)
    SQL
  end

  def down
    raise ActiveRecord::IrreversibleMigration    
  end
end
