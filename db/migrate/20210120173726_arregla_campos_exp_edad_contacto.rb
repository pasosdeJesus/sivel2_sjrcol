class ArreglaCamposExpEdadContacto < ActiveRecord::Migration[6.0]
  def up
    execute <<-SQL
      UPDATE heb412_gen_campoplantillahcm
        SET nombrecampo='contacto_rangoedad_ultimaatencion' WHERE
        nombrecampo IN ('rangoedad_ultimaatencion');
      UPDATE heb412_gen_campoplantillahcm
        SET nombrecampo='contacto_edad_ultimaatencion' WHERE
        nombrecampo IN ('edad_ultimaatencion');
      UPDATE heb412_gen_plantillahcm 
        SET nombremenu = 'Informacion de casos en recepción',
        ruta='Plantillas/Informacion_de_casos_en_recepcion.ods'
        WHERE id='47';
      UPDATE heb412_gen_plantillahcm 
        SET nombremenu = 'Informacion de casos en última atención',
        ruta='Plantillas/Informacion_de_casos_en_ultima_atencion.ods'
        WHERE id='1';
    SQL
  end
  def down
    execute <<-SQL
      UPDATE heb412_gen_plantillahcm 
        SET nombremenu = 'Informacion del caso durante recepción',
        ruta='Plantillas/InformacionCasoEnRecepcion.ods'
        WHERE id='47';
      UPDATE heb412_gen_plantillahcm 
        SET nombremenu = 'Registro de casos atendidos EMAH',
        ruta='Plantillas/Registro_de_casos_atendidos_EMAH_V6.ods'
        WHERE id='1';

      UPDATE heb412_gen_campoplantillahcm
        SET nombrecampo='rangoedad_ultimaatencion' WHERE
        nombrecampo IN ('contacto_rangoedad_ultimaatencion');
      UPDATE heb412_gen_campoplantillahcm
        SET nombrecampo='edad_ultimaatencion' WHERE
        nombrecampo IN ('contacto_edad_ultimaatencion');
    SQL
  end
end
