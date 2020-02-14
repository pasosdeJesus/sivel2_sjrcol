require_dependency "cor1440_gen/concerns/controllers/mindicadorespf_controller"

module Cor1440Gen
  class MindicadorespfController < Sip::ModelosController

    include Cor1440Gen::Concerns::Controllers::MindicadorespfController

    def mideindicador_PRM20(ind, fini, ffin)
      res = ind.resultadopf
      actpf = [] 
      case ind.id
      when 212 # R1I1 
        actpf = res.actividadpf.where(id: 348)  # R1A1
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
      lac = Cor1440Gen::Actividad.joins(:actividadpf).
        where('cor1440_gen_actividadpf.id=?', actpf.take.id).
        where('fecha >= ?', fini).
        where('fecha <= ?', ffin).
        pluck(:id).uniq
      hombres = Cor1440Gen::Asistencia.joins(:persona).
        where(actividad_id: lac).
        where('sip_persona.sexo = \'M\'').count
      mujeres = Cor1440Gen::Asistencia.joins(:persona).
        where(actividad_id: lac).
        where('sip_persona.sexo = \'F\'').count
      sinsexo = Cor1440Gen::Asistencia.joins(:persona).
        where(actividad_id: lac).
        where('sip_persona.sexo <> \'M\' AND sip_persona.sexo <> \'F\'').count

      resind = hombres + mujeres + sinsexo
      if lac.count > 0
        urlevrind = cor1440_gen.actividades_url +
          '?filtro[busid]='+lac.join(',')
      end
      [resind, urlevrind, hombres, '#', mujeres, '#', sinsexo, '#']
    end


    def mideindicador_particular(ind, fini, ffin)
      if ind.proyectofinanciero_id == 181
        return mideindicador_PRM20(ind, fini, ffin)
      end
      return mideindicador_cor1440_gen(ind,fini, ffin)
    end

  end
end
