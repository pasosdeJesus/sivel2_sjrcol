class PlanEst1 < ActiveRecord::Migration[5.2]
  def up
    execute <<-SQL
      INSERT INTO cor1440_gen_proyectofinanciero (id, nombre, observaciones, 
        fechainicio, fechacierre, responsable_id, fechacreacion, 
        fechadeshabilitacion, created_at, updated_at, compromisos, monto) 
      VALUES (10, 'PLAN ESTRATÉGICO 1', 'Para homologar tipos de actividad anterior a 2018 como actividades de este convenio', 
        '2014-10-01', NULL, NULL, '2018-05-31', 
        NULL, '2018-05-31', '2018-05-31', 'Acompañar, servir y defender a la población en situación de refugio y desplazamiento', 1);

      INSERT INTO cor1440_gen_objetivopf (id, proyectofinanciero_id, numero, 
        objetivo) VALUES 
        (15, 10, 'OE1', 
        'Acompañar, servir y defender a la población en situación de refugio y desplazamiento');

      INSERT INTO cor1440_gen_resultadopf (id, proyectofinanciero_id, 
        objetivopf_id, numero, resultado) VALUES 
        (15, 10, 15, 'R1', 
        'Acompañar, servir y defender a la población en situación de refugio y desplazamiento');


      INSERT INTO cor1440_gen_actividadpf (id, proyectofinanciero_id, 
        nombrecorto, titulo, 
        descripcion, resultadopf_id, actividadtipo_id) 
      VALUES (51, 10, 'ORGFOR', 'ORGANIZACIÓN DE ACTIVIDAD DE FORMACIÓN', 
      '', 15, NULL);
      INSERT INTO cor1440_gen_actividadpf (id, proyectofinanciero_id, 
        nombrecorto, titulo, 
        descripcion, resultadopf_id, actividadtipo_id) 
      VALUES (60, 10, 'ORGCAM','ORGANIZACIÓN DE CAMPAÑA', 
        '', 15, NULL);
      INSERT INTO cor1440_gen_actividadpf (id, proyectofinanciero_id, 
        nombrecorto, titulo, 
        descripcion, resultadopf_id, actividadtipo_id) 
        VALUES (61, 10, 'MISHUM', 'MISIÓN HUMANITARIA', 
        '', 15, NULL);
      INSERT INTO cor1440_gen_actividadpf (id, proyectofinanciero_id, 
        nombrecorto, titulo, 
        descripcion, resultadopf_id, actividadtipo_id) 
        VALUES (64, 10, 'SEGPRO', 'SEGUIMIENTO A PROYECTO', 
        '', 15, NULL);
      INSERT INTO cor1440_gen_actividadpf (id, proyectofinanciero_id, 
        nombrecorto, titulo, 
        descripcion, resultadopf_id, actividadtipo_id) 
        VALUES (53, 10, 'PARREU', 'PARTICIPACIÓN EN REUNIÓN', 
        '', 15, NULL);
      INSERT INTO cor1440_gen_actividadpf (id, proyectofinanciero_id, 
        nombrecorto, titulo, 
        descripcion, resultadopf_id, actividadtipo_id) 
        VALUES (55, 10, 'PREPON', 'PRESENTACIÓN DE PONENCIA EN EVENTO', 
        '', 15, NULL);
      INSERT INTO cor1440_gen_actividadpf (id, proyectofinanciero_id, 
        nombrecorto, titulo, 
        descripcion, resultadopf_id, actividadtipo_id) 
        VALUES (56, 10, 'MON', 'MONITOREO, SUPERVISIÓN, EVALUACIÓN', 
        '', 15, NULL);
      INSERT INTO cor1440_gen_actividadpf (id, proyectofinanciero_id, 
        nombrecorto, titulo, 
        descripcion, resultadopf_id, actividadtipo_id) 
        VALUES (57, 10, 'ORGEV', 'ORGANIZACIÓN DE EVENTO', 
        '', 15, NULL);
      INSERT INTO cor1440_gen_actividadpf (id, proyectofinanciero_id, 
        nombrecorto, titulo, 
        descripcion, resultadopf_id, actividadtipo_id) 
        VALUES (58, 10, 'RESINF', 'RESPUESTA A SOLICITUD DE INFORMACIÓN', 
        '', 15, NULL);
      INSERT INTO cor1440_gen_actividadpf (id, proyectofinanciero_id, 
        nombrecorto, titulo, 
        descripcion, resultadopf_id, actividadtipo_id) 
        VALUES (59, 10, 'ACTCUL', 'ORGANIZACIÓN DE ACTIVIDAD CULTURAL/ARTÍSTICA', 
        '', 15, NULL);
      INSERT INTO cor1440_gen_actividadpf (id, proyectofinanciero_id, 
        nombrecorto, titulo, 
        descripcion, resultadopf_id, actividadtipo_id) 
        VALUES (67, 10, 'ACCCOL', 'ACCIÓN COLECTIVA', 
        '', 15, NULL);
      INSERT INTO cor1440_gen_actividadpf (id, proyectofinanciero_id, 
        nombrecorto, titulo, 
        descripcion, resultadopf_id, actividadtipo_id) 
        VALUES (152, 10, 'INFO', 'ELABORACIÓN DE INFORME/DOCUMENTO', 
        '', 15, NULL);
      INSERT INTO cor1440_gen_actividadpf (id, proyectofinanciero_id, 
        nombrecorto, titulo, 
        descripcion, resultadopf_id, actividadtipo_id) 
        VALUES (155, 10, 'REPACO', 'EJERCICIO DE RÉPLICA / ACOMPAÑAMIENTO', 
        '', 15, NULL);
      INSERT INTO cor1440_gen_actividadpf (id, proyectofinanciero_id, 
        nombrecorto, titulo, 
        descripcion, resultadopf_id, actividadtipo_id) 
        VALUES (156, 10, 'ASIPRO', 'ASISTENCIA/SEGUIMIENTO TÉCNICO A INICIATIVA PRODUCTIVA', 
        'RURAL O URBANA', 15, NULL);
      INSERT INTO cor1440_gen_actividadpf (id, proyectofinanciero_id, 
        nombrecorto, titulo, 
        descripcion, resultadopf_id, actividadtipo_id) 
        VALUES (151, 10, 'TALLER', 'TALLER / ENCUENTRO', 
        '', 15, NULL);
      INSERT INTO cor1440_gen_actividadpf (id, proyectofinanciero_id, 
        nombrecorto, titulo, 
        descripcion, resultadopf_id, actividadtipo_id) 
        VALUES (157, 10, 'CONV', 'CONVERSATORIO', 
        '', 15, NULL);
      INSERT INTO cor1440_gen_actividadpf (id, proyectofinanciero_id, 
        nombrecorto, titulo, 
        descripcion, resultadopf_id, actividadtipo_id) 
        VALUES (65, 10, 'MOV', 'MOVILIZACIÓN', 
        '', 15, NULL);
      INSERT INTO cor1440_gen_actividadpf (id, proyectofinanciero_id, 
        nombrecorto, titulo, 
        descripcion, resultadopf_id, actividadtipo_id) 
        VALUES (69, 10, 'INFORI', 'INFORMACIÓN Y ORIENTACIÓN', 
        '', 15, NULL);
      INSERT INTO cor1440_gen_actividadpf (id, proyectofinanciero_id, 
        nombrecorto, titulo, 
        descripcion, resultadopf_id, actividadtipo_id) 
        VALUES (158, 10, 'SISINF', 'SISTEMA DE INFORMACIÓN', 
        '', 15, NULL);
      INSERT INTO cor1440_gen_actividadpf (id, proyectofinanciero_id, 
        nombrecorto, titulo, 
        descripcion, resultadopf_id, actividadtipo_id) 
        VALUES (159, 10, 'DIADIS', 'DIAGRAMACIÓN - DISEÑO DE PUBLICACIONES Y MATERIAL INSTITUCIONAL', 
        'COMUNICACIONES',  15, NULL);
      INSERT INTO cor1440_gen_actividadpf (id, proyectofinanciero_id, 
        nombrecorto, titulo, 
        descripcion, resultadopf_id, actividadtipo_id) 
        VALUES (162, 10, 'COMCAM', 'COMPONENTE COMUNICACIÓN DE CAMPAÑAS DE DIFUSIÓN, SENSIBILIZACIÓN Y DIVULGACIÓN', 
        'COMUNICACIONES', 15, NULL); 
      INSERT INTO cor1440_gen_actividadpf (id, proyectofinanciero_id, 
        nombrecorto, titulo, 
        descripcion, resultadopf_id, actividadtipo_id) 
        VALUES (160, 10, 'ACOCOM', 'ACOMPAÑAMIENTO EN COMUNICACIÓN COMUNITARIA', 
        'COMUNICACIONES', 15, NULL); 
      INSERT INTO cor1440_gen_actividadpf (id, proyectofinanciero_id, 
        nombrecorto, titulo, 
        descripcion, resultadopf_id, actividadtipo_id) 
        VALUES (161, 10, 'DISPRO', 'DISEÑO, PRODUCCIÓN Y DIFUSIÓN DE MATERIAL COMUNICATIVO E INFORMATIVO', 
        'COMUNICACIONES', 15, NULL); 
      INSERT INTO cor1440_gen_actividadpf (id, proyectofinanciero_id, 
        nombrecorto, titulo, 
        descripcion, resultadopf_id, actividadtipo_id) 
        VALUES (163, 10, 'COMVIS', 'COMPONENTE DE COMUNICACIÓN A ACCIONES DE VISIBILIZACIÓN', 
        'COMUNICACIONES', 15, NULL); 

      INSERT INTO cor1440_gen_actividadpf (id, proyectofinanciero_id, 
        nombrecorto, titulo, 
        descripcion, resultadopf_id, actividadtipo_id) 
        VALUES (66, 10, 'ATECAS', 'ATENCIÓN A CASO NUEVO', 
        'Deshabilitada por solicitud de Coordinadores, pues también existe esta clasificación en Subárea de Actividad', 15, NULL);
      INSERT INTO cor1440_gen_actividadpf (id, proyectofinanciero_id, 
        nombrecorto, titulo, 
        descripcion, resultadopf_id, actividadtipo_id) 
        VALUES (154, 10, 'ATEREC', 'ATENCIÓN A CASO POR RE-CONSULTA', 
        'Deshabilitada por solicitud de Coordinadores, pues también existe esta clasificación en Subárea de Actividad', 15, NULL); 
      INSERT INTO cor1440_gen_actividadpf (id, proyectofinanciero_id, 
        nombrecorto, titulo, 
        descripcion, resultadopf_id, actividadtipo_id) 
        VALUES (68, 10, 'ATEJUR', 'ATENCIÓN JURÍDICA', 
        'Deshabilitada por solicitud de Coordinadores, pues también existe esta clasificación en Subárea de Actividad', 15, NULL); 
      INSERT INTO cor1440_gen_actividadpf (id, proyectofinanciero_id, 
        nombrecorto, titulo, 
        descripcion, resultadopf_id, actividadtipo_id) 
        VALUES (70, 10, 'ATEPSI', 'ATENCIÓN PSICOSOCIAL', 
        'Deshabilitada por solicitud de Coordinadores, pues también existe esta clasificación en Subárea de Actividad', 15, NULL); 
      INSERT INTO cor1440_gen_actividadpf (id, proyectofinanciero_id, 
        nombrecorto, titulo, 
        descripcion, resultadopf_id, actividadtipo_id) 
        VALUES (62, 10, 'SEGCAS', 'SEGUIMIENTO A CASO', 
        'Deshabilitada por solicitud de Coordinadores, pues también existe esta clasificación en Subárea de Actividad', 15, NULL); 

      SELECT pg_catalog.setval('cor1440_gen_actividadtipo_id_seq', max(id)+1, 
        true) FROM cor1440_gen_actividadtipo;
    SQL
  end
  
  def down
    execute <<-SQL
      DELETE FROM cor1440_gen_actividadpf WHERE (id>='51' AND id<='163');
      DELETE FROM cor1440_gen_resultadopf WHERE id=15;
      DELETE FROM cor1440_gen_objetivopf WHERE id=15;
      DELETE FROM cor1440_gen_proyectofinanciero WHERE id=10;
    SQL
  end
end
