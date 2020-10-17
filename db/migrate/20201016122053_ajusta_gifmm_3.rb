class AjustaGifmm3 < ActiveRecord::Migration[6.0]
  def up
    execute <<-SQL
      UPDATE heb412_gen_campoplantillahcm SET
        nombrecampo='beneficiarios'  -- antes poblacion
        WHERE id=450;
      UPDATE heb412_gen_campoplantillahcm SET
        nombrecampo='beneficiarios_nuevos_mes'  -- antes poblacion_nuevos
        WHERE id=451;
      UPDATE heb412_gen_campoplantillahcm SET
        nombrecampo='beneficiarios_nuevos_vocacion_permanencia'  -- antes poblacion_vocacion_permanencia
        WHERE id=452;
    SQL
  end

  def down
    execute <<-SQL
      UPDATE heb412_gen_campoplantillahcm SET
        nombrecampo='poblacion'
        WHERE id=450;
      UPDATE heb412_gen_campoplantillahcm SET
        nombrecampo='poblacion_nuevos'
        WHERE id=451;
      UPDATE heb412_gen_campoplantillahcm SET
        nombrecampo='poblacion_vocacion_permanencia'  
        WHERE id=452;
    SQL
  end
end
