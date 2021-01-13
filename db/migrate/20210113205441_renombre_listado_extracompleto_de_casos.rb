class RenombreListadoExtracompletoDeCasos < ActiveRecord::Migration[6.0]
  def up
    p = Heb412Gen::Plantillahcm.find(44)
    p.nombremenu = 'Listado extracompleto de casos'
    p.save!
  end
  def down
    p = Heb412Gen::Plantillahcm.find(44)
    p.nombremenu = 'Listado de casos'
    p.save!
  end
end
