class DetallePersonaSinId < ActiveRecord::Migration[6.0]
  def up
    execute <<-SQL
      ALTER TABLE detallefinanciero_persona DROP COLUMN id; 
    SQL
  end
  def down
    execute <<-SQL
      ALTER TABLE detallefinanciero_persona ADD COLUMN id DEFAULT nextval('detallefinanciero_persona_id_seq'::regclass); 
    SQL
  end
end
