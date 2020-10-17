class Consgifmm < ActiveRecord::Base
  include Sip::Modelo

  belongs_to :detallefinanciero, 
    class_name: 'Detallefinanciero', 
    foreign_key: 'id'

  belongs_to :proyectofinanciero, 
    class_name: 'Cor1440Gen::Proyectofinanciero', 
    foreign_key: 'proyectofinanciero_id'

  belongs_to :actividadpf, 
    class_name: 'Cor1440Gen::Actividadpf', 
    foreign_key: 'actividadpf_id'

  belongs_to :actividad,
    class_name: 'Cor1440Gen::Actividad', 
    foreign_key: 'actividad_id'


  # Retorna el del primer proyecto y de la primera actividad o nil 
  def busca_indicador_gifmm
    if actividadpf
      actividadpf.indicadorgifmm_id
    else
      nil
    end
  end

  def cuenta_victimas_condicion
    cuenta = 0
    self.actividad.casosjr.each do |c|
      c.caso.victima.each do |v|
        if (yield(v))
          cuenta += 1
        end
      end
    end
    cuenta
  end


  def departamento_gifmm
    if actividad.ubicacionpre && actividad.ubicacionpre.departamento
      GifmmHelper::departamento_gifmm(actividad.ubicacionpre.departamento.nombre)
    else
      ''
    end
  end



  def detalleah_unidad
    if detallefinanciero.nil?
      byebug
    else
      detallefinanciero.unidadayuda ?
        detallefinanciero.unidadayuda.nombre :
        ''
    end
  end

  def detalleah_cantidad
    r = detallefinanciero.unidadayuda &&
      detallefinanciero.cantidad && detallefinanciero.persona_ids ?
      detallefinanciero.cantidad*detallefinanciero.persona_ids.count :
      ''
    r.to_s
  end

  def detalleah_modalidad
    detallefinanciero.modalidadentrega ?
      detallefinanciero.modalidadentrega.nombre :
      ''
  end

  def detalleah_tipo_transferencia
    detallefinanciero.modalidadentrega &&
      detallefinanciero.modalidadentrega.nombre == 'Transferencia' &&
      detallefinanciero.tipotransferencia ?
      detallefinanciero.tipotransferencia.nombre :
      ''
  end

  def detalleah_mecanismo_entrega
    detallefinanciero.modalidadentrega &&
      detallefinanciero.modalidadentrega.nombre == 'Transferencia' &&
      detallefinanciero.mecanismodeentrega ?
      detallefinanciero.mecanismodeentrega.nombre :
      ''
  end

  def detalleah_frecuencia_entrega
    detallefinanciero.modalidadentrega &&
      detallefinanciero.modalidadentrega.nombre == 'Transferencia' &&
      detallefinanciero.frecuenciaentrega ?
      detallefinanciero.frecuenciaentrega.nombre :
      ''
  end

  def detalleah_monto_por_persona
    detallefinanciero.modalidadentrega &&
      detallefinanciero.modalidadentrega.nombre == 'Transferencia' &&
      r = detallefinanciero.valorunitario &&
      detallefinanciero.cantidad && detallefinanciero.valorunitario ?
      detallefinanciero.cantidad*detallefinanciero.valorunitario :
      ''
    r.to_s
  end

  def detalleah_numero_meses_cobertura
    detallefinanciero.modalidadentrega &&
      detallefinanciero.modalidadentrega.nombre == 'Transferencia' &&
      detallefinanciero.numeromeses ?
      detallefinanciero.numeromeses :
      ''
  end

  def indicador_gifmm
    idig = self.busca_indicador_gifmm
    if idig != nil
      ::Indicadorgifmm.find(idig).nombre
    else
      ''
    end
  end

  def municipio_gifmm
    if actividad.ubicacionpre && actividad.ubicacionpre.municipio
      GifmmHelper::municipio_gifmm(actividad.ubicacionpre.municipio.nombre)
    else
      ''
    end
  end

    # Auxiliar que retorna listado de identificaciones de personas de 
  # las víctimas del listado de casos que cumplan una condición
  def personas_victimas_condicion
    ids = []
    self.actividad.casosjr.each do |c|
      c.caso.victima.each do |v|
        if (yield(v))
          ids << v.id_persona
        end
      end
    end
    ids
  end

  # Auxiliar que retorna listado de identificaciones de personas del
  # listado de asistentes que cumplan una condición
  def personas_asistentes_condicion
    ids = []
    self.actividad.asistencia.each do |a| 
      if (yield(a))
        ids << a.persona_id
      end
    end
    ids
  end

  def beneficiarios_ids
    r = self.persona_ids.uniq
    r.join(',')
  end


  def beneficiarios
    beneficiarios_ids.split(',').count
  end

  def beneficiarios_enlaces
    beneficiarios_ids.split(',').map {|i|
      r="<a href='#{Rails.application.routes.url_helpers.sip_path + 
      'personas/' + i.to_s}' target='_blank'>#{i.to_s}</a>"
      r.html_safe
    }.join(", ".html_safe).html_safe
  end

  def beneficiarios_nuevos_mes_ids
    idp = beneficiarios_ids.split(',').select {|pid|
      Sip::Persona.find(pid.to_i).actividad.all? {|a|
        a.fecha.year > actividad.fecha.year ||
          (a.fecha.year == actividad.fecha.year && 
           a.fecha.month >= actividad.fecha.month)
      }
    }
