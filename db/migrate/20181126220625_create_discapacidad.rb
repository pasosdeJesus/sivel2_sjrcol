class CreateDiscapacidad < ActiveRecord::Migration[5.2]
  def up
    create_table :discapacidad do |t|
      t.string :nombre, limit: 500, null: false
      t.string :observaciones, limit: 5000
      t.date :fechacreacion, null: false
      t.date :fechadeshabilitacion
      t.timestamp :created_at, null: false
      t.timestamp :updated_at, null: false
    end
    execute <<-SQL
      INSERT INTO public.discapacidad(id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (1, 'FÍSICA', '', '2018-11-26', NULL, '2018-11-26 20:26:02.877509', '2018-11-26 20:26:44.096661');
      INSERT INTO public.discapacidad(id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (2, 'VISUAL', '', '2018-11-26', NULL, '2018-11-26 20:26:02.877509', '2018-11-26 20:26:44.096661');
      INSERT INTO public.discapacidad(id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (3, 'AUDITIVA', '', '2018-11-26', NULL, '2018-11-26 20:26:02.877509', '2018-11-26 20:26:44.096661');
      INSERT INTO public.discapacidad(id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (4, 'COGNITIVA', '', '2018-11-26', NULL, '2018-11-26 20:26:02.877509', '2018-11-26 20:26:44.096661');
      INSERT INTO public.discapacidad(id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (5, 'OTRA', '', '2018-11-26', NULL, '2018-11-26 20:26:02.877509', '2018-11-26 20:26:44.096661');
      INSERT INTO public.discapacidad(id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (6, 'NINGUNA', '', '2018-11-26', NULL, '2018-11-26 20:26:02.877509', '2018-11-26 20:26:44.096661');
      --SELECT setval('discapacidad_id_seq', 101, true);
    SQL
  end

  def down
    drop_table :discapacidad
  end
end
