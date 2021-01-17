require_dependency "sivel2_sjr/concerns/controllers/mindicadorespf_controller"

module Cor1440Gen
  class MindicadorespfController < Sip::ModelosController

    include Sivel2Sjr::Concerns::Controllers::MindicadorespfController

    before_action :set_mindicadorpf, 
      only: [:show, :edit, :update, :destroy]
    load_and_authorize_resource class: Cor1440Gen::Mindicadorpf

    # PRM2020 R1I3 Número de personas (pueden ser repetidas)
    # Número de beneficiarios (contactos + familiares) en casos de 
    # actividades con acción jurídica'
    def medir_indicador_res_tipo_107(idacs, mind, fini, ffin)
      # se escogen solo las actividades que tienen accion juridica con 
      # plan estrategico 1. actividadpf 125
      datosint = []
      lac = Cor1440Gen::Actividad.where(id: idacs).
        joins(:actividadpf).
        where('cor1440_gen_actividadpf.id = 125').
        pluck(:id).uniq
      hombrescasos = calcula_benef_por_sexo(lac, 'M', ffin, false)
      mujerescasos = calcula_benef_por_sexo(lac, 'F', ffin, false)
      sinsexocasos = calcula_benef_por_sexo(lac, 'S', ffin, false)
      contactos = hombrescasos[0] + mujerescasos[0] + sinsexocasos[0]
      familiares = hombrescasos[1] + mujerescasos[1] + sinsexocasos[1]
      resind = contactos.count + familiares.count
      datosint << {valor: contactos.count, rutaevidencia: '#'}
      datosint << {valor: familiares.count, rutaevidencia: '#'}
      if contactos.count > 0 then
        datosint[0][:rutaevidencia] = sip.personas_path + 
          '?filtro[busid]=' + contactos.join(',')
      end
      if familiares.count > 0
        datosint[1][:rutaevidencia] = sip.personas_path + 
          '?filtro[busid]=' + familiares.join(',')
      end

      return {resind: resind, datosint: datosint}
    end

    # PRM2020 R1I4 porcentaje
    def medir_indicador_res_tipo_108(idacs, mind, fini, ffin)
      # Porcentaje de beneficiarios (contactos + familiares) de casos en 
      # actividades con acciones jurídicas respondidas (tanto positiva 
      # como negativamente)',
      datosint = []
      ## Vuelve a calcularse lo del tipo de indicador 107
      lac = Cor1440Gen::Actividad.where(id: idacs).
        joins(:actividadpf).
        where('cor1440_gen_actividadpf.id = 125').
        pluck(:id).uniq
      hombrescasos = calcula_benef_por_sexo(lac, 'M', ffin, false)
      mujerescasos = calcula_benef_por_sexo(lac, 'F', ffin, false)
      sinsexocasos = calcula_benef_por_sexo(lac, 'S', ffin, false)
      contactos = hombrescasos[0] + mujerescasos[0] + sinsexocasos[0]
      familiares = hombrescasos[1] + mujerescasos[1] + sinsexocasos[1]
      universo_conaj = contactos.count + familiares.count

      contactos_conres = []
      familiares_conres = []
      # De las actividades filtradas, extrae donde haya formulario
      # de ACCION JURIDICA con respuesta SI o NO  en campo con
      # opciones de tabal trivalentepositiva
      resp_ids = Mr519Gen::Respuestafor.
        joins('JOIN cor1440_gen_actividad_respuestafor ' +
              'ON respuestafor_id=mr519_gen_respuestafor.id').
        where('cor1440_gen_actividad_respuestafor.actividad_id' => lac).
        where(formulario_id: 14). # ACCION JURÍDICA
        joins('JOIN mr519_gen_valorcampo ON ' +
              'mr519_gen_valorcampo.respuestafor_id=mr519_gen_respuestafor.id').
        joins('JOIN mr519_gen_campo ON ' +
              'mr519_gen_valorcampo.campo_id=mr519_gen_campo.id').
        where('(mr519_gen_campo.tablabasica = \'trivalentespositiva\' AND ' +
              '(mr519_gen_valorcampo.valor = \'2\' OR ' + # POSITIVA
              'mr519_gen_valorcampo.valor = \'3\')) OR ' + # NEGATIVA
              '(mr519_gen_campo.tablabasica = \'trivalentes\' AND ' +
              '(mr519_gen_valorcampo.valor = \'2\' OR ' + # POSITIVA
              'mr519_gen_valorcampo.valor = \'3\'))'). # NEGATIVA
        pluck(:'cor1440_gen_actividad_respuestafor.actividad_id').uniq
      hombrescasos_conr = calcula_benef_por_sexo(resp_ids, 'M', ffin, false)
      mujerescasos_conr = calcula_benef_por_sexo(resp_ids, 'F', ffin, false)
      sinsexocasos_conr = calcula_benef_por_sexo(resp_ids, 'S', ffin, false)
      contactos_conres = hombrescasos_conr[0] + mujerescasos_conr[0] + 
        sinsexocasos_conr[0]
      familiares_conres = hombrescasos_conr[1] + mujerescasos_conr[1] + 
        sinsexocasos_conr[1]

      res_res = contactos_conres.count + familiares_conres.count
      resind = (res_res.to_f * 100)/universo_conaj

      datosint << {valor: contactos_conres.count, rutaevidencia: '#'}
      datosint << {valor: familiares_conres.count, rutaevidencia: '#'}
      if contactos_conres.count > 0 then
        datosint[0][:rutaevidencia] = sip.personas_path + '?filtro[busid]=' + 
          contactos_conres.join(',')
      end
      if familiares_conres.count > 0
        datosint[1][:rutaevidencia] =  sip.personas_path + '?filtro[busid]=' + 
          familiares_conres.join(',')
      end
      
      # Valdria la pena agregar como intermedio al menos la cuenta del
      # universo de casos con accion juridica considerados?
      # datosint << {valor: universo_conaj, rutaevidencia: '#'}

      return {resind: resind, datosint: datosint}
    end

    # PRM2020 R1I5 Cuenta beneficiarios de casos  que 
    def medir_indicador_res_tipo_109(idacs, mind, fini, ffin)
      datosint = []
      if mind.actividadpf_ids.sort != [350, 423, 424, 425]
        puts 'Este tipo de indicador es muy especifico de PRM 2020'
        return {resind: -1, datosint: []}
      end
      res = mind.indicadorpf.resultadopf
      actpf1 = res.actividadpf.where(id: 350)  # R1A3 de PRM2020
      actpf2 = res.actividadpf.where(id: 423)  # R1A6 de PRM2020
      actpf3 = res.actividadpf.where(id: 424)  # R1A7 de PRM2020
      actpf4 = res.actividadpf.where(id: 425)  # R1A8 de PRM2020

      if actpf1.count == 0 && actpf2.count == 0 && actpf2.count == 0 && 
          actpf4.count == 0
        puts 'Falta en marco logico actividadpf con id 350'
        return {resind: -1, datosint: []}
      end
      lac1 = calcula_listado_ac(actpf1, fini, ffin)
      lac2 = calcula_listado_ac(actpf2, fini, ffin)
      lac3 = calcula_listado_ac(actpf3, fini, ffin)
      lac4 = calcula_listado_ac(actpf4, fini, ffin)

      hombres1 = calcula_benef_por_sexo(lac1, 'M', ffin, false)
      mujeres1 = calcula_benef_por_sexo(lac1, 'F', ffin, false)
      sinsexo1 = calcula_benef_por_sexo(lac1, 'S', ffin, false)
      directos1 = hombres1[0] + mujeres1[0] + sinsexo1[0] + hombres1[1] + 
        mujeres1[1] + sinsexo1[1]
      indirectos1 = []

      datosint << {valor: directos1.count, rutaevidencia: '#'}
      if directos1.count > 0
        datosint[datosint.count-1][:rutaevidencia] = sip.personas_path + 
          '?filtro[busid]=' + directos1.join(',')
      end

      hombres2 = calcula_benef_por_sexo(lac2, 'M', ffin, false)
      mujeres2 = calcula_benef_por_sexo(lac2, 'F', ffin, false)
      sinsexo2 = calcula_benef_por_sexo(lac2, 'S', ffin, false)
      directos2 = hombres2[0] + mujeres2[0] + sinsexo2[0] + hombres2[1] + 
        mujeres2[1] + sinsexo2[1]
      indirectos2 = []

      datosint << {valor: directos2.count, rutaevidencia: '#'}
      if directos2.count > 0
        datosint[datosint.count-1][:rutaevidencia] = sip.personas_path + 
          '?filtro[busid]=' + directos2.join(',')
      end

      hombres3 = calcula_benef_por_sexo(lac3, 'M', ffin, false)
      mujeres3 = calcula_benef_por_sexo(lac3, 'F', ffin, false)
      sinsexo3 = calcula_benef_por_sexo(lac3, 'S', ffin, false)
      grupo3 = hombres3[0] + mujeres3[0] + sinsexo3[0] +
        hombres3[1] + mujeres3[1] + sinsexo3[1]
      menores = []
      mayores = []
      grupo3.each do |f|
        per = Sip::Persona.find(f)
        hoy = Date.today.to_s.split('-')
        edad_ben = Sivel2Gen::RangoedadHelper.
          edad_de_fechanac_fecha(per.anionac, per.mesnac, per.dianac, 
                                 hoy[0].to_i, hoy[1].to_i, hoy[2].to_i)
        if 0<= edad_ben && edad_ben < 18
          menores.push(f)
        elsif edad_ben >= 18
          mayores.push(f)
        end
      end
      if menores.any?
        directos3 = menores
        indirectos3 = mayores
      else
        directos3 = mayores
        indirectos3 = []
      end

      datosint << {valor: directos3.count, rutaevidencia: '#'}
      if directos3.count > 0
        datosint[datosint.count-1][:rutaevidencia] = sip.personas_path + 
          '?filtro[busid]=' + directos3.join(',')
      end
      datosint << {valor: indirectos3.count, rutaevidencia: '#'}
      if indirectos3.count > 0
        datosint[datosint.count-1][:rutaevidencia] = sip.personas_path + 
          '?filtro[busid]=' + indirectos3.join(',')
      end

      hombres4 = calcula_benef_por_sexo(lac4, 'M', ffin, false)
      mujeres4 = calcula_benef_por_sexo(lac4, 'F', ffin, false)
      sinsexo4 = calcula_benef_por_sexo(lac4, 'S', ffin, false)
      directos4 = hombres4[0] + mujeres4[0] + sinsexo4[0]
      datosint << {valor: directos4.count, rutaevidencia: '#'}
      # Sin evidencia para no sugerir que quien murió fue el contacto
      # Sería mejor como evidencia el listado de casos
      indirectos4 = hombres4[1] + mujeres4[1] + sinsexo4[1]
      datosint << {valor: indirectos4.count, rutaevidencia: '#'}
      # Sin evidencia para no sugerir que quienes vivieron fueron todos los
      # familiares
      # Sería mejor como evidencia el listado de casos

      directos = directos1 + directos2 + directos3 + directos4
      indirectos = indirectos1 + indirectos2 + indirectos3 + indirectos4

      resind = directos.count + indirectos.count
      datosint << {valor: directos.count, rutaevidencia: '#'}
      if directos.count > 0
        datosint[datosint.count-1][:rutaevidencia] = sip.personas_path + 
          '?filtro[busid]=' + directos.join(',')
      end
      datosint << {valor: indirectos.count, rutaevidencia: '#'}
      if indirectos.count > 0
        datosint[datosint.count-1][:rutaevidencia] = sip.personas_path + 
          '?filtro[busid]=' + indirectos.join(',')
      end

      return {resind: resind, datosint: datosint}
    end

    
    # R2I4 Cuenta lactantes, bebés menores a un año y doble de mujeres gestantes
    def medir_indicador_res_tipo_110(idacs, mind, fini, ffin)
    # reciben ayuda humanitaria de emergencia con reglas 
    # y actividades de PRM 2020',
      def calcula_maternidad(idacs, idmat)
        return Sivel2Gen::Victima.
          joins('JOIN sivel2_sjr_victimasjr ON sivel2_gen_victima.id=sivel2_sjr_victimasjr.id_victima').
          joins('JOIN sip_persona ON sip_persona.id=sivel2_gen_victima.id_persona').
          joins('JOIN sivel2_sjr_actividad_casosjr ON casosjr_id=sivel2_gen_victima.id_caso').
          where(:'sivel2_sjr_actividad_casosjr.actividad_id' => idacs).
          where(:'sivel2_sjr_victimasjr.id_maternidad' => idmat).
          pluck('id_persona').uniq
      end

      def calcula_bebes(idacs, ffin)
        bebes = []

        Cor1440Gen::Actividad.where(id: idacs).each do |act|
          anio_ac = act.fecha.year
          mes_ac = act.fecha.month
          dia_ac = act.fecha.day
          act.actividad_casosjr.each do |acaso|
            acaso.casosjr.caso.victima.each do |victima|
              if acaso.casosjr.contacto_id != victima.id_persona # Beneficiario
                per = victima.persona
                edad_ben = Sivel2Gen::RangoedadHelper.
                  edad_de_fechanac_fecha(per.anionac, per.mesnac, per.dianac, 
                                         anio_ac, mes_ac, dia_ac)
                if edad_ben == 0
                  bebes.push(per.id)
                end
              end
            end
          end
        end
        return bebes
      end

      datosint = []
      bebes_presentes = calcula_bebes(idacs, ffin)
      bebes_total = bebes_presentes.count
      lactantes = calcula_maternidad(idacs, 2)
      lactantes_total = lactantes.count
      gest = calcula_maternidad(idacs, 1)
      gest_total = gest.count * 2
      resind = lactantes_total + gest_total + bebes_total
      datosint << {valor: lactantes_total, rutaevidencia: '#'}
      datosint << {valor: gest_total, rutaevidencia: '#'}
      datosint << {valor: bebes_total, rutaevidencia: '#'}
      if lactantes.count > 0
        datosint[0][:rutaevidencia]= sip.personas_path + '?filtro[busid]=' + 
          lactantes.join(',')
      end
      if gest.count > 0
        datosint[1][:rutaevidencia]= sip.personas_path + '?filtro[busid]=' + 
          gest.join(',')
      end
      if bebes_presentes.count > 0
        datosint[2][:rutaevidencia]= sip.personas_path + '?filtro[busid]=' + 
          bebes_presentes.join(',')
      end
      return {resind: resind, datosint: datosint}
    end

  end
end
