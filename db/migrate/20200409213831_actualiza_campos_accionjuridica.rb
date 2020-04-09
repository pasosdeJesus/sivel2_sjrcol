class ActualizaCamposAccionjuridica < ActiveRecord::Migration[6.0]
  execute <<-EOF
          UPDATE mr519_gen_campo SET tablabasica = 'trivalentespositiva' WHERE ID = 141;
          UPDATE mr519_gen_campo SET tablabasica = 'trivalentespositiva' WHERE ID = 143;
  EOF
end
