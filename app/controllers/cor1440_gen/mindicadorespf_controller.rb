require_dependency "cor1440_gen/concerns/controllers/mindicadorespf_controller"

module Cor1440Gen
  class MindicadorespfController < Sip::ModelosController

    include Cor1440Gen::Concerns::Controllers::MindicadorespfController

    def mideindicador_PRM20(ind, fini, ffin)
      res = ind.resultadopf
      actpf = [] 
      
      resind = -1
      hombres = -1
      mujeres = -1
      sinsexo = -1
     
      # Retorna listado de ids diferentes de 
      # actividades con actividadpf actpf en un rango de tiempo 
      def calcula_lac(actpf, fini, ffin)
        lac = Cor1440Gen::Actividad.joins(:actividadpf).
          where('cor1440_gen_actividadpf.id=?', actpf.take.id).
          where('fecha >= ?', fini).
          where('fecha <= ?', ffin).
          pluck(:id).uniq
      end

      # Calcula beneficiarios diferentes con el sexo `sexo` no desagregados
      # antes de la fecha `ffin en casos beneficiarios de actividades con ids 
      # `lac`
      # Retorna ids diferentes de beneficiarios directos y 
      #   ids diferentes de beneficiarios indirectos
      def calcula_benef_por_sexo(lac, sexo, ffin)
        contactos =
          Sivel2Sjr::Casosjr.
          joins('JOIN sip_persona ON sip_persona.id=sivel2_sjr_casosjr.contacto_id').
          joins('JOIN sivel2_sjr_actividad_casosjr ON casosjr_id=sivel2_sjr_casosjr.id_caso').
          where(:'sip_persona.sexo' => sexo).
          where(:'sivel2_sjr_actividad_casosjr.actividad_id' => lac)
        idscontactos = contactos.pluck(:contacto_id).uniq
        benef_indir =
          Sivel2Gen::Victima.
          joins('JOIN sivel2_sjr_victimasjr ON sivel2_gen_victima.id=sivel2_sjr_victimasjr.id_victima').
          joins('JOIN sip_persona ON sip_persona.id=sivel2_gen_victima.id_persona').
          joins('JOIN sivel2_sjr_actividad_casosjr ON casosjr_id=sivel2_gen_victima.id_caso').
          where(:'sip_persona.sexo' => sexo).
          where(:'sivel2_sjr_actividad_casosjr.actividad_id' => lac).
          where('fechadesagregacion IS NULL OR fechadesagregacion > ?', ffin).
          where.not(:'sip_persona.id' => idscontactos)
        idsbenefindir = benef_indir.pluck('id_persona').uniq
        [idscontactos, idsbenefindir]
      end

      # Cuenta personas unicas asistentes a actividades de listado lac 
      # Retorna listado de ids diferentes
      def asistencia_por_sexo(lac, sexo)
        Cor1440Gen::Asistencia.joins(:persona).
          where(actividad_id: lac).
          where('sip_persona.sexo = ?', sexo).pluck(:persona_id).uniq
      end

      # Puede ser :personas, :actividades
      contar = :personas

      case ind.id
      # RESULTADO 1
      when 212 # R1I1 Número de beneficiarios directos e indirectos pero no asistentes
        actpf = res.actividadpf.where(id: 348)  # R1A1
        if actpf.count == 0
          puts 'Falta en marco logico actividadpf con id 348'
          return [ -1, '#', -1, '#', -1, '#', -1, '#']
        end
        lac = calcula_lac(actpf, fini, ffin)
        hombrescasos = calcula_benef_por_sexo(lac, 'M', ffin)
        mujerescasos = calcula_benef_por_sexo(lac, 'F', ffin)
        sinsexocasos = calcula_benef_por_sexo(lac, 'S', ffin)
        benef_dir = hombrescasos[0] + mujerescasos[0] + sinsexocasos[0]
        benef_indir = hombrescasos[1] + mujerescasos[1] + sinsexocasos[1]
        resind = benef_dir.count + benef_indir.count
        if lac.count > 0
          urlevrind = cor1440_gen.actividades_url +
            '?filtro[busid]='+lac.join(',')
        end
        urlevdir = '#'
        if benef_dir.count > 0
          urlevdir = sip.personas_url + '?filtro[busid]=' + benef_dir.join(',')
        end
        urlevindir = '#'
        if benef_indir.count > 0
          urlevindir = sip.personas_url + '?filtro[busid]=' + 
            benef_indir.join(',')
        end

        return [ resind, urlevrind, 
                 benef_dir, urlevdir, 
                 benef_indir, urlevindir, 
                 -1, '#' ]

      when 213 # R1I2  Número de asistentes a actividades pero no de casos
        actpf = res.actividadpf.where(id: 349)  # R1A2
        if actpf.count == 0
          puts 'Falta en marco logico actividadpf con id 349'
          return [ -1, '#', -1, '#', -1, '#', -1, '#']
        end
        lac = calcula_lac(actpf, fini, ffin)
        hombres = asistencia_por_sexo(lac, 'M')
        mujeres = asistencia_por_sexo(lac, 'F')
        sinsexo = asistencia_por_sexo(lac, 'S')
        resind = hombres.count + mujeres.count + sinsexo.count
        if lac.count > 0
          urlevrind = cor1440_gen.actividades_url +
            '?filtro[busid]='+lac.join(',')
        end
        if hombres.count > 0
          urlevhombres = sip.personas_url + '?filtro[busid]=' + 
            hombres.join(',')
        end
        if mujeres.count > 0
          urlevmujeres = sip.personas_url + '?filtro[busid]=' + 
            mujeres.join(',')
        end
        if sinsexo.count > 0
          urlevsinsexo= sip.personas_url + '?filtro[busid]=' + 
            sinsexo.join(',')
        end

        return [ resind, urlevrind, 
                 hombres.count, urlevhombres,
                 mujeres.count, urlevmujeres,
                 sinsexo, urlevsinsexo ]
      when 214 # R1I3 Número de personas
        actpf = res.actividadpf.where(id: 348)  # ? Relacionado con R1A1
        contar = :porcentaje
      when 215 # R1I4 porcentaje
        actpf = res.actividadpf.where(id: 348)  # ? Relacionada con R1A1
        contar = :porcentaje
      when 216 # R1I5 Número de personas
        actpf = res.actividadpf.where(id: 350)  # R1A3
      when 217 # R1I6 Número de estrategias
        actpf = res.actividadpf.where(id: 351)  # R1A4
        contar = :actividades
      when 218 # R1I7 Número de acciones
        actpf = res.actividadpf.where(id: 352)  # R1A5
        contar = :actividades

      # RESULTADO 2
      when 219 # R2I1 Número de centros de salud
        actpf = res.actividadpf.where(id: 353)  # R2A1
        contar = :actividades
      when 220 # R2I2 Número de personas atendidas
        actpf = res.actividadpf.where(id: 354)  # R2A2
      when 221 # R2I3 Número de personas que reciben
        actpf = res.actividadpf.where(id: 355)  # R2A3 + R2A4
      when 222 # R2I4 Número de mujeres gestantes o lactantes
        actpf = res.actividadpf.where(id: 357)  # R2A5
      when 223 # R2I5 Número de personas que reciben acompañamiento psic
        actpf = res.actividadpf.where(id: 358)  # R2A6
      when 224 # R2I6 Número de personas que participan
        actpf = res.actividadpf.where(id: 359)  # R2A7
      when 225 # R2I7 Número de personas qu reciben ... satisfechos..
        actpf = res.actividadpf.where(id: 359)  # ? relacionada con R2A7 R2A6
        contar = :porcentaje
      when 226 # R2I8 Número de convenios/acuerdos
        actpf = res.actividadpf.where(id: 362)  # R1A8
        contar = :actividades

      # RESULTADO 3
      when 227 # R3I1 Número de albergues o casas de acogida
        actpf = res.actividadpf.where(id: 363)  # R3A1
        contar = :actividades
      when 228 # R3I2 Número personas beenficiadas
        actpf = res.actividadpf.where(id: 364)  # R3A2
      when 229 # R3I3 Números de personas beneficiadas
        actpf = res.actividadpf.where(id: 365)  # R3A3
      when 230 # R3I4 Porcentaje de personas 
        actpf = res.actividadpf.where(id: 365)  # ? relacionada con R3A1, R3A2, y R3A3 
        contar = :porcentaje

      # RESULTADO 4
      when 231 # R4I2  Número de personas beneficiadas
        actpf = res.actividadpf.where(id: 366)  # R4A1
      when 232 # R4I3 Porcentajes que han mejorado autos
        actpf = res.actividadpf.where(id: 367)  # ? relacionada con R4A1
        contar = :porcentaje
      when 233 # R4I4 Número de personas capacitdas en emprendimiento
        actpf = res.actividadpf.where(id: 368)  # R4A2 + R4A3

      else
        return [-1, '#', -1, '#', -1, '#', -1, '#']
      end

      if actpf.count == 0
        puts "No hay actividadpf para #{ind.id}"
        return [-1, '#', -1, '#', -1, '#', -1, '#']
      end
      if actpf.count > 1
        puts "Hay más de una actividadpf para #{ind.id}"
        return [-1, '#', -1, '#', -1, '#', -1, '#']
      end
      
      lac = calcula_lac(actpf, fini, ffin)
      if contar == :personas
        hombres = asistencia_por_sexo(lac, 'M')
        hombrescasos = calcula_benef_por_sexo(lac, 'M', ffin)

        hombres += hombrescasos[0] + hombrescasos[1]
        hombres.uniq!
        if hombres.count > 0
          urlevhombres = sip.personas_url + '?filtro[busid]=' + 
            hombres.join(',')
        end

        mujeres = asistencia_por_sexo(lac, 'F')
        mujerescasos = calcula_benef_por_sexo(lac, 'F', ffin)
        mujeres += mujerescasos[0] + mujerescasos[1]
        mujeres.uniq!
        if mujeres.count > 0
          urlevmujeres = sip.personas_url + '?filtro[busid]=' + 
            mujeres.join(',')
        end

        sinsexo = asistencia_por_sexo(lac, 'S')
        sinsexocasos = calcula_benef_por_sexo(lac, 'S', ffin)
        sinsexo += sinsexocasos[0] + sinsexocasos[1]
        sinsexo.uniq!
        if sinsexo.count > 0
          urlevsinsexo = sip.personas_url + '?filtro[busid]=' + 
            sinsexo.join(',')
        end

        resind = hombres.count + mujeres.count + sinsexo.count
      elsif contar == :actividades
        resind = lac.count
      end
      if lac.count > 0
        urlevrind = cor1440_gen.actividades_url +
          '?filtro[busid]='+lac.join(',')
        urlevhombres = '#'
        urlevmujeres = '#'
        urlevsinsexo = '#'
      end
      [resind, urlevrind, 
       hombres, urlevhombres, 
       mujeres, urlevmujeres,
       sinsexo, urlevsinsexo]
    end


    def mideindicador_particular(ind, fini, ffin)
      if ind.proyectofinanciero_id == 181
        return mideindicador_PRM20(ind, fini, ffin)
      end
      return mideindicador_cor1440_gen(ind,fini, ffin)
    end

  end
end
