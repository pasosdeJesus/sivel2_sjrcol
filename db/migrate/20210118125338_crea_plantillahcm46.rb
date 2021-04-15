class CreaPlantillahcm46 < ActiveRecord::Migration[6.0]

  def sigcol(col)
    if col[1] and col[1]== 'Z'
      c0 = col[0].ord + 1
      c1 =  'A'
    else
      if col[1]
        c0 = col[0].ord
        c1 = col[1].ord + 1
      else 
        c0 = col[0]=='Z' ? 'A' : col[0].ord + 1
        c1 = col[0]=='Z' ? 'A' : ''
      end
    end
    return c0.chr + c1.chr
  end

  CAMPOS = [
    'id',
    'nombres',
    'financiador',
    'fechainicio',
    'fechacierre',
    'responsable',
    'compromisos',
    'observaciones',
    'monto',
    'area',
    'equipotrabajo',
    'objetivos',
    'obj1_cod',
    'obj1_texto',
    'obj2_cod',
    'obj2_texto',
    'indicadores_obj'
  ]

  CAMPOS_INDICADORES_OBJ = [
    'refobj',
    'codigo',
    'nombre',
    'tipo',
  ]
  CAMPOS_RESULTADOS = [
    'refobj',
    'codigo',
    'resultado'
  ]
  CAMPOS_INDICADORES_RES = [ 
    'refres',
    'codigo',
    'tipo',
    'indicador'
  ]
  CAMPOS_ACTIVIDADESPF = [
    'refresultado',
    'codigo',
    'tipo',
    'actividad',
    'descripcion',
    'indicadoresgifmm'
  ]

  def agrega_campo_plantillahcm(id, plantillahcm_id,  nombre_campo, col)
     cp=Heb412Gen::Campoplantillahcm.new(
       id: id,
       plantillahcm_id: plantillahcm_id,
       nombrecampo: nombre_campo,
       columna: col
     )
     cp.save!
  end

  def up
    execute <<-SQL
      INSERT INTO public.heb412_gen_plantillahcm (id, ruta, fuente, licencia, vista, nombremenu, filainicial) VALUES (46, 'Plantillas/listado_extracompleto_de_convenios_financiados.ods', 'PdJ', 'Dominio Publico', 'Proyecto', 'Listado extracompleto de convenios financiados', 5);
    SQL

    numid = 2300
    col = 'A'
    CAMPOS.each do |campo|
      agrega_campo_plantillahcm(numid, 46, campo, col)
      numid += 1
      col = sigcol(col)
    end

    (1..4).each do |numind|
      CAMPOS_INDICADORES_OBJ.each do |iob|
        agrega_campo_plantillahcm(numid, 46, "indicadorobj#{numind}_#{iob}", col)
        numid += 1
        col = sigcol(col)
      end
    end

    agrega_campo_plantillahcm(numid, 46, 'resultados', col)
    numid += 1
    col = sigcol(col)

    (1..4).each do |numres|
      CAMPOS_RESULTADOS.each do |ires|
        agrega_campo_plantillahcm(numid, 46, "resultado#{numres}_#{ires}", col)
        numid += 1
        col = sigcol(col)
      end
    end

    agrega_campo_plantillahcm(numid, 46, 'indicadoresres', col)
    numid += 1
    col = sigcol(col)

    (1..6).each do |numind|
      CAMPOS_INDICADORES_RES.each do |inres|
        agrega_campo_plantillahcm(numid, 46, "indicadorres#{numind}_#{inres}", col)
        numid += 1
        col = sigcol(col)
      end
    end

    agrega_campo_plantillahcm(numid, 46, 'actividadespf', col)
    numid += 1
    col = sigcol(col)

    (1..8).each do |numa|
      CAMPOS_ACTIVIDADESPF.each do |apf|
        agrega_campo_plantillahcm(numid, 46, "actividadpf#{numa}_#{apf}", col)
        numid += 1
        col = sigcol(col)
      end
    end
  end

  def down
    execute <<-SQL
      DELETE FROM heb412_gen_campoplantillahcm WHERE
        id>='2300' AND id<='#{CAMPOS.length+2299}';
      DELETE FROM heb412_gen_campoplantillahcm WHERE
        id='#{CAMPOS.length+2299+1}';
      DELETE FROM heb412_gen_campoplantillahcm WHERE
        id>='#{CAMPOS.length+2299+1+1}' AND id<='#{2299 + CAMPOS.length + 1 + CAMPOS_INDICADORES_OBJ.length*4}';
      DELETE FROM heb412_gen_campoplantillahcm WHERE
        id>='#{2299 + CAMPOS.length + 1 + CAMPOS_INDICADORES_OBJ.length*4 + 1}' 
        AND id<='#{2299 + CAMPOS.length + 1 + CAMPOS_INDICADORES_OBJ.length*4 + CAMPOS_RESULTADOS.length*4}';
      DELETE FROM heb412_gen_campoplantillahcm WHERE
        id='#{2299 + CAMPOS.length + 1 + CAMPOS_INDICADORES_OBJ.length*4 + CAMPOS_RESULTADOS.length*4 + 1}';
      DELETE FROM heb412_gen_campoplantillahcm WHERE
        id>='#{2299 + CAMPOS.length + 1 + CAMPOS_INDICADORES_OBJ.length*4 + CAMPOS_RESULTADOS.length*4 + 1 + 1}' 
        AND id<='#{2299 + CAMPOS.length + 1 + CAMPOS_INDICADORES_OBJ.length*4 + CAMPOS_RESULTADOS.length*4 + 1 + CAMPOS_INDICADORES_RES.length*6}';
      DELETE FROM heb412_gen_campoplantillahcm WHERE
        id='#{2299 + CAMPOS.length + 1 + CAMPOS_INDICADORES_OBJ.length*4 + CAMPOS_RESULTADOS.length*4 + 1 + CAMPOS_INDICADORES_RES.length*6 + 1}';
      DELETE FROM heb412_gen_campoplantillahcm WHERE
        id>='#{2299 + CAMPOS.length + 1 + CAMPOS_INDICADORES_OBJ.length*4 + CAMPOS_RESULTADOS.length*4 + 1 + CAMPOS_INDICADORES_RES.length*6 + 1 + 1}' 
        AND id<='#{2299 + CAMPOS.length + 1 + CAMPOS_INDICADORES_OBJ.length*4 + CAMPOS_RESULTADOS.length*4 + 1 + CAMPOS_INDICADORES_RES.length*6 + 1 + CAMPOS_ACTIVIDADESPF.length*8}';
      DELETE FROM public.heb412_gen_plantillahcm WHERE id='46'
    SQL
  end
end
