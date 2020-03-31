require_dependency "sivel2_sjr/concerns/controllers/mindicadorespf_controller"

module Cor1440Gen
  class MindicadorespfController < Sip::ModelosController

    include Sivel2Sjr::Concerns::Controllers::MindicadorespfController

    # Indicadores de PRM20 que no tienen tipo
    def mideindicador_PRM20(mind, ind, fini, ffin)
      res = ind.resultadopf
      actpf = [] 
      
      resind = -1
      hombres = -1
      mujeres = -1
      sinsexo = -1
     
      case ind.id
      when 214 # R1I3 Número de personas (pueden ser repetidas)
        actpf = res.actividadpf.where(id: 348)  
        if actpf.count == 0
          puts 'Falta en marco logico actividadpf con id 348'
          return [ -1, '#', -1, '#', -1, '#', -1, '#']
        end
        ## se escogen solo las actividades que tienen accion juridica con 
        ## plan estrategico 1. actividadpf 125
        lact = calcula_listado_ac(actpf, fini, ffin)
        lac = Cor1440Gen::Actividad.where(id: lact).
          joins(:actividadpf).
          where('cor1440_gen_actividadpf.id = 125').
          pluck(:id).uniq
        hombrescasos = calcula_benef_por_sexo(lac, 'M', ffin, false)
        mujerescasos = calcula_benef_por_sexo(lac, 'F', ffin, false)
        sinsexocasos = calcula_benef_por_sexo(lac, 'S', ffin, false)
        benef_dir = hombrescasos[0] + mujerescasos[0] + sinsexocasos[0]
        benef_indir = hombrescasos[1] + mujerescasos[1] + sinsexocasos[1]
        resind = benef_dir.count + benef_indir.count
        if lac.count > 0 then
          urlevrind = cor1440_gen.actividades_url +
            '?filtro[busid]='+lac.join(',')
        end
        urlevdir = '#'
        if benef_dir.count > 0 then
          urlevdir = sip.personas_url + '?filtro[busid]=' + benef_dir.join(',')
        end
        urlevindir = '#'
        if benef_indir.count > 0
          urlevindir = sip.personas_url + '?filtro[busid]=' + 
            benef_indir.join(',')
        end

        return [ resind, urlevrind, 
                 benef_dir.count, urlevdir, 
                 benef_indir.count, urlevindir, 
                 -1, '#' ]
      when 215 # R1I4 porcentaje
        actpf = res.actividadpf.where(id: 348)  # Relacionada con R1A1
        contar = :porcentaje

        return [ resind, urlevrind, 
                 benef_dir, urlevdir, 
                 benef_indir, urlevindir, 
                 -1, '#' ]

      when 216 # R1I5 Número de personas
        actpf = res.actividadpf.where(id: 350)  # R1A3

        return [ resind, urlevrind, 
                 benef_dir, urlevdir, 
                 benef_indir, urlevindir, 
                 -1, '#' ]

          
      when 222 # R2I4 Número de mujeres gestantes o lactantes
        actpf = res.actividadpf.where(id: 357)  # R2A5
        if actpf.count == 0
          puts 'Falta en marco logico actividadpf con id 348'
          return [ -1, '#', -1, '#', -1, '#', -1, '#']
        end
        lact = calcula_listado_ac(actpf, fini, ffin)
        lac = lact.pluck(:id).uniq
        
        def calcula_maternidad(lac, idmat)
          meternidad = Sivel2Gen::Victima.
            joins('JOIN sivel2_sjr_victimasjr ON sivel2_gen_victima.id=sivel2_sjr_victimasjr.id_victima').
            joins('JOIN sip_persona ON sip_persona.id=sivel2_gen_victima.id_persona').
            joins('JOIN sivel2_sjr_actividad_casosjr ON casosjr_id=sivel2_gen_victima.id_caso').
            where(:'sivel2_sjr_actividad_casosjr.actividad_id' => lac).
            where(:'sivel2_sjr_victimasjr.id_maternidad' => idmat).pluck('id_persona').uniq
        end
        
        def calcula_bebes(lac, ffin)
          bebes = []
     
          Cor1440Gen::Actividad.where(id: lac).each do |act|
            anio_ac = act.fecha.year
            mes_ac = act.fecha.month
            dia_ac = act.fecha.day
            act.casos.each do |caso|
              caso.victima.each do |victima|
                if Sivel2Sjr::Casosjr.find(caso.id).contacto_id != victima.persona_id # Beneficiario
                  per = victima.persona
                  edad_ben = Sivel2Gen::RangoedadHelper.
                    edad_de_fechanac_fecha(per.anionac, per.mesnac, per.dianac, anio_ac, mes_ac, dia_ac)
                  if edad_ben == 0
                    bebes.push(per.id)
                  end
                end
              end
            end
          end
          return bebes
        end

        bebes_presentes = calcula_bebes(lac, ffin)
        bebes_total = bebes_presentes.count
        lact = calcula_maternidad(benef, 2)
        lact_total = lact.count
        gestantes = calcula_maternidad(benef, 1)
        gest_total = gestantes.count * 2
        resind = lact_total + gest_total + bebes_total

        if lac.count > 0
          urlevrind = cor1440_gen.actividades_url +
            '?filtro[busid]='+lac.join(',')
        end
        urlevbebes = '#'
        if bebes_presentes.count > 0
          urlevbebes = sip.personas_url + '?filtro[busid]=' + bebes_presentes.join(',')
        end
        urlevlact = '#'
        if lact.count > 0
          urlevlact = sip.personas_url + '?filtro[busid]=' + 
            lact.join(',')
        end
        urlevgest = '#'
        if gest.count > 0
          urlevgest = sip.personas_url + '?filtro[busid]=' + 
            gest.join(',')
        end

        return [ resind, urlevrind,
                 lact_total, urlevlact,
                 gest_total, urlevgest,
                 bebes_total, urlevbebes,
               ]
     
      end

      return [-1, '#', -1, '#', -1, '#', -1, '#']
    end


    def mideindicador_particular(mind, ind, fini, ffin)
      if ind.proyectofinanciero_id == 181 && ( # PRM
          ind.id == 214 || # R1I3
          ind.id == 215 || # R1I4
          ind.id == 216 || # R1I5
          ind.id == 222) then  # R2I4
        return mideindicador_PRM20(mind, ind, fini, ffin)
      elsif ind.proyectofinanciero_id == 181 && ( # PRM
        ind.id == 225 || # R2I7 No son de efecto
        ind.id == 230 || # R3I4 No es de efecto
        # R4I1 No se mide
        ind.id == 232 ) # R4I3 No es de efecto
        return [-1, '#', -1, '#', -1, '#', -1, '#']
      end
        
      # Los demás de este convenio se miden con tipos de indicador 
      # Tipo 1: R1I6, R1I7, R2I1, R2I8, R3I1
      # Tipo 4: R1I2, R2I6 
      # Tipo 30: R1I1, R2I3, R3I2, R3I3, R4I2
      # Tipo 31: R2I2, R2I5, R4I4
      return mideindicador_sivel2_sjr(mind, ind,fini, ffin)
    end

  end
end
