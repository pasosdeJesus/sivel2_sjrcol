class AjustaGifmm4 < ActiveRecord::Migration[6.0]
  def up
    execute <<-SQL
      UPDATE heb412_gen_campoplantillahcm SET
        nombrecampo='beneficiarios_nuevos_en_transito'  -- antes poblacion_transito
        WHERE id=453;
      UPDATE heb412_gen_campoplantillahcm SET
        nombrecampo='beneficiarios_nuevos_pendulares'  -- antes poblacion_pendulares
        WHERE id=454;
    SQL
  end

  def down
    execute <<-SQL
      UPDATE heb412_gen_campoplantillahcm SET
        nombrecampo='poblacion_transito'
        WHERE id=453;
      UPDATE heb412_gen_campoplantillahcm SET
        nombrecampo='poblacion_pendulares'
        WHERE id=454;
    SQL
  end
end
