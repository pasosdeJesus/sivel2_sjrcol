class AgregaDerechoAAslegal < ActiveRecord::Migration
  def up
    add_reference :aslegal, :derecho, index: true
    execute <<-SQL
        ALTER TABLE aslegal ADD
        CONSTRAINT fk_aslegal_derecho
        FOREIGN KEY (derecho_id)
        REFERENCES derecho(id)
    SQL
  end
  def down
    execute <<-SQL
        ALTER TABLE aslegal DROP CONSTRAINT fk_aslegal_derecho
    SQL
    remove_reference(:aslegal, :derecho, {:index=>true})
  end
end
