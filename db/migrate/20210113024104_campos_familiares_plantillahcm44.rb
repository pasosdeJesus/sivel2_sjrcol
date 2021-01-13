class CamposFamiliaresPlantillahcm44 < ActiveRecord::Migration[6.0]

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
    'nombres',
    'apellidos',
    'anionac',
    'mesnac',
    'dianac',
    'tdocumento',
    'numerodocumento',
    'sexo',
    'pais',
    'departamento',
    'municipio',
    'numeroanexos',
    'etnia',
    'orientacionsexual',
    'maternidad',
    'estadocivil',
    'discapacidad',
    'cabezafamilia',
    'rolfamilia',
    'tienesisben',
    'regimensalud',
    'asisteescuela',
    'escolaridad',
    'actualtrabajando',
    'profesion',
    'actividadoficio',
    'filiacion',
    'organizacion',
    'vinculoestado',
    'numeroanexosconsen'
  ]


  def up
    numid = 600  
    col = 'BO'
    (2..5).each do |numfam|
      CAMPOS.each do |campo|
        cp=Heb412Gen::Campoplantillahcm.new(
          id: numid,
          plantillahcm_id: 44,
          nombrecampo: "familiar#{numfam}_#{campo}",
          columna: col
        )
        cp.save!
        numid += 1
        col = sigcol(col)
      end
    end
  end

  def down
    execute <<-SQL
      DELETE FROM heb412_gen_campoplantillahcm WHERE
        id>='600' AND id<='#{CAMPOS.length*4+599}'
    SQL
  end
end
