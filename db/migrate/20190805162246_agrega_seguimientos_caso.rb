class AgregaSeguimientosCaso < ActiveRecord::Migration[6.0]
  def up
    if Cor1440Gen::Actividadtipo.where(id: 129).count == 0
      Cor1440Gen::Actividadtipo.create(id: 129, nombre: 'ATENCIÓN HUMANITARIA',
                                       fechacreacion: '2018-12-11', 
                                       created_at: '2018-12-11', 
                                       updated_at: '2018-12-11')
    end
    if Cor1440Gen::Actividadtipo.where(id: 18).count == 0
      Cor1440Gen::Actividadtipo.create(id: 18, nombre: 'ATENCIÓN JURÍDICA',
                                       fechacreacion: '2015-04-18',
                                       created_at: '2017-01-28', 
                                       updated_at: '2017-01-28')
    end


    execute <<-SQL
      -- actividadtipo 12 es SEGUIMIENTO A CASO que ya está en el proyecto
      -- pero por rehabilitar, actividadpf 62 es SEGUIMIENTO A CASO ne
      -- Plan marco: PLAN ESTRATEGICO 1

      UPDATE cor1440_gen_actividadtipo SET fechadeshabilitacion=NULL,
        observaciones='' WHERE id=12;
      UPDATE cor1440_gen_actividadpf SET descripcion='', actividadtipo_id=12
        WHERE id=62;

      INSERT INTO mr519_gen_formulario (id, nombre, nombreinterno) 
        VALUES('10', 'DERECHOS VULNERADOS Y RESPUESTA DEL ESTADO', 'derechos_vulnerados_respuesta_estado') ;
      INSERT INTO mr519_gen_campo 
        (id, nombre, nombreinterno, 
          tipo, tablabasica, formulario_id, fila, ayudauso) VALUES
        ('100', 'Derechos vulnerados', 'derechos_vulnerados',
        '14', 'derechos', 10, 1, 'Elija uno o varios derechos vulnerados que reporte la persona en la atención. Para elegir varios pulse Control y seleccione los derechos que sean necesarios');
      INSERT INTO mr519_gen_campo 
        (id, nombre, nombreinterno, tipo, formulario_id, fila, ayudauso) VALUES
        ('101', 'Se brindó información', 'se_brindo_informacion',
        '4', 10, 2, 'Seleccione si el SJR brindó información frente a los derechos vulnerados');
        

      --INSERT INTO mr519_gen_campo 
      --  (id, nombre, nombreinterno, tipo, formulario_id, fila) VALUES
      --  ('102', 'Acciones de la persona frente a derechos vulnerados', 
      --    'acciones_persona', '1', 10, 3);
      INSERT INTO mr519_gen_campo 
        (id, nombre, nombreinterno, 
          tipo, tablabasica, formulario_id, fila, ayudauso ) VALUES
        ('103', 'Ayuda del Estado', 'ayuda_del_estado',
        '14', 'ayudasestado', 10, 3, 'Seleccione las ayudas otorgadas por instituciones públicas');
        
      --INSERT INTO mr519_gen_campo 
      --  (id, nombre, nombreinterno, tipo, formulario_id, fila) VALUES
      --  ('104', 'Cantidad de ayuda del Estado', 
      --    'cantidad_ayuda_estado', '3', 10, 5);
      --INSERT INTO mr519_gen_campo 
      --  (id, nombre, nombreinterno, tipo, formulario_id, fila) VALUES
      --  ('105', 'Instituciones que ayudaron', 
      --    'instituciones_que_ayudaron', '1', 10, 3);
      INSERT INTO mr519_gen_campo 
        (id, nombre, nombreinterno, 
          tipo, tablabasica, formulario_id, fila, ayudauso) VALUES
        ('106', 'Programas y respuesta del Estado', 
          'programas_respuesta_estado', '14',  'progsestado', 10, 4, 'Marque el programa o respuesta que corresponda');
      -- La descripción se pondrá en el campo respuesta de actividad
      INSERT INTO cor1440_gen_actividadtipo_formulario 
        (actividadtipo_id, formulario_id)
        VALUES ('12', '10');

      -- actividadtipo 129 es ATENCIÓN HUMANITARIA que está en sitio de produccion bastante usado en varias actividadpf

      --INSERT INTO cor1440_gen_actividadtipo 
      --  (id, nombre, fechacreacion, created_at, updated_at)
      --  VALUES (16, 'ASISTENCIA HUMANITARIA', 
      --  '2019-08-05', '2019-08-05', '2019-08-05');
      INSERT INTO mr519_gen_formulario (id, nombre, nombreinterno) 
        VALUES('11', 'ASISTENCIA HUMANITARIA', 'asistencia_humanitaria') ;
      INSERT INTO mr519_gen_campo 
        (id, nombre, nombreinterno, 
          tipo, tablabasica, formulario_id, fila, ayudauso) VALUES
        ('110', 'Asistencia humanitaria', 'asistencia_humanitaria',
        '14', 'ayudassjr', 11, 1, 'Seleccione el(los) tipo(s) de ayuda brindada por el SJR');
      INSERT INTO mr519_gen_campo 
        (id, nombre, nombreinterno, 
          tipo, formulario_id, fila, ayudauso) VALUES
        ('111', 'Detalle de asistencia humanitaria', 
          'detalle_asistencia_humanitaria', '1', 11, 2, 'Describir la ayuda humanitaria del SJR (campo opcional)');
      INSERT INTO cor1440_gen_actividadtipo_formulario 
        (actividadtipo_id, formulario_id)
        VALUES ('129', '11');
      INSERT INTO cor1440_gen_actividadpf
        (id, proyectofinanciero_id, nombrecorto, titulo, resultadopf_id, actividadtipo_id)
        VALUES (116, 10, 'ASHUM', 'ASISTENCIA HUMANITARIA', 15, 129);    


        -- En producción ATENCIÓN PSICOSOCIAL ya esta como 20 pero debe habilitarse

        -- En producción ASESORÍA JURÍDICA ya está como  18
      UPDATE cor1440_gen_actividadtipo SET fechadeshabilitacion=NULL,
        observaciones='' WHERE id=18;
      --INSERT INTO cor1440_gen_actividadtipo 
      --  (id, nombre, fechacreacion, created_at, updated_at)
      --  VALUES (18, 'ASISTENCIA LEGAL', 
      --  '2019-08-05', '2019-08-05', '2019-08-05');
      INSERT INTO mr519_gen_formulario (id, nombre, nombreinterno) 
        VALUES('13', 'ASESORIA JURÍDICA', 'asesoria_juridica') ;
      INSERT INTO mr519_gen_campo 
        (id, nombre, nombreinterno, 
          tipo, tablabasica, formulario_id, fila, ayudauso) VALUES
        ('130', 'Asesoria Jurídica', 'asesoria_juridica',
          '14', 'aslegales', 13, 1, 'Seleccione el (los) tipo (s) de asesoría judicial brindada por el SJR');
      INSERT INTO mr519_gen_campo 
        (id, nombre, nombreinterno, tipo, formulario_id, fila, ayudauso) VALUES
        ('131', 'Detalle de asesoría jurídica', 
          'detalle_asesoria_juridica', '1', 13, 2, 'Describir la asistencia judicial del SJR (campo opcional)');
      INSERT INTO cor1440_gen_actividadtipo_formulario 
        (actividadtipo_id, formulario_id)
        VALUES ('18', '13');
      INSERT INTO cor1440_gen_actividadpf
        (id, proyectofinanciero_id, nombrecorto, titulo, resultadopf_id, actividadtipo_id)
        VALUES (118, 10, 'ASJUR', 'ASESORÍA JURÍDICA', 15, 18);    

      INSERT INTO cor1440_gen_actividadtipo 
        (id, nombre, fechacreacion, created_at, updated_at)
        VALUES (25, 'ACCIÓN JURÍDICA', 
        '2019-08-05', '2019-08-05', '2019-08-05');
      INSERT INTO mr519_gen_formulario (id, nombre, nombreinterno) 
        VALUES('14', 'ACCIÓN JURÍDICA', 'accion_juridica') ;
      INSERT INTO mr519_gen_campo 
        (id, nombre, nombreinterno, 
          tipo, tablabasica, formulario_id, fila, columna, ancho) VALUES
        ('140', 'Acción Jurídica 1', 'accion_juridica_1',
          '15', 'accionesjuridicas', 14, 1, 1, 6);
      INSERT INTO mr519_gen_campo 
        (id, nombre, nombreinterno, tipo, formulario_id, fila, columna, ancho) 
        VALUES ('141', 'Respuesta 1', 'respuesta_1', 11, 14, 1, 7, 6);
      INSERT INTO mr519_gen_opcioncs (id, campo_id, nombre, valor)
        VALUES (40, 141, 'SIN RESPUESTA', 'sin_respuesta');      
      INSERT INTO mr519_gen_opcioncs (id, campo_id, nombre, valor)
        VALUES (41, 141, 'SI', 'si');      
      INSERT INTO mr519_gen_opcioncs (id, campo_id, nombre, valor)
        VALUES (42, 141, 'NO', 'no');      
      INSERT INTO mr519_gen_campo 
        (id, nombre, nombreinterno, 
          tipo, tablabasica, formulario_id, fila, columna, ancho) VALUES
        ('142', 'Acción Jurídica 2', 'accion_juridica_2',
          '15', 'accionesjuridicas', 14, 2, 1, 6);
      INSERT INTO mr519_gen_campo 
        (id, nombre, nombreinterno, tipo, formulario_id, fila, columna, ancho) 
        VALUES ('143', 'Respuesta 2', 'respuesta_2', 11, 14, 2, 7, 6);
      INSERT INTO mr519_gen_opcioncs (id, campo_id, nombre, valor)
        VALUES (50, 143, 'SIN RESPUESTA', 'sin_respuesta');      
      INSERT INTO mr519_gen_opcioncs (id, campo_id, nombre, valor)
        VALUES (51, 143, 'SI', 'si');      
      INSERT INTO mr519_gen_opcioncs (id, campo_id, nombre, valor)
        VALUES (52, 143, 'NO', 'no');      
      INSERT INTO cor1440_gen_actividadtipo_formulario 
        (actividadtipo_id, formulario_id)
        VALUES ('25', '14');
      INSERT INTO cor1440_gen_actividadpf
        (id, proyectofinanciero_id, nombrecorto, titulo, resultadopf_id, actividadtipo_id)
        VALUES (125, 10, 'ACJUR', 'ACCIÓN JURÍDICA', 15, 25);    

      INSERT INTO cor1440_gen_actividadtipo 
        (id, nombre, fechacreacion, created_at, updated_at)
        VALUES (26, 'OTROS SERVICIOS Y ASESORIAS PARA UN CASO', 
        '2019-08-05', '2019-08-05', '2019-08-05');
      INSERT INTO mr519_gen_formulario (id, nombre, nombreinterno) 
        VALUES('15', 'OTROS SERVICIOS Y ASESORÍAS PARA UN CASO', 'otros_servicios_asesorias_caso') ;
      INSERT INTO mr519_gen_campo 
        (id, nombre, nombreinterno, 
          tipo, tablabasica, formulario_id, fila) VALUES
        ('150', 'Otros servicios y asesorias', 'otros_servicios_asesorias',
          '14', 'motivossjr', 15, 1);
      INSERT INTO mr519_gen_campo 
        (id, nombre, nombreinterno, tipo, formulario_id, fila) VALUES
        ('151', 'Detalle de otros servicios y asesorías', 
          'detalle_otros_servicios_asesorias', '1', 15, 2);
      INSERT INTO cor1440_gen_actividadtipo_formulario 
        (actividadtipo_id, formulario_id)
        VALUES ('26', '15');
      INSERT INTO cor1440_gen_actividadpf
        (id, proyectofinanciero_id, nombrecorto, titulo, resultadopf_id, actividadtipo_id)
        VALUES (126, 10, 'OTSERC', 'OTROS SERVICIOS Y ASESORÍAS PARA UN CASO', 15, 26);    

    SQL
  end
  def down
    execute <<-SQL
      DELETE FROM cor1440_gen_actividadpf WHERE id IN (116, 118, 125, 126);
      DELETE FROM cor1440_gen_actividadtipo_formulario 
        WHERE formulario_id IN (10, 11, 13, 14, 15);
      DELETE FROM mr519_gen_opcioncs
        WHERE campo_id IN (SELECT id FROM mr519_gen_campo
        WHERE formulario_id IN (10, 11, 13, 14, 15));
      DELETE  FROM mr519_gen_campo
        WHERE formulario_id IN (10, 11, 13, 14, 15);
      DELETE FROM mr519_gen_formulario WHERE id IN (10, 11, 13, 14, 15);
      DELETE FROM cor1440_gen_actividadtipo WHERE id IN (25, 26);
    SQL
  end
end
