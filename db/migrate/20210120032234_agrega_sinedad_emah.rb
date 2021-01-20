class AgregaSinedadEmah < ActiveRecord::Migration[6.0]

  def up
    Heb412Gen::PlantillaHelper.inserta_columna(1, 2730, 'O', 'ultimaatencion_beneficiarios_se')
    Heb412Gen::PlantillaHelper.inserta_columna(1, 2731, 'V', 'ultimaatencion_beneficiarias_se')
    Heb412Gen::PlantillaHelper.inserta_columna(1, 2732, 'AC', 'ultimaatencion_beneficiarios_ss_se')
  end
  def down
    Heb412Gen::PlantillaHelper.elimina_columna(1, 2732)
    Heb412Gen::PlantillaHelper.elimina_columna(1, 2731)
    Heb412Gen::PlantillaHelper.elimina_columna(1, 2730)
  end
end
