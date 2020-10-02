class CambianombresSectorgifmm < ActiveRecord::Migration[6.0]
  def change
    execute <<-SQL
      UPDATE public.sectorgifmm
        SET nombre='Agua y saneamiento' WHERE id=1;
      UPDATE public.sectorgifmm
        SET nombre='Comunicación con Comunidades' WHERE id=4;
      UPDATE public.sectorgifmm
        SET nombre='Manejo de Información' WHERE id=8;
      UPDATE public.sectorgifmm
        SET nombre='Multipurpose CBI' WHERE id=9;
      UPDATE public.sectorgifmm
        SET nombre='Protección NNA' WHERE id=15;
      UPDATE public.sectorgifmm
        SET nombre='Recaudación fondos' WHERE id=16;
      UPDATE public.sectorgifmm
        SET nombre='Seguridad Alimentaria' WHERE id=18;
      UPDATE public.sectorgifmm
        SET nombre='Transporte Humanitario' WHERE id=19;
      UPDATE public.sectorgifmm
        SET nombre='Trata de Personas' WHERE id=20;
    SQL
  end
end
