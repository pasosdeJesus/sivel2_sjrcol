class ConteosController < ApplicationController

  def municipios
    authorize! :contar, Caso
    @fechaini = '';
    cfecha = '';
    if (params[:fechaini]) 
        pfechaini = DateTime.strptime(params[:fechaini], '%Y-%m-%d')
        @fechaini = pfechaini.strftime('%Y-%m-%d')
        cfecha += "fechaexpulsion >= '#{@fechaini}' AND "
    end
    @fechafin = '';
    if (params[:fechafin]) 
        pfechafin = DateTime.strptime(params[:fechafin], '%Y-%m-%d')
        @fechafin = pfechafin.strftime('%Y-%m-%d')
        cfecha += "fechaexpulsion <= '#{@fechafin}' AND "
    end
    
    # expulsores
    @expulsores = ActiveRecord::Base.connection.select_all("
      SELECT (SELECT nombre FROM pais WHERE id=id_pais) AS pais, 
        (SELECT nombre FROM departamento WHERE id_pais=ubicacion.id_pais 
          AND id=id_departamento) AS departamento, 
        (SELECT nombre FROM municipio WHERE id_pais=ubicacion.id_pais 
          AND id_departamento=ubicacion.id_departamento 
          AND id=ubicacion.id_municipio) AS municipio, 
        COUNT(victima.id) AS cuenta
      FROM desplazamiento, ubicacion, victima
      WHERE 
        #{cfecha} 
        id_expulsion=ubicacion.id 
        AND desplazamiento.id_caso=victima.id_caso
      GROUP BY 1,2,3 ORDER BY 4 desc;
    ")
    # receptores
    @receptores = ActiveRecord::Base.connection.select_all("
      SELECT (SELECT nombre FROM pais WHERE id=id_pais) AS pais, 
        (SELECT nombre FROM departamento WHERE id_pais=ubicacion.id_pais 
          AND id=id_departamento) AS departamento, 
        (SELECT nombre FROM municipio WHERE id_pais=ubicacion.id_pais 
          AND id_departamento=ubicacion.id_departamento 
          AND id=ubicacion.id_municipio) AS municipio, 
        COUNT(victima.id) AS cuenta
      FROM desplazamiento, ubicacion, victima
      WHERE 
        #{cfecha} 
        id_llegada=ubicacion.id 
        AND desplazamiento.id_caso=victima.id_caso
      GROUP BY 1,2,3 ORDER BY 4 desc;
    ")
  end

  def rutas
    authorize! :contar, Caso
    # Retorna cadena correspondiente al municipio de una ubicación
    ActiveRecord::Base.connection.select_all("
      CREATE OR REPLACE FUNCTION municipioubicacion(int) RETURNS varchar AS
      $$
        SELECT (SELECT nombre FROM pais WHERE id=ubicacion.id_pais) 
            || COALESCE((SELECT '/' || nombre FROM departamento 
            WHERE departamento.id_pais=ubicacion.id_pais 
            AND departamento.id=ubicacion.id_departamento),'') 
            || COALESCE((SELECT '/' || nombre FROM municipio 
            WHERE municipio.id_pais=ubicacion.id_pais 
            AND municipio.id_departamento=ubicacion.id_departamento 
            AND municipio.id=ubicacion.id_municipio),'') FROM ubicacion
            WHERE ubicacion.id=$1;
      $$ 
      LANGUAGE SQL
    ");
    @rutas = ActiveRecord::Base.connection.select_all(
      "SELECT ruta, cuenta FROM ((SELECT municipioubicacion(d1.id_expulsion) || ' - ' 
        || municipioubicacion(d1.id_llegada) AS ruta, 
        count(id) AS cuenta
      FROM desplazamiento AS d1
      GROUP BY 1)
      UNION  
      (SELECT municipioubicacion(d1.id_expulsion) || ' - ' 
        || municipioubicacion(d1.id_llegada) || ' - '
        || municipioubicacion(d2.id_llegada) AS ruta, 
        count(d1.id_caso) AS cuenta
      FROM desplazamiento AS d1, ubicacion AS l1, desplazamiento as d2,
      ubicacion AS e2, ubicacion AS l2
      WHERE 
      d1.id_caso=d2.id_caso
      AND d1.fechaexpulsion < d2.fechaexpulsion
      AND d1.id_llegada = l1.id
      AND d2.id_llegada = l2.id
      AND d2.id_expulsion = e2.id
      GROUP BY 1)) as sub
      ORDER BY 2 DESC
      "
    )
  end

  def desplazamientos
    authorize! :contar, Caso
    if params[:ordenar] == 'Sexo'
        cord = "3, 6 DESC, 1"
    elsif params[:ordenar] == 'Edad'
        cord = "4, 6 DESC, 1"
    elsif params[:ordenar] == 'Sector'
        cord = "5, 6 DESC, 1"
    else
        cord = "6 DESC, 1"
    end
    @desplazamientos = ActiveRecord::Base.connection.select_all(
      "SELECT victima.id_caso, persona.id AS persona, 
        persona.sexo, rangoedad.rango as rangoedad,
        sectorsocial.nombre as sectorsocial,
        COUNT(desplazamiento.id) as cuenta
      FROM victima, persona, desplazamiento, rangoedad, sectorsocial
      WHERE victima.id_caso=desplazamiento.id_caso
        AND victima.id_persona=persona.id
        AND victima.id_rangoedad=rangoedad.id
        AND victima.id_sectorsocial=sectorsocial.id
      GROUP BY 1, 2, 3, 4, 5 ORDER BY #{cord};
      "
    )
  end
end
