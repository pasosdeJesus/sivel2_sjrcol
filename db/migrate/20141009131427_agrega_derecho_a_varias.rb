class AgregaDerechoAVarias < ActiveRecord::Migration
  @@porc=["ayudaestado", "ayudasjr", "motivosjr", "progestado"]
  def change
    @@porc.each do |t|
      add_reference t.to_sym, :derecho, index: true
      execute <<-SQL
        ALTER TABLE #{t} ADD
        CONSTRAINT fk_#{t}_derecho
        FOREIGN KEY (derecho_id)
        REFERENCES derecho(id)
      SQL
    end
  end
  def down
    @@porc.each do |t|
      execute <<-SQL
        ALTER TABLE #{t} DROP CONSTRAINT fk_#{t}_derecho
      SQL
      remove_reference(t.to_sym, :derecho, {:index=>true})
    end
  end
end
