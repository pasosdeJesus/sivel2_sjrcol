class PrimariaTdocumentoSiFalta < ActiveRecord::Migration[6.0]
  def up
    r=execute "SELECT * FROM information_schema.table_constraints " +
      "WHERE table_name='sip_tdocumento' AND constraint_type='PRIMARY KEY'"
    if r.count == 0
      execute <<-SQL
        ALTER TABLE sip_tdocumento ADD PRIMARY KEY (id);
      SQL
    end
  end
  def down
  end
end
