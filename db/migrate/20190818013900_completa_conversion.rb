class CompletaConversion < ActiveRecord::Migration[6.0]

  # Mejor convertimos todo mientras esperamos retroalimentacion de propuesta de
  # simplificar
  def up
    execute <<-SQL
       INSERT INTO mr519_gen_campo 
        (id, nombre, nombreinterno, tipo, formulario_id, fila) VALUES
        ('102', 'Acciones de la persona frente a derechos vulnerados', 
          'acciones_persona', '1', 10, 3);
      UPDATE mr519_gen_campo SET fila=4 WHERE id=103;
      INSERT INTO mr519_gen_campo 
        (id, nombre, nombreinterno, tipo, formulario_id, fila) VALUES
        ('104', 'Cantidad de ayuda del Estado', 
          'cantidad_ayuda_estado', '3', 10, 5);
      INSERT INTO mr519_gen_campo 
        (id, nombre, nombreinterno, tipo, formulario_id, fila) VALUES
        ('105', 'Instituciones que ayudaron', 
          'instituciones_que_ayudaron', '1', 10, 6);
      UPDATE mr519_gen_campo SET fila=7 WHERE id='106';
      INSERT INTO mr519_gen_campo 
        (id, nombre, nombreinterno, ayudauso, tipo, formulario_id, fila) VALUES
        ('107', 'Dificultades y observaciones', 
          'Comentarios adicionales frente a la respuesta del EStado',
          'comentarios_respuesta_estado', '1', 10, 8);
      DELETE FROM mr519_gen_opcioncs WHERE id IN (40, 41,42, 50, 51, 52);
      UPDATE mr519_gen_campo SET tablabasica='trivalentes', tipo='15'
        WHERE id IN (141, 143);
    SQL
  end

  def down
    execute <<-SQL
      DELETE FROM mr519_gen_campo WHERE id in (107, 105, 104, 102);
      INSERT INTO mr519_gen_opcioncs (id, campo_id, nombre, valor)
        VALUES (40, 141, 'SIN RESPUESTA', 'sin_respuesta');      
      INSERT INTO mr519_gen_opcioncs (id, campo_id, nombre, valor)
        VALUES (41, 141, 'SI', 'si');      
      INSERT INTO mr519_gen_opcioncs (id, campo_id, nombre, valor)
        VALUES (42, 141, 'NO', 'no');      
      INSERT INTO mr519_gen_opcioncs (id, campo_id, nombre, valor)
        VALUES (50, 143, 'SIN RESPUESTA', 'sin_respuesta');      
      INSERT INTO mr519_gen_opcioncs (id, campo_id, nombre, valor)
        VALUES (51, 143, 'SI', 'si');      
      INSERT INTO mr519_gen_opcioncs (id, campo_id, nombre, valor)
        VALUES (52, 143, 'NO', 'no');      
    SQL
  end
end
