class CompletaTemaJrs < ActiveRecord::Migration[6.0]
  def up
      UPDATE sip_tema SET
        color_flota_subitem_fuente = '#1f4e8c',
        color_flota_subitem_fondo = '#f2f2ff'
      WHERE id=1;
    SQL
  end
  def down
  end
end
