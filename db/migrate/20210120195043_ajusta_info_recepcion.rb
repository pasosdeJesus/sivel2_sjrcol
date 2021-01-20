class AjustaInfoRecepcion < ActiveRecord::Migration[6.0]
  def up
    execute <<-SQL

      UPDATE heb412_gen_campoplantillahcm SET 
        nombrecampo = 'ultimaatencion_beneficiarios_60m'
        WHERE 
        nombrecampo = 'ultimaatencion_beneficiarios_60_';
      UPDATE heb412_gen_campoplantillahcm SET 
        nombrecampo = 'ultimaatencion_beneficiarias_60m'
        WHERE 
        nombrecampo = 'ultimaatencion_beneficiarias_60_';
      UPDATE heb412_gen_campoplantillahcm SET 
        nombrecampo = 'ultimaatencion_beneficiarios_ss_60m'
        WHERE 
        nombrecampo = 'ultimaatencion_beneficiarios_ss_60_';


      UPDATE heb412_gen_campoplantillahcm SET 
        nombrecampo = 'contacto_edad_fecha_recepcion'
        WHERE 
        nombrecampo = 'contacto_edad_fecharec'
        AND plantillahcm_id=47;

      UPDATE heb412_gen_campoplantillahcm SET 
        nombrecampo = 'beneficiarios_0_5_fecha_recepcion'
        WHERE 
        nombrecampo = 'beneficiarios_0_5'
        AND plantillahcm_id=47;
      UPDATE heb412_gen_campoplantillahcm SET 
        nombrecampo = 'beneficiarios_6_12_fecha_recepcion'
        WHERE 
        nombrecampo = 'beneficiarios_6_12'
        AND plantillahcm_id=47; 
      UPDATE heb412_gen_campoplantillahcm SET 
        nombrecampo = 'beneficiarios_13_17_fecha_recepcion'
        WHERE 
        nombrecampo = 'beneficiarios_13_17'
        AND plantillahcm_id=47;  
      UPDATE heb412_gen_campoplantillahcm SET 
        nombrecampo = 'beneficiarios_18_26_fecha_recepcion'
        WHERE 
        nombrecampo = 'beneficiarios_18_26'
        AND plantillahcm_id=47;  
      UPDATE heb412_gen_campoplantillahcm SET 
        nombrecampo = 'beneficiarios_27_59_fecha_recepcion'
        WHERE 
        nombrecampo = 'beneficiarios_27_59'
        AND plantillahcm_id=47;  
      UPDATE heb412_gen_campoplantillahcm SET 
        nombrecampo = 'beneficiarios_60m_fecha_recepcion'
        WHERE 
        nombrecampo = 'beneficiarios_60_'
        AND plantillahcm_id=47;  
      UPDATE heb412_gen_campoplantillahcm SET 
        nombrecampo = 'beneficiarios_se_fecha_recepcion'
        WHERE 
        nombrecampo = 'beneficiarios_se'
        AND plantillahcm_id=47;  


      UPDATE heb412_gen_campoplantillahcm SET 
        nombrecampo = 'beneficiarias_0_5_fecha_recepcion'
        WHERE 
        nombrecampo = 'beneficiarias_0_5'
        AND plantillahcm_id=47;
      UPDATE heb412_gen_campoplantillahcm SET 
        nombrecampo = 'beneficiarias_6_12_fecha_recepcion'
        WHERE 
        nombrecampo = 'beneficiarias_6_12'
        AND plantillahcm_id=47; 
      UPDATE heb412_gen_campoplantillahcm SET 
        nombrecampo = 'beneficiarias_13_17_fecha_recepcion'
        WHERE 
        nombrecampo = 'beneficiarias_13_17'
        AND plantillahcm_id=47;  
      UPDATE heb412_gen_campoplantillahcm SET 
        nombrecampo = 'beneficiarias_18_26_fecha_recepcion'
        WHERE 
        nombrecampo = 'beneficiarias_18_26'
        AND plantillahcm_id=47;  
      UPDATE heb412_gen_campoplantillahcm SET 
        nombrecampo = 'beneficiarias_27_59_fecha_recepcion'
        WHERE 
        nombrecampo = 'beneficiarias_27_59'
        AND plantillahcm_id=47;  
      UPDATE heb412_gen_campoplantillahcm SET 
        nombrecampo = 'beneficiarias_60m_fecha_recepcion'
        WHERE 
        nombrecampo = 'beneficiarias_60_'
        AND plantillahcm_id=47;  
      UPDATE heb412_gen_campoplantillahcm SET 
        nombrecampo = 'beneficiarias_se_fecha_recepcion'
        WHERE 
        nombrecampo = 'beneficiarias_se'
        AND plantillahcm_id=47;  


      UPDATE heb412_gen_campoplantillahcm SET 
        nombrecampo = 'beneficiarios_ss_0_5_fecha_recepcion'
        WHERE 
        nombrecampo = 'beneficiarios_ss_0_5'
        AND plantillahcm_id=47;
      UPDATE heb412_gen_campoplantillahcm SET 
        nombrecampo = 'beneficiarios_ss_6_12_fecha_recepcion'
        WHERE 
        nombrecampo = 'beneficiarios_ss_6_12'
        AND plantillahcm_id=47; 
      UPDATE heb412_gen_campoplantillahcm SET 
        nombrecampo = 'beneficiarios_ss_13_17_fecha_recepcion'
        WHERE 
        nombrecampo = 'beneficiarios_ss_13_17'
        AND plantillahcm_id=47;  
      UPDATE heb412_gen_campoplantillahcm SET 
        nombrecampo = 'beneficiarios_ss_18_26_fecha_recepcion'
        WHERE 
        nombrecampo = 'beneficiarios_ss_18_26'
        AND plantillahcm_id=47;  
      UPDATE heb412_gen_campoplantillahcm SET 
        nombrecampo = 'beneficiarios_ss_27_59_fecha_recepcion'
        WHERE 
        nombrecampo = 'beneficiarios_ss_27_59'
        AND plantillahcm_id=47;  
      UPDATE heb412_gen_campoplantillahcm SET 
        nombrecampo = 'beneficiarios_ss_60m_fecha_recepcion'
        WHERE 
        nombrecampo = 'beneficiarios_ss_60_'
        AND plantillahcm_id=47;  
      UPDATE heb412_gen_campoplantillahcm SET 
        nombrecampo = 'beneficiarios_ss_se_fecha_recepcion'
        WHERE 
        nombrecampo = 'beneficiarios_ss_se'
        AND plantillahcm_id=47;  


    SQL
  end
  def down
    execute <<-SQL
      UPDATE heb412_gen_campoplantillahcm SET 
        nombrecampo = 'ultimaatencion_beneficiarios_60_'
        WHERE 
        nombrecampo = 'ultimaatencion_beneficiarios_60m';
      UPDATE heb412_gen_campoplantillahcm SET 
        nombrecampo = 'ultimaatencion_beneficiarias_60_'
        WHERE 
        nombrecampo = 'ultimaatencion_beneficiarias_60m';
      UPDATE heb412_gen_campoplantillahcm SET 
        nombrecampo = 'ultimaatencion_beneficiarios_ss_60_'
        WHERE 
        nombrecampo = 'ultimaatencion_beneficiarios_ss_60m';



      UPDATE heb412_gen_campoplantillahcm SET 
        nombrecampo = 'contacto_edad_fecharec'
        WHERE 
        nombrecampo = 'contacto_edad_fecha_recepcion'
        AND plantillahcm_id=47;

      UPDATE heb412_gen_campoplantillahcm SET 
        nombrecampo = 'beneficiarios_0_5'
        WHERE 
        nombrecampo = 'beneficiarios_0_5_fecha_recepcion'
        AND plantillahcm_id=47;
      UPDATE heb412_gen_campoplantillahcm SET 
        nombrecampo = 'beneficiarios_6_12'
        WHERE 
        nombrecampo = 'beneficiarios_6_12_fecha_recepcion'
        AND plantillahcm_id=47; 
      UPDATE heb412_gen_campoplantillahcm SET 
        nombrecampo = 'beneficiarios_13_17'
        WHERE 
        nombrecampo = 'beneficiarios_13_17_fecha_recepcion'
        AND plantillahcm_id=47;  
      UPDATE heb412_gen_campoplantillahcm SET 
        nombrecampo = 'beneficiarios_18_26'
        WHERE 
        nombrecampo = 'beneficiarios_18_26_fecha_recepcion'
        AND plantillahcm_id=47;  
      UPDATE heb412_gen_campoplantillahcm SET 
        nombrecampo = 'beneficiarios_27_59'
        WHERE 
        nombrecampo = 'beneficiarios_27_59_fecha_recepcion'
        AND plantillahcm_id=47;  
      UPDATE heb412_gen_campoplantillahcm SET 
        nombrecampo = 'beneficiarios_60_'
        WHERE 
        nombrecampo = 'beneficiarios_60m_fecha_recepcion'
        AND plantillahcm_id=47;  
      UPDATE heb412_gen_campoplantillahcm SET 
        nombrecampo = 'beneficiarios_se'
        WHERE 
        nombrecampo = 'beneficiarios_se_fecha_recepcion'
        AND plantillahcm_id=47;  


      UPDATE heb412_gen_campoplantillahcm SET 
        nombrecampo = 'beneficiarias_0_5'
        WHERE 
        nombrecampo = 'beneficiarias_0_5_fecha_recepcion'
        AND plantillahcm_id=47;
      UPDATE heb412_gen_campoplantillahcm SET 
        nombrecampo = 'beneficiarias_6_12'
        WHERE 
        nombrecampo = 'beneficiarias_6_12_fecha_recepcion'
        AND plantillahcm_id=47; 
      UPDATE heb412_gen_campoplantillahcm SET 
        nombrecampo = 'beneficiarias_13_17'
        WHERE 
        nombrecampo = 'beneficiarias_13_17_fecha_recepcion'
        AND plantillahcm_id=47;  
      UPDATE heb412_gen_campoplantillahcm SET 
        nombrecampo = 'beneficiarias_18_26'
        WHERE 
        nombrecampo = 'beneficiarias_18_26_fecha_recepcion'
        AND plantillahcm_id=47;  
      UPDATE heb412_gen_campoplantillahcm SET 
        nombrecampo = 'beneficiarias_27_59'
        WHERE 
        nombrecampo = 'beneficiarias_27_59_fecha_recepcion'
        AND plantillahcm_id=47;  
      UPDATE heb412_gen_campoplantillahcm SET 
        nombrecampo = 'beneficiarias_60_'
        WHERE 
        nombrecampo = 'beneficiarias_60m_fecha_recepcion'
        AND plantillahcm_id=47;  
      UPDATE heb412_gen_campoplantillahcm SET 
        nombrecampo = 'beneficiarias_se'
        WHERE 
        nombrecampo = 'beneficiarias_se_fecha_recepcion'
        AND plantillahcm_id=47;  


      UPDATE heb412_gen_campoplantillahcm SET 
        nombrecampo = 'beneficiarios_ss_0_5'
        WHERE 
        nombrecampo = 'beneficiarios_ss_0_5_fecha_recepcion'
        AND plantillahcm_id=47;
      UPDATE heb412_gen_campoplantillahcm SET 
        nombrecampo = 'beneficiarios_ss_6_12'
        WHERE 
        nombrecampo = 'beneficiarios_ss_6_12_fecha_recepcion'
        AND plantillahcm_id=47; 
      UPDATE heb412_gen_campoplantillahcm SET 
        nombrecampo = 'beneficiarios_ss_13_17'
        WHERE 
        nombrecampo = 'beneficiarios_ss_13_17_fecha_recepcion'
        AND plantillahcm_id=47;  
      UPDATE heb412_gen_campoplantillahcm SET 
        nombrecampo = 'beneficiarios_ss_18_26'
        WHERE 
        nombrecampo = 'beneficiarios_ss_18_26_fecha_recepcion'
        AND plantillahcm_id=47;  
      UPDATE heb412_gen_campoplantillahcm SET 
        nombrecampo = 'beneficiarios_ss_27_59'
        WHERE 
        nombrecampo = 'beneficiarios_ss_27_59_fecha_recepcion'
        AND plantillahcm_id=47;  
      UPDATE heb412_gen_campoplantillahcm SET 
        nombrecampo = 'beneficiarios_ss_60_'
        WHERE 
        nombrecampo = 'beneficiarios_ss_60m_fecha_recepcion'
        AND plantillahcm_id=47;  
      UPDATE heb412_gen_campoplantillahcm SET 
        nombrecampo = 'beneficiarios_ss_se'
        WHERE 
        nombrecampo = 'beneficiarios_ss_se_fecha_recepcion'
        AND plantillahcm_id=47;  

    SQL
  end
end
