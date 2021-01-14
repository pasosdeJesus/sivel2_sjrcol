class CamposDesplazamientoPlantillahcm44 < ActiveRecord::Migration[6.0]
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
    'fechaexpulsion',
    'expulsion',
    'fechallegada',
    'llegada',
    'descripcion',
    'modalidadgeo',
    'submodalidadgeo',
    'tipodesp',
    'categoria',
    'otrosdatos',
    'declaro',
    'hechosdeclarados',
    'fechadeclaracion',
    'declaroante',
    'inclusion',
    'acreditacion',
    'retornado',
    'reubicado',
    'connacionalretorno',
    'acompestado',
    'connacionaldeportado',
    'oficioantes',
    'modalidadtierra',
    'materialesperdidos',
    'inmaterialesperdidos',
    'protegiorupta',
    'documentostierra'
  ]


  def up
    numid = 950 
    col = 'IP'
    CAMPOS.each do |campo|
      cp=Heb412Gen::Campoplantillahcm.new(
        id: numid,
        plantillahcm_id: 44,
        nombrecampo: "#{campo}",
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
        id>='950' AND id<='#{CAMPOS.length+949}'
    SQL
  end
end
