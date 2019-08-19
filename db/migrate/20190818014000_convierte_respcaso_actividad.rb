class ConvierteRespcasoActividad < ActiveRecord::Migration[6.0]
  def up
    Sivel2Sjr::Respuesta.all.each do |r|
      a = Cor1440Gen::Actividad.create(
        nombre: "Respuesta al caso #{r.id_caso} del #{r.fechaatencion}",
        fecha: r.fechaatencion,
        oficina_id: r.caso.casosjr.oficina_id,
        observaciones: r.descatencion,
        usuario_id: r.caso.casosjr.asesor
      )
      a.casosjr_ids = [r.id_caso]
      a.proyectofinanciero_ids = [10]
      a.actividadpf_ids = [62]

      a.save
     
      rf = Mr519Gen::Respuestafor.create(
       formulario_id: 10, # Derechos vulnerados y respuesta del estado
       fechaini: r.fechaatencion,
       fechacambio: r.fechaatencion
      )
      a.respuestafor_ids = [rf.id]
      # Derechos vulnerados
      Mr519Gen::Valorcampo.create(
        campo_id: 100,
        respuestafor_id: rf.id,
        valorjson: r.derecho_ids.map(&:to_s)
      )
      Mr519Gen::Valorcampo.create(
        campo_id: 101,
        respuestafor_id: rf.id,
        valor: r.informacionder ? 1 : 0
      )
      Mr519Gen::Valorcampo.create(
        campo_id: 102,
        respuestafor_id: rf.id,
        valor: r.accionesder
      )
      # Respuesta del Estado
      Mr519Gen::Valorcampo.create(
        campo_id: 103,
        respuestafor_id: rf.id,
        valorjson: r.ayudaestado_ids.map(&:to_s)
      )
       Mr519Gen::Valorcampo.create(
        campo_id: 104,
        respuestafor_id: rf.id,
        valor: r.cantidadayes
      )
      Mr519Gen::Valorcampo.create(
        campo_id: 105,
        respuestafor_id: rf.id,
        valor: r.institucionayes
      )
     
      Mr519Gen::Valorcampo.create(
        campo_id: 106,
        respuestafor_id: rf.id,
        valorjson: r.progestado_ids.map(&:to_s)
      )
      Mr519Gen::Valorcampo.create(
        campo_id: 107,
        respuestafor_id: rf.id,
        valor: r.difobsprog
      )

      if r.ayudasjr.count > 0 || (r.detallear && r.detallear != '')
        a.actividadpf_ids += [116]  # No funcionó con a.actividadpf_ids << 116
        rf = Mr519Gen::Respuestafor.create(
          formulario_id: 11, # Asistencia humanitaria
          fechaini: r.fechaatencion,
          fechacambio: r.fechaatencion
        )
        a.respuestafor_ids += [rf.id]
        Mr519Gen::Valorcampo.create(
          campo_id: 110,
          respuestafor_id: rf.id,
          valorjson: r.ayudasjr_ids.map(&:to_s)
        )
        Mr519Gen::Valorcampo.create(
          campo_id: 111,
          respuestafor_id: rf.id,
          valor: r.detallear
        )
      end

      if r.aslegal.count > 0 || (r.detalleal && r.detalleal != '')
        a.actividadpf_ids += [118]
        rf = Mr519Gen::Respuestafor.create(
          formulario_id: 13, # Asistencia legal - Asesoria Jurídica
          fechaini: r.fechaatencion,
          fechacambio: r.fechaatencion
        )
        a.respuestafor_ids += [rf.id]
        Mr519Gen::Valorcampo.create(
          campo_id: 130,
          respuestafor_id: rf.id,
          valorjson: r.aslegal_ids.map(&:to_s)
        )
        Mr519Gen::Valorcampo.create(
          campo_id: 131,
          respuestafor_id: rf.id,
          valor: r.detalleal
        )
      end

      if r.accionjuridica.count > 0
        a.actividadpf_ids += [125]
        rf = Mr519Gen::Respuestafor.create(
          formulario_id: 14, # accion juridica
          fechaini: r.fechaatencion,
          fechacambio: r.fechaatencion
        )
        a.respuestafor_ids += [rf.id]
        Mr519Gen::Valorcampo.create(
          campo_id: 140,
          respuestafor_id: rf.id,
          valor: r.accionjuridica_respuesta[0].accionjuridica_id.to_s
        )
        vr = r.accionjuridica_respuesta[0].favorable.nil? ? 1 :
          (r.accionjuridica_respuesta[0].favorable ? 2 : 3)
        Mr519Gen::Valorcampo.create(
          campo_id: 141,
          respuestafor_id: rf.id,
          valor: vr
        )
        if r.accionjuridica.count > 1
          Mr519Gen::Valorcampo.create(
            campo_id: 142,
            respuestafor_id: rf.id,
            valor: r.accionjuridica_respuesta[1].accionjuridica_id.to_s
          )
          vr = r.accionjuridica_respuesta[1].favorable.nil? ? 1 :
            (r.accionjuridica_respuesta[1].favorable ? 2 : 3)
          Mr519Gen::Valorcampo.create(
            campo_id: 143,
            respuestafor_id: rf.id,
            valor: vr
          )
        end
      end

      if r.motivosjr.count > 0 || (r.detallemotivo && r.detallemotivo != '')
        a.actividadpf_ids += [126]
        rf = Mr519Gen::Respuestafor.create(
          formulario_id: 15, # Otros servicios y asesorias
          fechaini: r.fechaatencion,
          fechacambio: r.fechaatencion
        )
        a.respuestafor_ids += [rf.id]
        Mr519Gen::Valorcampo.create(
          campo_id: 150,
          respuestafor_id: rf.id,
          valorjson: r.motivosjr_ids.map(&:to_s)
        )
        Mr519Gen::Valorcampo.create(
          campo_id: 151,
          respuestafor_id: rf.id,
          valor: r.detallemotivo
        )
      end
      a.save
    end
  end

  def down
    execute <<-SQL
      DELETE FROM mr519_gen_valorcampo WHERE 
        respuestafor_id IN (SELECT id FROM mr519_gen_respuestafor
        WHERE formulario_id IN (10, 11, 12, 13, 14, 15));

      DELETE FROM cor1440_gen_actividad_respuestafor WHERE 
        respuestafor_id IN (SELECT id FROM mr519_gen_respuestafor
        WHERE formulario_id IN (10, 11, 12, 13, 14, 15));

      DELETE FROM mr519_gen_respuestafor WHERE 
        formulario_id IN (10, 11, 12, 13, 14, 15);

      DELETE FROM cor1440_gen_actividad_proyectofinanciero WHERE 
        actividad_id IN (SELECT id FROM cor1440_gen_actividad
          WHERE nombre LIKE 'Respuesta al caso%');

      DELETE FROM cor1440_gen_actividad_actividadpf WHERE 
        actividad_id IN (SELECT id FROM cor1440_gen_actividad
          WHERE nombre LIKE 'Respuesta al caso%');

      DELETE FROM sivel2_sjr_actividad_casosjr WHERE 
        actividad_id IN (SELECT id FROM cor1440_gen_actividad
          WHERE nombre LIKE 'Respuesta al caso%');


      DELETE FROM cor1440_gen_actividad WHERE nombre LIKE 'Respuesta al caso%';
    SQL
  end
end
