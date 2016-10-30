class AgrupaCamposRespuesta < ActiveRecord::Migration[5.0]
  def up
    add_column :sivel2_sjr_respuesta, :descatencion, :string, limit: 5000
    execute <<-SQL
      CREATE OR REPLACE FUNCTION campointro(VARCHAR, VARCHAR) RETURNS VARCHAR
        AS  $$SELECT CASE 
               WHEN $2 IS NULL OR TRIM($2) = '' THEN '' 
               ELSE ' ' || $1 || ': ' || $2 
             END
        $$
        LANGUAGE SQL
        IMMUTABLE ;

      UPDATE sivel2_sjr_respuesta SET descatencion=TRIM(
        campointro('Descripción del caso', descamp) || 
        campointro('Compromisos de la persona', compromisos) || 
        campointro('Gestiones del SJR', gestionessjr) || 
        campointro('Recomendaciones', orientaciones) || 
        campointro('Observaciones del caso', observaciones) || 
        campointro('Remisión a otra Org.', remision) || 
        campointro('Verificación compromisos SJR', verifcsjr) || 
        campointro('Verificación compromisos persona', verifcper) || 
        campointro('Efectividad en la acción', efectividad)
      ) 
    SQL
  end
  def down
    remove_column :sivel2_sjr_respuesta, :descatencion
  end
end
