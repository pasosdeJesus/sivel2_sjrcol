class RenombraListado < ActiveRecord::Migration[6.0]
  def up
    r = Heb412Gen::Plantillahcm.find(44)
    r.ruta = 'Plantillas/listado_extracompleto_de_casos.ods'
    r.save!
  end

  def down
    r = Heb412Gen::Plantillahcm.find(44)
    r.ruta = 'Plantillas/listado_de_casos.ods'
    r.save!
  end
end
