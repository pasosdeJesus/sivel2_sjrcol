class RutaReportePersona < ActiveRecord::Migration[6.0]
  def up
    execute <<-SQL
      UPDATE heb412_gen_plantillahcr SET
        ruta='Plantillas/reporte_persona.ods'
        WHERE id='7';
    SQL
  end

  def down
    execute <<-SQL
      UPDATE heb412_gen_plantillahcr SET
        ruta='plantillas/reporte_persona.ods'
        WHERE id='7';
    SQL
  end
end
