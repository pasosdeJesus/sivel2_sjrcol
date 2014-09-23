#encoding: UTF-8
class CambiaCasosjrComosupo < ActiveRecord::Migration
  def up
    execute <<-SQL
DO $$ 
  BEGIN
    BEGIN
      ALTER TABLE casosjr ADD COLUMN comosupo VARCHAR(5000);
    EXCEPTION
      WHEN duplicate_column THEN 
        RAISE NOTICE 'Ya existia columna comosupo en casosjr';
    END;
  END;
$$
    SQL
    execute "ALTER TABLE casosjr RENAME COLUMN comosupo TO detcomosupo"
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
