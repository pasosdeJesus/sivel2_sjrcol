class ConteosController < ApplicationController

  def municipios
    authorize! :contar, Sivel2Gen::Caso
    #byebug
    @fechaini = '';
    cfecha = '';
    if (params[:fechaini] && params[:fechaini] != "") 
        pfechaini = DateTime.strptime(params[:fechaini], '%Y-%m-%d')
        @fechaini = pfechaini.strftime('%Y-%m-%d')
        cfecha += "fechaexpulsion >= '#{@fechaini}' AND "
    end
    @fechafin = '';
    if (params[:fechafin] && params[:fechafin] != "") 
        pfechafin = DateTime.strptime(params[:fechafin], '%Y-%m-%d')
        @fechafin = pfechafin.strftime('%Y-%m-%d')
        cfecha += "fechaexpulsion <= '#{@fechafin}' AND "
    end
    
    # expulsores
    @expulsores = ActiveRecord::Base.connection.select_all("
      SELECT (SELECT nombre FROM sivel2_gen_pais WHERE id=id_pais) AS pais, 
        (SELECT nombre FROM sivel2_gen_departamento
          WHERE id_pais=ubicacion.id_pais 
          AND id=id_departamento) AS departamento, 
        (SELECT nombre FROM sivel2_gen_municipio
          WHERE id_pais=ubicacion.id_pais 
          AND id_departamento=ubicacion.id_departamento 
          AND id=ubicacion.id_municipio) AS municipio, 
        COUNT(victima.id) AS cuenta
      FROM sivel2_sjr_desplazamiento AS desplazamiento, 
        sivel2_gen_ubicacion AS ubicacion, 
        sivel2_gen_victima AS victima
      WHERE 
        #{cfecha} 
        id_expulsion=ubicacion.id 
        AND desplazamiento.id_caso=victima.id_caso
      GROUP BY 1,2,3 ORDER BY 4 desc;
    ")
    # receptores
    @receptores = ActiveRecord::Base.connection.select_all("
      SELECT (SELECT nombre FROM sivel2_gen_pais WHERE id=id_pais) AS pais, 
        (SELECT nombre FROM sivel2_gen_departamento 
          WHERE id_pais=ubicacion.id_pais 
          AND id=id_departamento) AS departamento, 
        (SELECT nombre FROM sivel2_gen_municipio 
        WHERE id_pais=ubicacion.id_pais 
          AND id_departamento=ubicacion.id_departamento 
          AND id=ubicacion.id_municipio) AS municipio, 
        COUNT(victima.id) AS cuenta
      FROM sivel2_sjr_desplazamiento AS desplazamiento, 
        sivel2_gen_ubicacion AS ubicacion, 
        sivel2_gen_victima AS victima
      WHERE 
        #{cfecha} 
        id_llegada=ubicacion.id 
        AND desplazamiento.id_caso=victima.id_caso
      GROUP BY 1,2,3 ORDER BY 4 desc;
    ")
    respond_to do |format|
      format.html { }
      format.json { head :no_content }
      format.js   { }
    end
 
  end

  def rutas
    authorize! :contar, Sivel2Gen::Caso
    # Retorna cadena correspondiente al municipio de una ubicación
    ActiveRecord::Base.connection.select_all("
      CREATE OR REPLACE FUNCTION municipioubicacion(int) RETURNS varchar AS
      $$
        SELECT (SELECT nombre FROM sivel2_gen_pais WHERE id=ubicacion.id_pais) 
            || COALESCE((SELECT '/' || nombre FROM sivel2_gen_departamento 
            WHERE sivel2_gen_departamento.id_pais=ubicacion.id_pais 
            AND sivel2_gen_departamento.id=ubicacion.id_departamento),'') 
            || COALESCE((SELECT '/' || nombre FROM sivel2_gen_municipio 
            WHERE sivel2_gen_municipio.id_pais=ubicacion.id_pais 
            AND sivel2_gen_municipio.id_departamento=ubicacion.id_departamento 
            AND sivel2_gen_municipio.id=ubicacion.id_municipio),'') 
            FROM sivel2_gen_ubicacion AS ubicacion 
            WHERE ubicacion.id=$1;
      $$ 
      LANGUAGE SQL
    ");
    @rutas = ActiveRecord::Base.connection.select_all(
      "SELECT ruta, cuenta FROM ((SELECT municipioubicacion(d1.id_expulsion) || ' - ' 
        || municipioubicacion(d1.id_llegada) AS ruta, 
        count(id) AS cuenta
      FROM sivel2_sjr_desplazamiento AS d1
      GROUP BY 1)
      UNION  
      (SELECT municipioubicacion(d1.id_expulsion) || ' - ' 
        || municipioubicacion(d1.id_llegada) || ' - '
        || municipioubicacion(d2.id_llegada) AS ruta, 
        count(d1.id_caso) AS cuenta
      FROM sivel2_sjr_desplazamiento AS d1, 
        sivel2_gen_ubicacion AS l1, 
        sivel2_sjr_desplazamiento as d2,
        sivel2_gen_ubicacion AS e2, sivel2_gen_ubicacion AS l2
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
    authorize! :contar, Sivel2Gen::Caso
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
      FROM sivel2_gen_victima AS victima, 
        sivel2_gen_persona AS persona, 
        sivel2_sjr_desplazamiento AS desplazamiento, 
        sivel2_gen_rangoedad AS rangoedad, 
        sivel2_gen_sectorsocial AS sectorsocial
      WHERE victima.id_caso=desplazamiento.id_caso
        AND victima.id_persona=persona.id
        AND victima.id_rangoedad=rangoedad.id
        AND victima.id_sectorsocial=sectorsocial.id
      GROUP BY 1, 2, 3, 4, 5 ORDER BY #{cord};
      "
    )
  end
end
