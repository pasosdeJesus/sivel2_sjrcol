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

    # PRESENTACIÓN DE INFORMACIÓN


    # Retorna el primero
    def busca_indicador_gifmm
      idig = nil
      proyectofinanciero.find do |p| 
        p.actividadpf.find do |a|
          if a.indicadorgifmm_id
            idig = a.indicadorgifmm.id
            true
          else
            false
          end
        end
      end
      idig
    end

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

    def socio_principal
      sp = ''
      proyectofinanciero.find do |p| 
        if p.financiador && p.financiador.count > 0 && sp == ''
          if p.financiador[0].nombregifmm
            sp = p.financiador[0].nombregifmm
          else
            sp = p.financiador[0].nombre
          end
        end
      end
      sp
    end

    def poblacion
      p1 = poblacion_cor1440_gen
      p2 = 0
      idp_casos = casosjr.map {|c|
        c.caso.victima.map(&:id_persona)
      }.flatten.uniq
      idp_asistentes = asistencia.map(&:persona_id)
      idp = idp_casos + idp_asistentes
      idp.uniq!
      p2 += idp.count
      if p1 >= p2
        p1.to_s
      else
        "#{p1} pero se esperaba al menos #{p2}"
      end
    end

    def poblacion_nueva
      p = 0
      idp_casos = casosjr.select {|c|
        c.caso.fecha.at_beginning_of_month >= self.fecha.at_beginning_of_month
      }.map {|c|
        c.caso.victima.map(&:id_persona)
      }.flatten.uniq
      idp_asistentes = asistencia.select {|a| 
        Sivel2Gen::Victima.where(id_persona: a.persona_id).count > 0 &&
          Sivel2Gen::Victima.where(id_persona: a.persona_id).take.caso.
          fecha.at_beginning_of_month >= self.fecha.at_beginning_of_month
      }.map(&:persona_id)
      idp = idp_casos + idp_asistentes
      idp.uniq!
      return idp.count
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

      when 'estado'
        'En proceso'

      when 'departamento'
        if ubicacionpre && ubicacionpre.departamento
          ubicacionpre.departamento.nombre
        else
          ''
        end

      when 'indicador_gifmm'
        idig = self.busca_indicador_gifmm
        if idig != nil
          ::Indicadorgifmm.find(idig).nombre
        else
          ''
        end

      when 'num_afrodescendientes'
        cuenta_victimas_condicion {|v|
          v.etnia.nombre  == 'AFRODESCENDIENTE' || 
          v.etnia.nombre == 'NEGRO'
        }

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

      when 'parte_rmrp'
        'SI'

      when 'poblacion_hombres'
        actividad_rangoedadac.inject(0) { |memo, r|
          memo += r.mr ? r.mr : 0
          memo += r.ml ? r.ml : 0
          memo
        }

      when 'poblacion_mujeres'
        actividad_rangoedadac.inject(0) { |memo, r|
          memo += r.fl ? r.fl : 0
          memo += r.fr ? r.fr : 0
          memo
        }

      when 'poblacion_sin_sexo'
        actividad_rangoedadac.inject(0) { |memo, r|
          memo += r.s ? r.s : 0
          memo
        }

      when 'sector_gifmm'
        idig = self.busca_indicador_gifmm
        if idig != nil
          ::Indicadorgifmm.find(idig).sectorgifmm.nombre
        else
          ''
        end

      when 'socio_implementador'
        if socio_principal == 'SJR-COL'
          ''
        else
          'SJR-COL'
        end

      when 'tipo_implementacion'
        if socio_principal == 'SJR-COL'
          'Directa'
        else
          'Indirecta'
        end

      when 'ubicacion'
        lugar

      else
        presenta_actividad(atr)
      end
    end
  end
end
