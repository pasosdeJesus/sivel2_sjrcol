# encoding: UTF-8

require 'sivel2_sjr/concerns/models/proyectofinanciero'

module Cor1440Gen
  class Proyectofinanciero < ActiveRecord::Base

    include Sivel2Sjr::Concerns::Models::Proyectofinanciero


    # Recibe un grupo de proyectosfinancieros y los filtra 
    # de acuerdo al control de acceso del usuario o a 
    # otros parametros recibidos
    def filtra_acceso(current_usuario, pf, params = nil)
      if params && params[:filtro] && params[:filtro][:busoficina] &&
        params[:filtro][:busoficina] != ''
        pf = pf.joins(:oficina_proyectofinanciero).
          where('sivel2_sjr_oficina_proyectofinanciero.oficina_id = ?',
                params[:filtro][:busoficina])
      end
      return pf
    end

    def presenta(atr)

      ## 4 Primeros Indicadores de objetivo
      cindob = /indicadorobj(.*)$/.match(atr.to_s)
      if cindob
        indobs = indicadorobjetivo.where(resultadopf_id: nil).order(:id)
        numero = cindob[1].split("_")[0]
        campo = cindob[1].split("_")[1]
        if indobs.count >= numero.to_i
          indicadorob = indobs[numero.to_i-1]
          if indicadorob
            case campo
            when 'refobj'
              return indicadorob.objetivopf ? indicadorob.objetivopf.numero : ''
            when 'codigo'
              return indicadorob.numero ? indicadorob.numero : ''
            when 'nombre'
              return indicadorob.indicador ? indicadorob.indicador : ''
            when 'tipo'
              return indicadorob.tipoindicador ? indicadorob.tipoindicador.nombre : ''
            end
          end
        else
          return ''
        end
      end
      ## 4 Primeros Resultados
      cres = /resultado(.*)$/.match(atr.to_s)
      if cres
        resultados = resultadopf.order(:id)
        numero = cres[1].split("_")[0]
        campo = cres[1].split("_")[1]
        if resultados.count >= numero.to_i
          resultado = resultados[numero.to_i-1]
          if resultado
            case campo
            when 'refobj'
              return resultado.objetivopf ? resultado.objetivopf.numero : ''
            when 'codigo'
              return resultado.numero ? resultado.numero : ''
            when 'resultado'
              return resultado.resultado ? resultado.resultado : ''
            end
          end
        else
          return ''
        end
      end
      ## 6 Primeros indicadores de resultados
      cinres = /indicadorres(.*)$/.match(atr.to_s)
      if cinres
        indiresultados = indicadorpf.where(objetivopf_id: nil).order(:id)
        numero = cinres[1].split("_")[0]
        campo = cinres[1].split("_")[1]
        if indiresultados.count >= numero.to_i
          indicador = indiresultados[numero.to_i-1]
          if indicador
            case campo
            when 'refres'
              ref = indicador.resultadopf
              return ref ? ref.numero + ref.objetivopf.numero : ''
            when 'codigo'
              return indicador.numero ? indicador.numero : ''
            when 'tipo'
              return indicador.tipoindicador ? indicador.tipoindicador.nombre : ''
            when 'indicador'
              return indicador.indicador ? indicador.indicador : ''
            end
          end
        else
          return ''
        end
      end
      ## 8 Primeras Actividades
      cact = /actividadpf(.*)$/.match(atr.to_s)
      if cact
        actividades = actividadpf.order(:id)
        numero = cact[1].split("_")[0]
        campo = cact[1].split("_")[1]
        if actividades.count >= numero.to_i
          actividad = actividades[numero.to_i-1]
          if actividad
            case campo
            when 'refresultado'
              ref = actividad.resultadopf
              return ref ? ref.numero + ref.objetivopf.numero : ''
            when 'codigo'
              return actividad.nombrecorto ? actividad.nombrecorto : ''
            when 'tipo'
              return actividad.actividadtipo ? actividad.actividadtipo.nombre : ''
            when 'actividad'
              return actividad.titulo ? actividad.titulo : ''
            when 'descripcion'
              return actividad.descripcion ? actividad.descripcion : ''
            when 'indicadoresgifmm'
              return actividad.indicadorgifmm ? actividad.indicadorgifmm.nombre : ''
            end
          end
        else
          return ''
        end
      end
      #Exporta Campos básicos de Convenios Financiados
      basicos = ::Ability::CAMPOS_PROYECTOS_FINANCIEROS_BAS
      case atr.to_s
      when 'nombres'
        nombre
      when 'financiador', 'area'
        financiador ? financiador.pluck(:nombre).join(',') : ''
      when 'area'
        proyecto ? proyecto.pluck(:nombre).join(',') : ''
      when 'responsable'
        responsable ? responsable.nusuario : ''
      when 'equipotrabajo'
        et_ids = Cor1440Gen::ProyectofinancieroUsuario.where(proyectofinanciero_id: id).pluck(:usuario_id)
        Usuario.find(et_ids) ? Usuario.find(et_ids).pluck(:nusuario).join(' ') : ''
      when 'objetivos'
        objetivopf ? objetivopf.pluck(:numero, :objetivo).map{|e| e.join(': ')}.join('. ') : ''
      when 'obj1_texto'
        objetivopf.order(:id)[0] ? objetivopf.order(:id)[0].objetivo : ''
      when 'obj1_cod'
        objetivopf.order(:id)[0] ? objetivopf.order(:id)[0].numero : ''
      when 'obj2_texto'
        objetivopf.order(:id)[1] ? objetivopf.order(:id)[1].objetivo : ''
      when 'obj2_cod'
        objetivopf.order(:id)[1] ? objetivopf.order(:id)[1].numero : ''
      when 'indicadores_obj'
        inds = indicadorpf.where(resultadopf_id: nil).pluck(:numero, :indicador, :tipoindicador_id, :objetivopf_id)
        indicadores = inds.map{|indi| (indi[3] ? Cor1440Gen::Objetivopf.find(indi[3]).numero : '') + ':' + (indi[0] ? indi[0] : '') + ': ' + (indi[1] ? indi[1] : '') + ', ' + (indi[2] ? Cor1440Gen::Tipoindicador.find(indi[2]).nombre : '')}.join('. ')
        indicadorobjetivo ? indicadores : ''
      when 'indicadoresres'
        indres = indicadorpf.where(objetivopf: nil).order(:id).pluck(:resultadopf_id, :numero, :indicador, :tipoindicador_id)
        indicadores = indres.map{|indi| (indi[0] ? (Cor1440Gen::Resultadopf.find(indi[0]).objetivopf.numero + ':' + Cor1440Gen::Resultadopf.find(indi[0]).numero) : '') + '. ' + (indi[1] ? indi[1] : '') + ': ' + (indi[2] ? indi[2] : '') + ', ' + (indi[3] ? Cor1440Gen::Tipoindicador.find(indi[3]).nombre : '')}.join('. ')
        indicadorpf.where(objetivopf: nil) ? indicadores : ''
      when 'resultados'
        ress = resultadopf.pluck(:numero, :objetivopf_id, :resultado)
        resultados = ress.map{|res| (res[0] ? res[0] : '') + ': ' + (res[1] ? Cor1440Gen::Objetivopf.find(res[1]).numero : '') + ', ' + (res[2] ? res[2] : '')}.join('. ')
        resultadopf ? resultados : ''
      when 'actividadespf'
        acts = actividadpf.order(:id).pluck(:resultadopf_id, :nombrecorto, :actividadtipo_id, :titulo, :descripcion, :indicadorgifmm_id)
        actividades = acts.map{|act| (act[0] ? Cor1440Gen::Resultadopf.find(act[0]).objetivopf.numero : '') + (act[0] ? Cor1440Gen::Resultadopf.find(act[0]).numero : '') + ': ' + (act[1] ? act[1] : '') + ', ' + (act[2] ? Cor1440Gen::Actividadtipo.find(act[2]).nombre : '') + ', ' + (act[3] ? act[3] : '') + ', ' + (act[4] ? act[4] : '') + ', ' + (act[5] ? Indicadorgifmm.find(act[5]).nombre : '')}.join('. ')
      else
        presenta_gen(atr)
      end

    end
  end
end
