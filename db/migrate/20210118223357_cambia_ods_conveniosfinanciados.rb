class CambiaOdsConveniosfinanciados < ActiveRecord::Migration[6.0]
  def up
    r = Heb412Gen::Plantillahcm.find(46)
    r.ruta = 'Plantillas/listado_extracompleto_de_convenios_financiados.ods'
    r.save!
  end

  def down
    r = Heb412Gen::Plantillahcm.find(46)
    r.ruta = 'Plantillas/listado_de_convenios_financiados.ods'
    r.save!
  end
end
