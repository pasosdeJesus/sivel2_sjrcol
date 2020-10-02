class CreaReporteGifmm < ActiveRecord::Migration[6.0]
  def up
    execute <<-SQL
      INSERT INTO public.heb412_gen_plantillahcm (id, ruta, fuente, licencia, vista, nombremenu, filainicial) VALUES (43, 'Plantillas/GIFMM-v1.ods', 'GIFMM', '', 'Actividad', 'GIFMM-v1', 5);
      
      
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (430, 43, 'socio_principal', 'A');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (431, 43, 'tipo_implementacion', 'B');
      --432 C
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (433, 43, 'departamento', 'D');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (434, 43, 'municipio', 'E');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (435, 43, 'mes', 'F');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (436, 43, 'estado', 'G');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (437, 43, 'parte_rmrp', 'H');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (438, 43, 'covid19', 'I');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (439, 43, 'sector_gifmm', 'J');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (440, 43, 'indicador_gifmm', 'K');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (441, 43, 'objetivo', 'L');
      --442 M
      --443 N
      --444 O
      --445 P
      --446 Q
      --447 R
      --448 S
      --449 T
      --450 U
      --451 V
      --452 W
      --453 X
      --454 Y
      --455 Z
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (456, 43, 'beneficiarios_com_acogida', 'AA');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (457, 43, 'poblacion_mujeres_r', 'AB');
      --458 AC
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (459, 43, 'poblacion_mujeres_r_g1', 'AD');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (460, 43, 'poblacion_mujeres_r_g2', 'AE');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (461, 43, 'poblacion_mujeres_r_g3', 'AF');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (462, 43, 'poblacion_mujeres_r_g4', 'AG');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (463, 43, 'poblacion_mujeres_r_g5', 'AH');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (464, 43, 'poblacion_hombres_r', 'AI');
      --485 AJ
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (465, 43, 'poblacion_hombres_r_g1', 'AK');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (466, 43, 'poblacion_hombres_r_g2', 'AL');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (467, 43, 'poblacion_hombres_r_g3', 'AM');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (468, 43, 'poblacion_hombres_r_g4', 'AN');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (469, 43, 'poblacion_hombres_r_g5', 'AO');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (470, 43, 'poblacion_hombres_r_g6', 'AP');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (471, 43, 'poblacion_mujeres_r_g6', 'AQ');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (472, 43, 'num_lgbti', 'AR');
      --473 S
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (474, 43, 'num_afrodescendientes', 'AT');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (475, 43, 'num_indigenas', 'AU');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (476, 43, 'num_otra_etnia', 'AV');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (477, 43, 'observaciones', 'AW');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (478, 43, 'id', 'AX');
      --479 AY
      --480 AZ
    SQL
  end

  def down
    execute <<-SQL
      DELETE FROM heb412_gen_campoplantillahcm WHERE id>='430' AND id<='480';
      DELETE FROM heb412_gen_plantillahcm WHERE id='43';
    SQL
  end
end
