class AgregaTiposindicadorPrm2020 < ActiveRecord::Migration[6.0]
  def up
    execute <<-SQL
      UPDATE cor1440_gen_indicadorpf SET tipoindicador_id=1 -- Contar actividades
        WHERE id IN (
          217, --R1I6
          218, --R1I7
          219, --R2I1
          226, --R2I8
          227  --R3I1
        );
      UPDATE cor1440_gen_indicadorpf SET tipoindicador_id=4 -- Asistentes únicos
        WHERE id IN (
          213, --R1I2
          224  --R2I6
        );
      
      UPDATE cor1440_gen_indicadorpf SET tipoindicador_id=30  -- Contactos y familiares
        WHERE id IN (
          212, --R1I1
          221, --R2I3
          228, --R3I2
          229, --R3I3
          231  --R4I2
        );
      
      UPDATE cor1440_gen_indicadorpf SET tipoindicador_id=31  -- Contactos y familiares únicos
        WHERE id IN (
          220, --R2I2
          223, --R2I5
          233  --R4I4
        );
      
      INSERT INTO cor1440_gen_tipoindicador(id, nombre, medircon,
        esptipometa, espfuncionmedir, 
        fechacreacion, created_at, updated_at)
      VALUES (107, 'CUENTA CONT. Y FAM. AJ.', 1,
        'Beneficiarios de casos',
        'Número de beneficiarios (contactos + familiares) en casos de actividades con acción jurídica',
        '2020-04-10', '2020-04-10', '2020-04-10');
        
  
       UPDATE cor1440_gen_indicadorpf SET tipoindicador_id=107  
         WHERE id=214; --R1I3
  
       INSERT INTO cor1440_gen_tipoindicador(id, nombre, medircon,
         esptipometa, espfuncionmedir, fechacreacion, created_at, updated_at)
       VALUES (108, 
         'PORC. CONT. Y FAM. AJR.', 1,
         'Porcentaje beneficiarios casos',
         'Porcentaje de beneficiarios (contactos + familiares) de casos en actividades con acciones jurídicas respondidas (tanto positiva como negativamente)',
         '2020-04-10', '2020-04-10', '2020-04-10');
 
       UPDATE cor1440_gen_indicadorpf SET tipoindicador_id=108
         WHERE id=215; --R1I4
 
       INSERT INTO cor1440_gen_tipoindicador(id, nombre, medircon,
         esptipometa, espfuncionmedir, fechacreacion, created_at, updated_at)
       VALUES (109, 'CUENTA BEN. AH. PRM220', 1,
         'Cuenta beneficiarios PRM 2020',
         'Cuenta beneficiarios de casos  que reciben ayuda humanitaria de emergencia con reglas y actividades de PRM 2020',
         '2020-04-10', '2020-04-10', '2020-04-10');
 
       UPDATE cor1440_gen_indicadorpf SET tipoindicador_id=109
         WHERE id=216; --R1I5
 
       INSERT INTO cor1440_gen_tipoindicador(id, nombre, medircon,
         esptipometa, espfuncionmedir, fechacreacion, created_at, updated_at)
       VALUES (110, 'CUENTA LAC. GES. BEBES1', 1,
         'Cuenta beneficiarios casos',
         'Cuenta lactantes, bebés menores a un año y doble de mujeres gestantes',
         '2020-04-10', '2020-04-10', '2020-04-10');
       UPDATE cor1440_gen_indicadorpf SET tipoindicador_id=110
         WHERE id=222; --R2I4
     SQL
  end

  def down
    execute <<-SQL
      UPDATE cor1440_gen_indicadorpf SET tipoindicador_id=NULL
        WHERE tipoindicador_id>='107' AND tipoindicador_id<='110';
      DELETE FROM cor1440_gen_tipoindicador WHERE id>='107'
        AND id<='110';
    SQL
  end
end
