class AgregaPlantillaConsentimiento < ActiveRecord::Migration[6.0]
  def up
    execute <<-SQL
      INSERT INTO heb412_gen_plantillahcr (id, ruta, fuente, licencia, vista, nombremenu) 
        VALUES (10, 'Plantillas/borrador_consentimiento_informado_JRS_Colombia.ods', '', '', 'Caso', 'Consentimiento de Tratamiento de Datos');
    SQL
  end
  def down
    execute <<-SQL
      DELETE FROM heb412_gen_plantillahcr WHERE id='10';
    SQL
  end
end
