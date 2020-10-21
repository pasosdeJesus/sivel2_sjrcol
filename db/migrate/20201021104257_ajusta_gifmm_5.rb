class AjustaGifmm5 < ActiveRecord::Migration[6.0]
  def up
    execute <<-SQL
      UPDATE heb412_gen_campoplantillahcm SET
        nombrecampo='departamento_gifmm'  -- antes departamento_altas_bajas
        WHERE id=433;
      UPDATE heb412_gen_campoplantillahcm SET
        nombrecampo='municipio_gifmm'  -- antes municipio_altas_bajas
        WHERE id=434;
      UPDATE heb412_gen_campoplantillahcm SET
        nombrecampo='beneficiarios_nuevos_en_transito'  -- antes poblacion_transito
        WHERE id=453;
      UPDATE heb412_gen_campoplantillahcm SET
        nombrecampo='beneficiarios_nuevos_pendulares'  -- antes poblacion_pendulares
        WHERE id=454;
      UPDATE heb412_gen_campoplantillahcm SET
        nombrecampo='beneficiarios_nuevos_colombianos_retornados'  -- antes poblacion_colombianos_retornados
        WHERE id=455;
      DELETE FROM heb412_gen_campoplantillahcm
        WHERE plantillahcm_id=43 AND length(columna) >=2 AND columna>='BA';
      UPDATE heb412_gen_campoplantillahcm SET
        nombrecampo='beneficiarios_nuevos_comunidades_de_acogida'  -- antes poblacion_com_acogida
        WHERE id=456;
      UPDATE heb412_gen_campoplantillahcm SET
        nombrecampo='beneficiarias_nuevas_niñas_adolescentes_y_se'  -- antes poblacion_com_acogida
        WHERE id=457;
      UPDATE heb412_gen_campoplantillahcm SET
        nombrecampo='beneficiarias_nuevas_mujeres_adultas'  -- antes poblacion_mujeres_adultas
        WHERE id=458;
      UPDATE heb412_gen_campoplantillahcm SET
        nombrecampo='beneficiarias_nuevas_mujeres_0_5'  -- antes poblacion_mujeres_r_g1
        WHERE id=459;
      UPDATE heb412_gen_campoplantillahcm SET
        nombrecampo='beneficiarias_nuevas_mujeres_6_12'  -- antes poblacion_mujeres_r_g2
        WHERE id=460;
      UPDATE heb412_gen_campoplantillahcm SET
        nombrecampo='beneficiarias_nuevas_mujeres_13_17'  -- antes poblacion_mujeres_r_g3
        WHERE id=461;
      UPDATE heb412_gen_campoplantillahcm SET
        nombrecampo='beneficiarias_nuevas_mujeres_18_59'  -- antes poblacion_mujeres_r_g_4_5
        WHERE id=462;
      UPDATE heb412_gen_campoplantillahcm SET
        nombrecampo='beneficiarias_nuevas_mujeres_60_o_mas'  -- antes poblacion_mujeres_r_g6
        WHERE id=463;
      UPDATE heb412_gen_campoplantillahcm SET
        nombrecampo='beneficiarios_nuevos_niños_adolescentes_y_se'  -- antes poblacion_niños_adolescentes_y_se
        WHERE id=464;
      UPDATE heb412_gen_campoplantillahcm SET
        nombrecampo='beneficiarios_nuevos_hombres_adultos',  -- antes poblacion_hombres_r_g1
        columna='AJ'
        WHERE id=465;
      UPDATE heb412_gen_campoplantillahcm SET
        nombrecampo='beneficiarios_nuevos_hombres_0_5',  -- antes poblacion_hombres_r_g2
        columna='AK'
        WHERE id=466;
      UPDATE heb412_gen_campoplantillahcm SET
        nombrecampo='beneficiarios_nuevos_hombres_6_12',  -- antes poblacion_hombres_r_g3
        columna='AL'
        WHERE id=467;
      UPDATE heb412_gen_campoplantillahcm SET
        nombrecampo='beneficiarios_nuevos_hombres_13_17',  -- antes poblacion_hombres_r_g_4_5
        columna='AM'
        WHERE id=468;
      UPDATE heb412_gen_campoplantillahcm SET
        nombrecampo='beneficiarios_nuevos_hombres_18_59',  -- antes poblacion_hombres_r_g6
        columna='AN'
        WHERE id=469;
      UPDATE heb412_gen_campoplantillahcm SET
        nombrecampo='beneficiarios_nuevos_hombres_60_o_mas',  -- antes poblacion_sinsexo_adultos
        columna='AO'
        WHERE id=470;
      UPDATE heb412_gen_campoplantillahcm SET
        nombrecampo='beneficiarios_nuevos_sinsexo_menores_y_se',  -- antes poblacion_sinsexo_menores
        columna='AP'
        WHERE id=471;
      UPDATE heb412_gen_campoplantillahcm SET
        nombrecampo='beneficiarios_nuevos_sinsexo_adultos',  -- antes num_lgbti
        columna='AQ'
        WHERE id=472;
      UPDATE heb412_gen_campoplantillahcm SET
        nombrecampo='beneficiarios_nuevos_lgbti',  -- antes num_con_discapacidad
        columna='AR'
        WHERE id=473;
      UPDATE heb412_gen_campoplantillahcm SET
        nombrecampo='beneficiarios_nuevos_con_discapacidad',  -- antes num_afrodescendientes
        columna='AS'
        WHERE id=474;
      UPDATE heb412_gen_campoplantillahcm SET
        nombrecampo='beneficiarios_nuevos_afrodescendientes',  -- antes num_indigenas
        columna='AT'
        WHERE id=475;
      UPDATE heb412_gen_campoplantillahcm SET
        nombrecampo='beneficiarios_nuevos_indigenas',  -- antes num_otra_etnia
        columna='AU'
        WHERE id=476;
      UPDATE heb412_gen_campoplantillahcm SET
        nombrecampo='beneficiarios_nuevos_otra_etnia',  -- antes observaciones
        columna='AV'
        WHERE id=477;
      UPDATE heb412_gen_campoplantillahcm SET
        nombrecampo='actividad_observaciones',  -- antes id
        columna='AW'
        WHERE id=478;
      UPDATE heb412_gen_campoplantillahcm SET
        nombrecampo='actividad_id',  -- antes responsable
        columna='AX'
        WHERE id=479;
      UPDATE heb412_gen_campoplantillahcm SET
        nombrecampo='actividad_responsable',
        columna='AY'
        WHERE id=480; -- antes oficina
      UPDATE heb412_gen_campoplantillahcm SET
        nombrecampo='oficina',  -- antes vacio
        columna='AZ',
        id=481
        WHERE id=485;
    SQL
  end

  def down
    execute <<-SQL
      UPDATE heb412_gen_campoplantillahcm SET
        nombrecampo='poblacion_colombianos_retornados'
        WHERE id=455;
      UPDATE heb412_gen_campoplantillahcm SET
        nombrecampo='poblacion_com_acogida'
        WHERE id=456;
      UPDATE heb412_gen_campoplantillahcm SET
        nombrecampo='poblacion_niñas_adolescentes_y_se'
        WHERE id=457;
      UPDATE heb412_gen_campoplantillahcm SET
        nombrecampo='poblacion_mujeres_adultas'
        WHERE id=458;
    SQL
  end
end
