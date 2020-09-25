class AgregaIntersexualLgbt < ActiveRecord::Migration[6.0]
  def up
    execute <<-SQL
      ALTER TABLE sivel2_gen_victima DROP constraint 
        victima_orientacionsexual_check;
      ALTER TABLE sivel2_gen_victima ADD constraint 
        victima_orientacionsexual_check CHECK (
        orientacionsexual = 'L'::bpchar OR 
        orientacionsexual = 'G'::bpchar OR 
        orientacionsexual = 'B'::bpchar OR 
        orientacionsexual = 'T'::bpchar OR 
        orientacionsexual = 'H'::bpchar OR 
        orientacionsexual = 'S'::bpchar OR 
        orientacionsexual = 'I'::bpchar);
    SQL
  end

  def down
    execute <<-SQL
      ALTER TABLE sivel2_gen_victima DROP constraint 
        victima_orientacionsexual_check;
      ALTER TABLE sivel2_gen_victima ADD constraint 
        victima_orientacionsexual_check CHECK (
        orientacionsexual = 'L'::bpchar OR 
        orientacionsexual = 'G'::bpchar OR 
        orientacionsexual = 'B'::bpchar OR 
        orientacionsexual = 'T'::bpchar OR 
        orientacionsexual = 'H'::bpchar OR 
        orientacionsexual = 'S'::bpchar OR 
    SQL
  end

end