#    idp = actividad.casosjr.select {|c|
#      c.caso.fecha.at_beginning_of_month >= self.actividad.fecha.at_beginning_of_month
#    }.map {|c|
#      c.caso.victima.map(&:id_persona)
#    }.flatten.uniq
#    idp += personas_asistentes_condicion {|a| 
#      Sivel2Gen::Victima.where(id_persona: a.persona_id).count > 0 &&
#        Sivel2Gen::Victima.where(id_persona: a.persona_id).take.caso.fecha.
#        at_beginning_of_month >= self.actividad.fecha.at_beginning_of_month
#    }
#    idp.uniq!
    idp.uniq.join(",")
  end


  def beneficiarios_nuevos_mes
    beneficiarios_nuevos_mes_ids.split(",").count
  end


  # Auxiliar que retorna listado de identificaciones de personas del
  # listado de asistentes que cumplan una condición
  def beneficiarios_asistentes_condicion_l
    ids = []
    self.actividad.asistencia.each do |a| 
      if (yield(a))
        ids << a.persona_id
      end
    end
    ids.uniq
  end


  # Retorna listado de ids de personas de casos y asistencia
  # cuyo perfil de migración tenga nombre nomperfil
  def beneficiarios_perfil_migracion_ids(nomperfil)
    idp = actividad.casosjr.select {|c|
      c.caso.migracion.count > 0 &&
        c.caso.migracion[0].perfilmigracion &&
        c.caso.migracion[0].perfilmigracion.nombre == nomperfil
    }.map {|c|
      c.caso.victima.map(&:id_persona)
    }.flatten.uniq

    idp += beneficiarios_asistentes_condicion_l {|a| 
      a.perfilactorsocial &&
        a.perfilactorsocial.nombre == nomperfil
    }
    idp.uniq!
    idp.join(",")
  end

  def beneficiarios_nuevos_vocacion_permanencia_ids
    idv = beneficiarios_perfil_migracion_ids('CON VOCACIÓN DE PERMANENCIA').
      split(',')
    idn = beneficiarios_nuevos_mes_ids.split(',')
    idp = idv & idn
    idp.uniq.join(',')
  end

  def beneficiarios_nuevos_vocacion_permanencia
    beneficiarios_nuevos_vocacion_permanencia_ids.split(",").count
  end

  def poblacion_colombianos_retornados_ids
    idcol = Sip::Pais.where(nombre: 'COLOMBIA').take.id
    idp = actividad.casosjr.select {|c|
      c.caso.migracion.count > 0
    }.map {|c|
      c.caso.victima.select {|v|
        v.persona &&
          (v.persona.nacionalde == idcol || v.persona.id_pais == idcol)
      }.map(&:id_persona)
    }.flatten.uniq

    idp += personas_asistentes_condicion {|a| 
      Sivel2Gen::Victima.where(id_persona: a.persona_id).count > 0 &&
        Sivel2Gen::Victima.where(id_persona: a.persona_id).take.
        caso.migracion.count > 0 &&
        (a.persona.nacionalde == idcol || a.persona.id_pais == idcol)
    }
    idp.uniq!
    idp.join(",")

  end

  def poblacion_colombianos_retornados
    poblacion_colombianos_retornados_ids.split(",").count
  end


  # Retorna listado de ids de personas de casos y asistencia
  # cuyo perfil de migración tenga nombre nomperfil
  def poblacion_perfil_migracion_ids(nomperfil)
    idp = actividad.casosjr.select {|c|
      c.caso.migracion.count > 0 &&
        c.caso.migracion[0].perfilmigracion &&
        c.caso.migracion[0].perfilmigracion.nombre == nomperfil
    }.map {|c|
      c.caso.victima.map(&:id_persona)
    }.flatten.uniq

    idp += personas_asistentes_condicion {|a| 
      a.perfilactorsocial &&
        a.perfilactorsocial.nombre == nomperfil
    }
    idp.uniq!
    idp.join(",")
  end


  def poblacion_pendulares_ids
    poblacion_perfil_migracion_ids('PENDULAR')
  end

  def poblacion_pendulares
    poblacion_pendulares_ids.split(",").count
  end


  def poblacion_transito_ids
    poblacion_perfil_migracion_ids('EN TRÁNSITO')
  end

  def poblacion_transito
    poblacion_transito_ids.split(",").count
  end


  def  poblacion_r_g(sexo, num)
    idp = personas_victimas_condicion {|v| 
      if v.persona.sexo == sexo
        e = Sivel2Gen::RangoedadHelper.edad_de_fechanac_fecha(
          v.persona.anionac, v.persona.mesnac, v.persona.dianac,
          actividad.fecha.year, actividad.fecha.month, actividad.fecha. day)
        r = Sivel2Gen::RangoedadHelper.buscar_rango_edad(
          e, 'Cor1440Gen::Rangoedadac')
        r == num
      else
        false
      end
    }
    idp += personas_asistentes_condicion {|a| 
      if a.persona && a.persona.sexo == sexo
        e = Sivel2Gen::RangoedadHelper.edad_de_fechanac_fecha(
          a.persona.anionac, a.persona.mesnac, a.persona.dianac,
          actividad.fecha.year, actividad.fecha.month, actividad.fecha. day)
        r = Sivel2Gen::RangoedadHelper.buscar_rango_edad(
          e, 'Cor1440Gen::Rangoedadac')
        r == num
      else
        false
      end
    }
    idp.uniq!
    idp.join(",")
  end

  def poblacion_mujeres_r_g_ids(num)
    poblacion_r_g('F', num)
  end

  def poblacion_hombres_r_g_ids(num)
    poblacion_r_g('M', num)
  end

  def poblacion_sinsexo_g_ids(num)
    poblacion_r_g('S', num)
  end


  def poblacion_gen_infijo(infijo, num = nil)
    puts "** OJO poblacion_gen_infijo(infijo = #{infijo}, num = #{num})"
    p1 = nil
    p2 = nil
    if num.nil?
      p1 = send("poblacion_#{infijo}_solore")
      if respond_to?("poblacion_#{infijo}_ids")
        p2 = send("poblacion_#{infijo}_ids").split(",").count
      end
    else
      p1 = send("poblacion_#{infijo}_solore", num)
      if respond_to?("poblacion_#{infijo}_ids")
        p2 = send("poblacion_#{infijo}_ids", num).split(",").count
      end
    end
    if p2.nil? || p1 >= p2
      p1.to_s
    else
      "#{p1} pero se esperaban al menos #{p2}"
    end
  end

  def poblacion_hombres_adultos_ids
    l = poblacion_hombres_r_g_ids(4).split(",") +
      poblacion_hombres_r_g_ids(5).split(",") +
      poblacion_hombres_r_g_ids(6).split(",")
    l.join(",")
  end

  def poblacion_hombres_r_g_4_5_ids
    l = poblacion_hombres_r_g_ids(4).split(",") + 
      poblacion_hombres_r_g_ids(5).split(",")
    l.join(",")
  end

  def poblacion_mujeres_adultas_ids
    l = poblacion_mujeres_r_g_ids(4).split(",") +
      poblacion_mujeres_r_g_ids(5).split(",") +
      poblacion_mujeres_r_g_ids(6).split(",")
    l.join(",")
  end

  def poblacion_mujeres_r_g_4_5_ids
    l = poblacion_mujeres_r_g_ids(4).split(",") + poblacion_mujeres_r_g_ids(5).split(",")
    l.join(",")
  end

  def poblacion_ninas_adolescentes_y_se_ids
    l = poblacion_mujeres_r_g_ids(1).split(",") +
      poblacion_mujeres_r_g_ids(2).split(",") +
      poblacion_mujeres_r_g_ids(3).split(",") +
      poblacion_mujeres_r_g_ids(7).split(",")
    l.join(",")
  end

  def poblacion_ninos_adolescentes_y_se_ids
    l = poblacion_hombres_r_g_ids(1).split(",") +
      poblacion_hombres_r_g_ids(2).split(",") +
      poblacion_hombres_r_g_ids(3).split(",") +
      poblacion_hombres_r_g_ids(7).split(",")
    l.join(",")
  end

  def poblacion_sinsexo_adultos_ids
    l = poblacion_sinsexo_g_ids(4).split(",") +
      poblacion_sinsexo_g_ids(5).split(",") +
      poblacion_sinsexo_g_ids(6).split(",")
    l.join(",")
  end

  def poblacion_sinsexo_menores_ids
    l = poblacion_sinsexo_g_ids(1).split(",") +
      poblacion_sinsexo_g_ids(2).split(",") +
      poblacion_sinsexo_g_ids(3).split(",") +
      poblacion_sinsexo_g_ids(7).split(",")
    l.join(",")
  end

  def sector_gifmm
    idig = self.busca_indicador_gifmm
    if idig != nil
      ::Indicadorgifmm.find(idig).sectorgifmm.nombre
    else
      ''
    end
  end

  def socio_principal
    sp = ''
    if proyectofinanciero && proyectofinanciero.financiador &&
        proyectofinanciero.financiador.count > 0
      if proyectofinanciero.financiador[0].nombregifmm &&
          proyectofinanciero.financiador[0].nombregifmm.strip != ''
        sp = proyectofinanciero.financiador[0].nombregifmm
      else
        sp = proyectofinanciero.financiador[0].nombre
      end
    end
    sp
  end


  def presenta(atr)
    puts "** ::Consgiffm.rb atr=#{atr}"

    m =/^beneficiarios_(.*)_enlaces$/.match(atr.to_s)
    if m && respond_to?("beneficiarios_#{m[1]}_ids")
      bids = send("beneficiarios_#{m[1]}_ids").split(',')
      return bids.map {|i|
        r="<a href='#{Rails.application.routes.url_helpers.sip_path + 
        'personas/' + i.to_s}' target='_blank'>#{i.to_s}</a>"
        r.html_safe
      }.join(", ".html_safe).html_safe
    end

    case atr.to_sym
    when :actividad_nombre
      self.actividad.nombre

    when :actividad_id
      self.actividad_id

    when :actividad_fecha_mes
      self.actividad.fecha ? self.actividad.fecha.month : ''

    when :actividad_proyectofinanciero
      self.actividad.proyectofinanciero ? 
        self.actividad.proyectofinanciero.map(&:nombre).join('; ') : ''


    when :estado
      'En proceso'

    when :mes
      actividad.fecha ? 
        Sip::FormatoFechaHelper::MESES[actividad.fecha.month] : ''

    when :objetivo
      actividad.objetivo ? actividad.objetivo : ''

    when :sector_gifmm
      idig = self.busca_indicador_gifmm
      if idig != nil
        ::Indicadorgifmm.find(idig).sectorgifmm.nombre
      else
        ''
      end

    when :socio_implementador
      if socio_principal == 'SJR Col'
        ''
      else
        'SJR Col'
      end

    when :tipo_implementacion
      if socio_principal == 'SJR Col'
        'Directa'
      else
        'Indirecta'
      end

    when :ubicacion
      lugar

    else
      if respond_to?(atr)
        send(atr)
      else
        self.actividad.presenta(atr)
      end
    end #case

  end # presenta

  scope :filtro_actividad_id, lambda { |ida|
    where(actividad_id: ida.to_i)
  }

  scope :filtro_fechaini, lambda { |f|
    where('fecha >= ?', f)
  }

  scope :filtro_fechafin, lambda { |f|
    where('fecha <= ?', f)
  }

