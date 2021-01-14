class CamposUbiacion3Plantillahcm44 < ActiveRecord::Migration[6.0]
  def sigcol(col)
    if col[1] == 'Z'
      c0 = col[0].ord + 1
      c1 =  'A'
    else
      c0 = col[0].ord
      c1 = col[1].ord + 1
    end
    return c0.chr + c1.chr
  end

  CAMPOS = [
    'pais', 
    'departamento',
    'municipio',
    'clase',
    'longitud',
    'latitud',
    'lugar',
    'sitio',
    'tsitio'
  ]


  def up
    numid = 750  
    col = 'GW'
    CAMPOS.each do |campo|
      cp=Heb412Gen::Campoplantillahcm.new(
        id: numid,
        plantillahcm_id: 44,
        nombrecampo: "ubicacion3_#{campo}",
        columna: col
      )
      cp.save!
      numid += 1
      col = sigcol(col)
    end
  end

  def down
    execute <<-SQL
      DELETE FROM heb412_gen_campoplantillahcm WHERE
        id>='750' AND id<='#{CAMPOS.length+749}'
    SQL
  end
end
