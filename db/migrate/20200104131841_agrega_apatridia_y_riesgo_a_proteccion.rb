class AgregaApatridiaYRiesgoAProteccion < ActiveRecord::Migration[6.0]
  def up
    execute <<-SQL
INSERT INTO sivel2_sjr_proteccion (id, nombre, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (9, 'APATRIDA', '2020-01-04', NULL, NULL, NULL);
INSERT INTO sivel2_sjr_proteccion (id, nombre, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (10, 'EN RIESGO DE APATRIDA', '2020-01-04', NULL, NULL, NULL);
    SQL
  end
end
