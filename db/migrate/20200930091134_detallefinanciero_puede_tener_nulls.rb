class DetallefinancieroPuedeTenerNulls < ActiveRecord::Migration[6.0]
  CAMPOS = [
      :proyectofinanciero_id, 
      :actividadpf_id,
      :unidadayuda_id,
      :mecanismodeentrega_id,
      :modalidadentrega_id,
      :tipotransferencia_id,
      :frecuenciaentrega_id,
      :cantidad,
      :valorunitario,
      :valortotal,
      :numeromeses,
      :numeroasistencia
    ]
  def up
    CAMPOS.each do |c|
      execute <<-SQL
        ALTER TABLE detallefinanciero ALTER COLUMN #{c} DROP NOT NULL;
      SQL
    end
  end
  def down
    CAMPOS.each do |c|
      execute <<-SQL
        ALTER TABLE detallefinanciero ALTER COLUMN #{c} SET NOT NULL;
      SQL
    end
  end
end
