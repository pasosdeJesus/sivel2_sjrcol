# frozen_string_literal: true

require 'sivel2_sjr/concerns/models/actividad'

module Cor1440Gen
  class Actividad < ActiveRecord::Base
    include Sivel2Sjr::Concerns::Models::Actividad

    belongs_to :ubicacionpre, class_name: '::Sip::Ubicacionpre',
      foreign_key: 'ubicacionpre_id', optional: true
    has_many :detallefinanciero, dependent: :delete_all,
      class_name: 'Detallefinanciero',
      foreign_key: 'actividad_id'
    accepts_nested_attributes_for :detallefinanciero,
      allow_destroy: true, reject_if: :all_blank


    attr_accessor :ubicacionpre_texto
    attr_accessor :ubicacionpre_mundep_texto

    def ubicacionpre_texto
      if self.ubicacionpre
        self.ubicacionpre.nombre
      else
        ''
      end
    end


    def ubicacionpre_mundep_texto
      if self.ubicacionpre
        self.ubicacionpre.nombre_sin_pais
      else
        ''
      end
    end

    validate :valida_beneficiarios
    validate :no_asistentes_repetidos
    validate :no_casos_repetidos

    def no_asistentes_repetidos
      asistentes = []
      victimas = []
      self.asistencia.map{ |as| asistentes.push(as.persona_id) }
      self.actividad_casosjr.map{|cas| 
        victimas.push(Sivel2Gen::Victima.where(id_caso: cas.casosjr.id_caso).
                      pluck(:id_persona))
      }
      if (asistentes & victimas.flatten).length > 0
        repetidos = Sip::Persona.where(id: asistentes & victimas.flatten).map{
          |n| n.nombres + " " + n.apellidos + 
            " en listado de asistencia y en caso " + 
            Sivel2Sjr::Casosjr.where(contacto_id: n.id).
            pluck(:id_caso)[0].to_s
        }
        errors.add(
          :asistencia, "Personas repetidas entre listado de casos " +
          "(contacto o familiares) y asistencia: " + repetidos.join(", ")) 
      end
      if asistentes.length != asistentes.uniq.length
        asrepetidos = []
        asrepetidos.push(asistentes.detect{ |e| asistentes.count(e) > 1 })
        nombres =  Sip::Persona.where(id: asrepetidos).map{
          |n| n.nombres + " " + n.apellidos
        }
        errors.add(:asistencia, "En listado de asistencia se encuentra " +
                   "repetido: " + nombres.join(", ")) 
      end 
    end

    def no_casos_repetidos
      casos = []
      casrepetidos = []
      self.actividad_casosjr.map{|caso| casos.push(caso.casosjr.id_caso)}
      if casos.length != casos.uniq.length
        casrepetidos.push(casos.detect{ |e| casos.count(e) > 1 })
        errors.add(
          :casosjr, 
          "En listado de casos se encuentran repetidos los casos con id(s): " +
          casrepetidos.join(", ")) 
      end
    end

    def valida_beneficiarios
      pact = []
      self.detallefinanciero.map{
        |t| t.persona_ids.map{ |per| 
          if t.actividadpf_id
            pact.push([per, t.actividadpf_id])
          end
        }
      }
      if pact.length != pact.uniq.length
        errors.add(:persona, "En Detalle Financiero no se puden repetir " +
                   "personas si la actividad de Marco lógico es la misma") 
      end 
    end 

    # PRESENTACIÓN DE INFORMACIÓN

    def cuenta_victimas_condicion
      cuenta = 0
      casosjr.each do |c|
        c.caso.victima.each do |v|
          if (yield(v))
            cuenta += 1
          end
        end
      end
      cuenta
    end

    # Auxiliar que retorna listado de identificaciones de personas de 
    # las víctimas del listado de casos que cumplan una condición
    def personas_victimas_condicion
      ids = []
      self.casosjr.each do |c|
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
      self.asistencia.each do |a| 
        if (yield(a))
          ids << a.persona_id
        end
      end
      ids
    end

    def poblacion_ids
      idp = personas_victimas_condicion {|v| true}
      idp += personas_asistentes_condicion {|a| true}
      idp.uniq!
      idp.join(",")
    end

    def poblacion
      p1 = poblacion_cor1440_gen
      p2 = poblacion_ids.split(",").count
      if p1 >= p2
        p1.to_s
      else
        "#{p1} pero se esperaban al menos #{p2}"
      end
    end

    def poblacion_nuevos_ids
      idp = casosjr.select {|c|
        c.caso.fecha.at_beginning_of_month >= self.fecha.at_beginning_of_month
      }.map {|c|
        c.caso.victima.map(&:id_persona)
      }.flatten.uniq
      idp += personas_asistentes_condicion {|a| 
        Sivel2Gen::Victima.where(id_persona: a.persona_id).count > 0 &&
          Sivel2Gen::Victima.where(id_persona: a.persona_id).take.caso.fecha.
            at_beginning_of_month >= self.fecha.at_beginning_of_month
      }
      idp.uniq!
      idp.join(",")
    end


    def poblacion_nuevos
      poblacion_nuevos_ids.split(",").count
    end

    def poblacion_colombianos_retornados_ids
      idcol = Sip::Pais.where(nombre: 'COLOMBIA').take.id
      idp = casosjr.select {|c|
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
      idp = casosjr.select {|c|
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

    def poblacion_vocacion_permanencia_ids
      poblacion_perfil_migracion_ids('CON VOCACIÓN DE PERMANENCIA')
    end

    def poblacion_vocacion_permanencia
      poblacion_vocacion_permanencia_ids.split(",").count
    end


    def  poblacion_r_g(sexo, num)
      idp = personas_victimas_condicion {|v| 
        if v.persona.sexo == sexo
          e = Sivel2Gen::RangoedadHelper.edad_de_fechanac_fecha(
            v.persona.anionac, v.persona.mesnac, v.persona.dianac,
            fecha.year, fecha.month, fecha. day)
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
            fecha.year, fecha.month, fecha. day)
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
      l = poblacion_mujeres_r_g_ids(4).split(",") + 
        poblacion_mujeres_r_g_ids(5).split(",")
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

    def presenta(atr)
      case atr.to_s
      when 'beneficiarios_com_acogida'
        self.asistencia.select{|a| a.perfilactorsocial_id == 13}.count

      when 'covid19'
        if self.covid
          'Si'
        else
          'No'
        end

      when 'departamento'
        if ubicacionpre && ubicacionpre.departamento
          ubicacionpre.departamento.nombre
        else
          ''
        end

      when 'departamento_altas_bajas'
        if ubicacionpre && ubicacionpre.departamento
          ubicacionpre.departamento.nombre.altas_bajas
        else
          ''
        end

      when 'listado_casos_ids'
        casosjr_ids.join(', ')

      when 'numero_detalles_financieros'
        detallefinanciero.count

      when 'detalles_financieros_ids'
        detallefinanciero_ids.join(', ')

      when 'organizaciones_sociales_ids'
        actorsocial_ids.join(', ')

      when 'mes'
        if fecha
          Sip::FormatoFechaHelper::MESES[fecha.month]
        else
          ''
        end

      when 'municipio'
        if ubicacionpre && ubicacionpre.municipio
          ubicacionpre.municipio.nombre
        else
          ''
        end

      when 'municipio_altas_bajas'
        if ubicacionpre && ubicacionpre.municipio
          ubicacionpre.municipio.nombre.altas_bajas
        else
          ''
        end


      when 'num_afrodescendientes'
        cuenta_victimas_condicion {|v|
          v.etnia.nombre  == 'AFRODESCENDIENTE' || 
          v.etnia.nombre == 'NEGRO'
        }

      when 'num_con_discapacidad'
        cuenta_victimas_condicion { |v|
          vs = Sivel2Sjr::Victimasjr.where(id_victima: v.id)
          vs.count > 0 && vs.take.discapacidad &&
            vs.take.discapacidad && vs.take.discapacidad.nombre != 'NINGUNA'
        }

      when 'num_con_discapacidad_ids'
        idp = personas_victimas_condicion { |v|
          vs = Sivel2Sjr::Victimasjr.where(id_victima: v.id)
          vs.count > 0 && vs.take.discapacidad &&
            vs.take.discapacidad && vs.take.discapacidad.nombre != 'NINGUNA'
        }
        idp += personas_asistentes_condicion {|a|
          if Sivel2Gen::Victima.where(id_persona: a.persona_id).count > 0
            v = Sivel2Gen::Victima.where(id_persona: a.persona_id).take
            vs = Sivel2Sjr::Victimasjr.where(id_victima: v.id)
            vs.count > 0 && vs.take.discapacidad &&
              vs.take.discapacidad && vs.take.discapacidad.nombre != 'NINGUNA'
          else
            false
          end
        }
        idp.uniq!
        idp.join(",")
 
      when 'num_indigenas'
        cuenta_victimas_condicion { |v|
          v.etnia.nombre  != 'AFRODESCENDIENTE' &&
          v.etnia.nombre != 'NEGRO' &&
          v.etnia.nombre != 'ROM' &&
          v.etnia.nombre != 'MESTIZO' &&
          v.etnia.nombre != 'SIN INFORMACIÓN'
        }

      when 'num_lgbti'
        cuenta_victimas_condicion { |v|
          v.orientacionsexual != 'H'
        }

      when 'num_otra_etnia'
        cuenta_victimas_condicion { |v|
          v.etnia.nombre == 'ROM' ||
          v.etnia.nombre == 'MESTIZO' ||
          v.etnia.nombre == 'SIN INFORMACIÓN'
        }

      when 'poblacion_hombres_adultos'
        p1 = poblacion_hombres_r_g_solore(4) +
          poblacion_hombres_r_g_solore(5) + poblacion_hombres_r_g_solore(6)
        p2 = poblacion_hombres_adultos_ids.split(",").count
        if p1 >= p2
          p1.to_s
        else
          "#{p1} pero se esperaban al menos #{p2}"
        end

      when 'poblacion_hombres_l'
        poblacion_gen_infijo('hombres_l')

      when 'poblacion_hombres_l_r'
        actividad_rangoedadac.inject(0) { |memo, r|
          memo += r.fl ? r.fl : 0
          memo += r.fr ? r.fr : 0
          memo
        }

      when /^poblacion_hombres_l_g[0-9]*$/
        g = atr[21..-1].to_i
        poblacion_gen_infijo('hombres_l_g', g)

      when 'poblacion_hombres_r'
        poblacion_gen_infijo('hombres_r')

      when /^poblacion_hombres_r_g[0-9]*$/
        g = atr[21..-1].to_i
        poblacion_gen_infijo('hombres_r_g', g)

      when /^poblacion_hombres_r_g[0-9]*_ids$/
        g = atr[21..-4].to_i
        poblacion_hombres_r_g_ids(g)

      when /^poblacion_hombres_r_g_4_5*$/
        p1 = poblacion_hombres_r_g_solore(4)+poblacion_hombres_r_g_solore(5)
        p2 = poblacion_hombres_r_g_4_5_ids.split(",").count
        if p1 >= p2
          p1.to_s
        else
          "#{p1} pero se esperaban al menos #{p2}"
        end

      when 'poblacion_mujeres_adultas'
        p1 = poblacion_mujeres_r_g_solore(4) +
          poblacion_mujeres_r_g_solore(5) + poblacion_mujeres_r_g_solore(6)
        p2 = poblacion_mujeres_adultas_ids.split(",").count
        if p1 >= p2
          p1.to_s
        else
          "#{p1} pero se esperaban al menos #{p2}"
        end

      when 'poblacion_mujeres_l'
        poblacion_gen_infijo('mujeres_l')

      when 'poblacion_mujeres_l_r'
        actividad_rangoedadac.inject(0) { |memo, r|
          memo += r.fl ? r.fl : 0
          memo += r.fr ? r.fr : 0
          memo
        }

      when 'poblacion_mujeres_r'
        poblacion_gen_infijo('mujeres_r')

      when /^poblacion_mujeres_l_g[0-9]*$/
        g = atr[21..-1].to_i
        poblacion_gen_infijo('mujeres_l_g', g)

      when /^poblacion_mujeres_r_g[0-9]*$/
        g = atr[21..-1].to_i
        poblacion_gen_infijo('mujeres_r_g', g)

      when /^poblacion_mujeres_r_g[0-9]*_ids$/
        g = atr[21..-4].to_i
        poblacion_mujeres_r_g_ids(g)

      when /^poblacion_mujeres_r_g_4_5*$/
        p1 = poblacion_mujeres_r_g_solore(4)+poblacion_mujeres_r_g_solore(5)
        p2 = poblacion_mujeres_r_g_4_5_ids.split(",").count
        if p1 >= p2
          p1.to_s
        else
          "#{p1} pero se esperaban al menos #{p2}"
        end

      when 'poblacion_niñas_adolescentes_y_se'
        p1 = poblacion_mujeres_r_g_solore(1) +
          poblacion_mujeres_r_g_solore(2) + poblacion_mujeres_r_g_solore(3) +
          poblacion_mujeres_r_g_solore(7)
        p2 = poblacion_ninas_adolescentes_y_se_ids.split(",").count
        if p1 >= p2
          p1.to_s
        else
          "#{p1} pero se esperaban al menos #{p2}"
        end

      when 'poblacion_niñas_adolescentes_y_se_ids'
        poblacion_ninas_adolescentes_y_se_ids

      when 'poblacion_niños_adolescentes_y_se'
        p1 = poblacion_hombres_r_g_solore(1) +
          poblacion_hombres_r_g_solore(2) + poblacion_hombres_r_g_solore(3) +
          poblacion_hombres_r_g_solore(7)
        p2 = poblacion_ninos_adolescentes_y_se_ids.split(",").count
        if p1 >= p2
          p1.to_s
        else
          "#{p1} pero se esperaban al menos #{p2}"
        end

      when 'poblacion_niños_adolescentes_y_se_ids'
        poblacion_ninos_adolescentes_y_se_ids.split(",").count


      when 'poblacion_sinsexo'
        poblacion_gen_infijo('sinsexo')

      when 'poblacion_sinsexo_adultos'
        p1 = poblacion_sinsexo_g_solore(4) +
          poblacion_sinsexo_g_solore(5) + poblacion_sinsexo_g_solore(6)
        p2 = poblacion_sinsexo_adultos_ids.split(",").count
        if p1 >= p2
          p1.to_s
        else
          "#{p1} pero se esperaban al menos #{p2}"
        end

      when 'poblacion_sinsexo_menores'
        p1 = poblacion_sinsexo_g_solore(1) +
          poblacion_sinsexo_g_solore(2) + poblacion_sinsexo_g_solore(3) +
          poblacion_sinsexo_g_solore(7)
        p2 = poblacion_sinsexo_menores_ids.split(",").count
        if p1 >= p2
          p1.to_s
        else
          "#{p1} pero se esperaban al menos #{p2}"
        end

      when /^poblacion_sinsexo_g[0-9]*$/
        g = atr[21..-1].to_i
        poblacion_gen_infijo('sinsexo_g', g)

      else
        presenta_actividad(atr)
      end
    end
  end
end
