class ActualizaEmah2021 < ActiveRecord::Migration[6.0]
  def up
    execute <<-SQL
      UPDATE heb412_gen_plantillahcm
        SET ruta='Plantillas/Registro_de_casos_atendidos_EMAH_V6.ods',
        nombremenu='Registro de casos atendidos EMAH'
        WHERE id=1;

      INSERT INTO heb412_gen_campoplantillahcm 
        (id, plantillahcm_id, nombrecampo, columna) VALUES
        (7, 1, 'rangoedad_ultimaatencion', 'G');

      UPDATE heb412_gen_campoplantillahcm 
        SET nombrecampo='ultimaatencion_' || nombrecampo WHERE id>=9 AND id<=20;

      UPDATE heb412_gen_campoplantillahcm SET columna='AG' WHERE id=26;
      UPDATE heb412_gen_campoplantillahcm SET columna='AF' WHERE id=25;
      UPDATE heb412_gen_campoplantillahcm SET columna='AE' WHERE id=24;
      UPDATE heb412_gen_campoplantillahcm SET columna='AC' WHERE id=23;
      UPDATE heb412_gen_campoplantillahcm SET columna='AB' WHERE id=22;
      UPDATE heb412_gen_campoplantillahcm SET columna='AA' WHERE id=21;

      INSERT INTO heb412_gen_campoplantillahcm 
        (id, plantillahcm_id, nombrecampo, columna) VALUES
        (2700, 1, 'ultimaatencion_beneficiarios_ss_0_5', 'U');
      INSERT INTO heb412_gen_campoplantillahcm 
        (id, plantillahcm_id, nombrecampo, columna) VALUES
        (2701, 1, 'ultimaatencion_beneficiarios_ss_6_12', 'V');
      INSERT INTO heb412_gen_campoplantillahcm 
        (id, plantillahcm_id, nombrecampo, columna) VALUES
        (2702, 1, 'ultimaatencion_beneficiarios_ss_13_17', 'W');
      INSERT INTO heb412_gen_campoplantillahcm 
        (id, plantillahcm_id, nombrecampo, columna) VALUES
        (2703, 1, 'ultimaatencion_beneficiarios_ss_18_26', 'X');
      INSERT INTO heb412_gen_campoplantillahcm 
        (id, plantillahcm_id, nombrecampo, columna) VALUES
        (2704, 1, 'ultimaatencion_beneficiarios_ss_27_59', 'Y');
      INSERT INTO heb412_gen_campoplantillahcm 
        (id, plantillahcm_id, nombrecampo, columna) VALUES
        (2705, 1, 'ultimaatencion_beneficiarios_ss_60_', 'Z');

      INSERT INTO heb412_gen_campoplantillahcm 
        (id, plantillahcm_id, nombrecampo, columna) VALUES
        (2720, 1, 'ultimaatencion_ac_juridica', 'AD');

      INSERT INTO heb412_gen_campoplantillahcm 
        (id, plantillahcm_id, nombrecampo, columna) VALUES
        (2721, 1, 'caso_id', 'AH');
      INSERT INTO heb412_gen_campoplantillahcm 
        (id, plantillahcm_id, nombrecampo, columna) VALUES
        (2722, 1, 'ultimaatencion_actividad_id', 'AI');
    SQL
  end
  def down
    execute <<-SQL
      DELETE FROM heb412_gen_campoplantillahcm WHERE id>=2720 AND id<=2722;
      DELETE FROM heb412_gen_campoplantillahcm WHERE id>=2700 AND id<=2705;

      UPDATE heb412_gen_campoplantillahcm SET columna='U' WHERE id=21;
      UPDATE heb412_gen_campoplantillahcm SET columna='V' WHERE id=22;
      UPDATE heb412_gen_campoplantillahcm SET columna='W' WHERE id=23;
      UPDATE heb412_gen_campoplantillahcm SET columna='X' WHERE id=24;
      UPDATE heb412_gen_campoplantillahcm SET columna='Y' WHERE id=25;
      UPDATE heb412_gen_campoplantillahcm SET columna='Z' WHERE id=26;

      UPDATE heb412_gen_campoplantillahcm 
        SET nombrecampo=SUBSTRING(nombrecampo, 16) WHERE id>=9 AND id<=20;

      DELETE FROM  heb412_gen_campoplantillahcm  WHERE id=7;

      UPDATE heb412_gen_plantillahcm
        SET ruta='Plantillas/Registro_de_casos_atendidos_EMAH_V4.ods',
        nombremenu='Registro de casos atendidos EMAH'
        WHERE id=1;
    SQL
  end
end
