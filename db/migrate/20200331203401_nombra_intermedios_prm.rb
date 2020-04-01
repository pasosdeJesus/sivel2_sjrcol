class NombraIntermediosPrm < ActiveRecord::Migration[6.0]
  def up
    execute <<-SQL
      UPDATE cor1440_gen_mindicadorpf SET
        descd1 = 'Contactos',
        descd2 = 'Familiares'
        WHERE indicadorpf_id=214;
      UPDATE cor1440_gen_mindicadorpf SET
        descd1 = 'Contactos',
        descd2 = 'Familiares',
        descd3 = 'Suma'
        WHERE indicadorpf_id=215;
      UPDATE cor1440_gen_mindicadorpf SET
        descd1 = 'Directos',
        descd2 = 'Indirectos',
        descd3 = null
        WHERE indicadorpf_id=216;
      UPDATE cor1440_gen_mindicadorpf SET
        descd1 = 'Lactantes',
        descd2 = 'Gestantes (x2)',
        descd3 = 'Bebes<1 año'
        WHERE indicadorpf_id=222;
    SQL
  end
  def down
  end
end