#  scope :filtro_proyectofinanciero, lambda { |pf|
#    where('actividad_id IN (SELECT actividad_id ' +
#          'FROM  cor1440_gen_actividad_proyectofinanciero WHERE ' +
#          'proyectofinanciero_id=?)', pf)
#  }

  CONSULTA='consgifmm'

  def self.interpreta_ordenar_por(campo)
    critord = ""
    case campo.to_s
    when /^fechadesc/
      critord = "conscaso.fecha desc"
    when /^fecha/
      critord = "conscaso.fecha asc"
    when /^ubicaciondesc/
      critord = "conscaso.ubicaciones desc"
    when /^ubicacion/
      critord = "conscaso.ubicaciones asc"
    when /^codigodesc/
      critord = "conscaso.caso_id desc"
    when /^codigo/
      critord = "conscaso.caso_id asc"
    else
      raise(ArgumentError, "Ordenamiento invalido: #{ campo.inspect }")
    end
    critord += ", conscaso.caso_id"
    return critord
  end

  def self.consulta
    "SELECT detallefinanciero.id,
            detallefinanciero.actividad_id,
            detallefinanciero.proyectofinanciero_id,
            detallefinanciero.actividadpf_id,
            detallefinanciero.unidadayuda_id,
            detallefinanciero.cantidad,
            detallefinanciero.valorunitario,
            detallefinanciero.valortotal,
            detallefinanciero.mecanismodeentrega_id,
            detallefinanciero.modalidadentrega_id,
            detallefinanciero.tipotransferencia_id,
            detallefinanciero.frecuenciaentrega_id,
            detallefinanciero.numeromeses,
            detallefinanciero.numeroasistencia,
            ARRAY(SELECT persona_id FROM detallefinanciero_persona WHERE
              detallefinanciero_persona.detallefinanciero_id=detallefinanciero.id) AS persona_ids,
            cor1440_gen_actividad.objetivo AS actividad_objetivo,
            cor1440_gen_actividad.fecha AS fecha,
            (SELECT nombre FROM cor1440_gen_proyectofinanciero WHERE
              detallefinanciero.proyectofinanciero_id=cor1440_gen_proyectofinanciero.id) 
              AS conveniofinanciado_nombre,
            (SELECT nombre FROM cor1440_gen_actividadpf WHERE
              detallefinanciero.actividadpf_id=cor1440_gen_actividadpf.id) 
              AS actividadmarcologico_nombre
            FROM detallefinanciero JOIN cor1440_gen_actividad ON
              detallefinanciero.actividad_id=cor1440_gen_actividad.id
    "
  end

  def self.crea_consulta(ordenar_por = nil)
    if ARGV.include?("db:migrate")
      return
    end
    if ActiveRecord::Base.connection.data_source_exists? CONSULTA
      ActiveRecord::Base.connection.execute(
        "DROP MATERIALIZED VIEW IF EXISTS #{CONSULTA}")
    end
    if ordenar_por
      w += ' ORDER BY ' + self.interpreta_ordenar_por(ordenar_por)
    end
    ActiveRecord::Base.connection.execute("CREATE 
              MATERIALIZED VIEW #{CONSULTA} AS
              #{self.consulta}
              #{w} ;")
  end # def crea_consulta

  def self.refresca_consulta(ordenar_por = nil)
    if !ActiveRecord::Base.connection.data_source_exists? '#{CONSULTA}'
      crea_consulta(ordenar_por = nil)
    else
      ActiveRecord::Base.connection.execute(
        "REFRESH MATERIALIZED VIEW #{CONSULTA}")
    end
  end

end

