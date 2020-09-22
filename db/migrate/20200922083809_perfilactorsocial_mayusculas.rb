class PerfilactorsocialMayusculas < ActiveRecord::Migration[6.0]
  def up
    execute <<-SQL
      UPDATE public.perfilmigracion SET
        nombre='EN TRÁNSITO', 
        observaciones='Corresponde a un perfil de actor social ' ||
        'y es usado en reporte GIFMM y pestaña migracion de caso'
        WHERE id=2;
      UPDATE public.sip_perfilactorsocial SET
        nombre='CON VOCACIÓN DE PERMANENCIA',
        observaciones='Corresponde a un perfil de migración ' ||
        'y es usado en reporte GIFMM'
        WHERE id=10;
      UPDATE public.sip_perfilactorsocial SET
        nombre='EN TRÁNSITO',
        observaciones='Corresponde a un perfil de migración ' ||
        'y es usado en reporte GIFMM'
        WHERE id=11;
      UPDATE public.sip_perfilactorsocial SET
        nombre='PENDULAR',
        observaciones='Corresponde a un perfil de migración ' ||
        'y es usado en reporte GIFMM'
        WHERE id=12;
      UPDATE public.sip_perfilactorsocial SET
        nombre='COMUNIDAD DE ACOGIDA',
        observaciones='Usado en reporte GIFMM'
        WHERE id=13;
    SQL
  end

  def down
    execute <<-SQL
      UPDATE public.perfilmigracion SET
        nombre='EN TRANSITO', observaciones='' WHERE id=2;
      UPDATE public.sip_perfilactorsocial SET
        nombre='Vocación de permanencia', observaciones='' WHERE id=10;
      UPDATE public.sip_perfilactorsocial SET
        nombre='Tránsito', observaciones='' WHERE id=11;
      UPDATE public.sip_perfilactorsocial SET
        nombre='Pendular', observaciones='' WHERE id=12;
      UPDATE public.sip_perfilactorsocial SET
        nombre='Comunidad de acogida' WHERE id=13;
    SQL
  end
end
