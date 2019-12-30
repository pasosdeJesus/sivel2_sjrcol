class UbicacionInicialOficinas < ActiveRecord::Migration[6.0]
  def up
    execute <<-SQL
      UPDATE public.sip_oficina SET pais_id=170, departamento_id=47, municipio_id=86,
        clase_id=86 WHERE id=11771; --VALLE
      UPDATE public.sip_oficina SET pais_id=170, departamento_id=43, municipio_id=1319,
        clase_id=9899 WHERE id=3; --BARRANCABERMEJA
      UPDATE public.sip_oficina SET pais_id=170, departamento_id=39, municipio_id=32,
        clase_id=9041 WHERE id=4; --CUCUTA
      UPDATE public.sip_oficina SET pais_id=170, departamento_id=38, municipio_id=44,
        clase_id=7907 WHERE id=5; --NARIÑO
      UPDATE public.sip_oficina SET pais_id=170, departamento_id=27, municipio_id=1216,
        clase_id=4758 WHERE id=6; --SOACHA
      UPDATE public.sip_oficina SET pais_id=170, departamento_id=4, municipio_id=24,
        clase_id=238 WHERE id=7; --NACIONAL
    SQL
  end

  def down
    execute <<-SQL
      UPDATE public.sip_oficina SET pais_id=NULL, departamento_id=NULL, 
        municipio_id=NULL, clase_id=NULL WHERE id>='2' AND id<='7'; 
    SQL
  end
end
