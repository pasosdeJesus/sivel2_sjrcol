class ModificaGenplantillaListadoProyectos < ActiveRecord::Migration[6.0]
  def up
    execute <<-SQL
      UPDATE public.heb412_gen_plantillahcm SET
      ruta='Plantillas/listado_de_convenios_financiados.ods',
      nombremenu='Listado de convenios financiados' WHERE id=40;
    SQL
    b= Heb412Gen::Campoplantillahcm.find(408)
    b.destroy!
    idc=409
    ('H'..'K').each do |col|
      c=Heb412Gen::Campoplantillahcm.find(idc)
      c.columna=col
      c.save!
      idc += 1
    end
  end

  def down
  end
end
