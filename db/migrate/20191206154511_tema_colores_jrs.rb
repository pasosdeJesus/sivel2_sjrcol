class TemaColoresJrs < ActiveRecord::Migration[6.0]
  def up
    execute <<-SQL
      UPDATE sip_tema SET
        fondo = '#f2f2ff',
        color_fuente = '#000000',
        nav_ini = '#5377a6',
        nav_fin = '#1f4e8c',
        nav_fuente = '#f2f2ff',
        fondo_lista = '#5377a6',
        btn_primario_fondo_ini = '#04c4d9',
        btn_primario_fondo_fin = '#1f4e8c',
        btn_primario_fuente = '#f2f2ff',
        btn_peligro_fondo_ini = '#ff1b30',
        btn_peligro_fondo_fin = '#ad0a0a',
        btn_peligro_fuente = '#f2f2ff',
        btn_accion_fondo_ini = '#f2f2ff',
        btn_accion_fondo_fin= '#d6d6f0',
        btn_accion_fuente = '#000000',
        alerta_exito_fondo = '#01a7d1',
        alerta_exito_fuente = '#1f4e8c',
        alerta_problema_fondo = '#f8d7da',
        alerta_problema_fuente = '#721c24'
      WHERE id=1;
    SQL
  end
  def down
  end
end
