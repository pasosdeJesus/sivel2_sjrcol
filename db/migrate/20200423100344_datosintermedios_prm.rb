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
      nombre: 'Personas en casos con ayuda alimentaria'
    )
    Cor1440Gen::Datointermedioti.create(
      id: 111, tipoindicador_id: 109,
      nombre: 'Personas en casos con ayuda de transporte'
    )
    Cor1440Gen::Datointermedioti.create(
      id: 112, tipoindicador_id: 109,
      nombre: 'Menores en casos con kit escolar'
    )
    Cor1440Gen::Datointermedioti.create(
      id: 113, tipoindicador_id: 109,
      nombre: 'Adultos en casos con kit escolar'
    )
    Cor1440Gen::Datointermedioti.create(
      id: 114, tipoindicador_id: 109,
      nombre: 'Apoyos gastos funerarios'
    )
    Cor1440Gen::Datointermedioti.create(
      id: 115, tipoindicador_id: 109,
      nombre: 'Beneficiarios apoyo gasto funerario (-1)'
    )
    Cor1440Gen::Datointermedioti.create(
      id: 116, tipoindicador_id: 109,
      nombre: 'Directos'
    )
    Cor1440Gen::Datointermedioti.create(
      id: 117, tipoindicador_id: 109,
      nombre: 'Indirectos'
    )
    Cor1440Gen::Datointermedioti.create(
      id: 120, tipoindicador_id: 110,
      nombre: 'Lactantes'
    )
    Cor1440Gen::Datointermedioti.create(
      id: 121, tipoindicador_id: 110,
      nombre: 'Gestantes+Bebés'
    )
    Cor1440Gen::Datointermedioti.create(
      id: 122, tipoindicador_id: 110,
      nombre: 'Bebés'
    )

  end

  def down
    Cor1440Gen::Datointermedioti.where('id >= 100 AND id <= 122').destroy_all
  end

end
