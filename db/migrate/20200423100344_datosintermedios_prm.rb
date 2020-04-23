class DatosintermediosPrm < ActiveRecord::Migration[6.0]

  def up
    Cor1440Gen::Datointermedioti.create(
      id: 100, tipoindicador_id: 107,
      nombre: 'Contactos'
    )
    Cor1440Gen::Datointermedioti.create(
      id: 101, tipoindicador_id: 107,
      nombre: 'Familiares'
    )
    Cor1440Gen::Datointermedioti.create(
      id: 106, tipoindicador_id: 108,
      nombre: 'Contactos con Respuesta'
    )
    Cor1440Gen::Datointermedioti.create(
      id: 107, tipoindicador_id: 108,
      nombre: 'Familiares con Respuesta'
    )
    Cor1440Gen::Datointermedioti.create(
      id: 110, tipoindicador_id: 109,
      nombre: 'Personas casos R1A3'
    )
    Cor1440Gen::Datointermedioti.create(
      id: 111, tipoindicador_id: 109,
      nombre: 'Personas casos R1A6'
    )
    Cor1440Gen::Datointermedioti.create(
      id: 112, tipoindicador_id: 109,
      nombre: 'Personas casos R1A7 < 18'
    )
    Cor1440Gen::Datointermedioti.create(
      id: 113, tipoindicador_id: 109,
      nombre: 'Personas casos R1A7 >= 18'
    )
    Cor1440Gen::Datointermedioti.create(
      id: 114, tipoindicador_id: 109,
      nombre: 'Defunciones R1A8'
    )
    Cor1440Gen::Datointermedioti.create(
      id: 115, tipoindicador_id: 109,
      nombre: 'Beneficiarios R1A8'
    )
    Cor1440Gen::Datointermedioti.create(
      id: 116, tipoindicador_id: 109,
      nombre: 'Directos'
    )
    Cor1440Gen::Datointermedioti.create(
      id: 117, tipoindicador_id: 110,
      nombre: 'Indirectos'
    )
  end

  def down
    Cor1440Gen::Datointermedioti.where('id >= 100 AND id <= 117').destroy_all
  end

end
