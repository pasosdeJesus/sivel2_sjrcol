class SimplificaInclusion < ActiveRecord::Migration[6.1]
  def up
    execute <<-SQL
      -- Convierte SIN INFORMACIÓN en SIN RESPUESTA
      UPDATE sivel2_sjr_desplazamiento 
        SET id_inclusion=1 WHERE id_inclusion=0; 
      -- Deshabilita SIN INFORMACIÓN 
      UPDATE sivel2_sjr_inclusion 
        SET fechadeshabilitacion='2021-04-06' WHERE id=0;
      ALTER TABLE sivel2_sjr_desplazamiento
        ALTER COLUMN id_inclusion
        SET DEFAULT '1';
    SQL
  end

  def down
    puts "Este retorno es parcial. No se logran restaurar las inclusiones"\
      " SIN INFORMACION"
    execute <<-SQL
      ALTER TABLE sivel2_sjr_desplazamiento
        ALTER COLUMN id_inclusion
        SET DEFAULT '0';
      UPDATE sivel2_sjr_inclusion 
        SET fechadeshabilitacion=NULL WHERE id=0;
    SQL
  end
end
