class RenombraIdSeq3 < ActiveRecord::Migration
  @@tablas = [
      'ayudaestado',  
      'declaroante',  
      'derecho',  
      'motivosjr',  
      'progestado',  
      'regimensalud',  
  ]

  def up
    @@tablas.each do |t|
        execute <<-SQL
            ALTER SEQUENCE #{t + '_seq'}
                RENAME TO sivel2_sjr_#{t + '_id_seq'};
        SQL
    end
  end

  def down
    @@tablas.each do |t|
        execute <<-SQL
            ALTER SEQUENCE sivel2_sjr_#{t}_id_seq 
                RENAME TO #{t}_seq;
        SQL
    end
  end

end
