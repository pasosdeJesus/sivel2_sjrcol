class ActualizaTrivalentespositiva < ActiveRecord::Migration[6.0]
  execute <<-EOF
          UPDATE trivalentepositiva  SET id = 3, nombre= 'NEGATIVA' WHERE ID = 2;
          UPDATE trivalentepositiva  SET id = 2, nombre= 'POSITIVA' WHERE ID = 1;
          UPDATE trivalentepositiva  SET id = 1, nombre= 'SIN RESPUESTA' WHERE ID = 0;
  EOF
end
