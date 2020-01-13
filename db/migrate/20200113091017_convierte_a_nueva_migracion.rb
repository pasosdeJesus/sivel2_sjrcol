class ConvierteANuevaMigracion < ActiveRecord::Migration[6.0]
  def up
    rm = 0
    Sivel2Sjr::Casosjr.where('fechallegada IS NOT NULL').where('fechallegadam IS NOT NULL').each do |c| 
      m = Sivel2Sjr::Migracion.create(
        caso_id: c.id_caso,
        fechasalida: c.fechasalida,
        fechallegada: c.fechallegada,
        salida_pais_id: c.salidam ? c.salidam.id_pais : nil,
        salida_departamento_id: c.salidam ? c.salidam.id_departamento : nil,
        salida_municipio_id: c.salidam ? c.salidam.id_municipio : nil,
        salida_clase_id: c.salidam ? c.salidam.id_clase : nil,
        llegada_pais_id: c.llegadam ? c.llegadam.id_pais : nil,
        llegada_departamento_id: c.llegadam ? c.llegadam.id_departamento : nil,
        llegada_municipio_id: c.llegadam ? c.llegadam.id_municipio : nil,
        llegada_clase_id: c.llegadam ? c.llegadam.id_clase : nil,
        statusmigratorio_id: (c.id_statusmigratorio == 2 ||  # Refugidado
                              c.id_statusmigratorio == 4) ?  # Apátrida
                              0 : # Sin Informacion
                              c.id_statusmigratorio,
        proteccion_id:         8, # Refugiado
        salvoNpi: c.docrefugiado,
        fechaNpi: c.fechadecrefugio,
        causaRefugio_id: c.categoriaref, 
        observacionesref: (c.motivom ? c.motivom + '.  ' : '') +
                          (c.estatus_refugio ? c.estatus_refugio + '.  ' : '') +
                          (c.observacionesref ? c.observacionesref : '')
      );
      m.save!
      rm += 1
    end
    puts "Cantidad con migración y refugio: #{rm}"
    rm = 0
    Sivel2Sjr::Casosjr.where('fechallegada IS NOT NULL').where('fechallegadam IS NULL').each do |c|
      m = Sivel2Sjr::Migracion.create(
        caso_id: c.id_caso,
        fechasalida: c.fechasalida,
        fechallegada: c.fechallegada,
        salida_pais_id: c.salida ? c.salida.id_pais : nil,
        salida_departamento_id: c.salida ? c.salida.id_departamento : nil,
        salida_municipio_id: c.salida ? c.salida.id_municipio : nil,
        salida_clase_id: c.salida ? c.salida.id_clase : nil,
        llegada_pais_id: c.llegada ? c.llegada.id_pais : nil,
        llegada_departamento_id: c.llegada ? c.llegada.id_departamento : nil,
        llegada_municipio_id: c.llegada ? c.llegada.id_municipio : nil,
        llegada_clase_id: c.llegada ? c.llegada.id_clase : nil,
        statusmigratorio_id: (c.id_statusmigratorio == 2 ||  # Refugidado
                              c.id_statusmigratorio == 4) ?  # Apátrida
                              0 : # Sin Informacion
                              c.id_statusmigratorio,
        proteccion_id:         8, # Refugiado
        salvoNpi: c.docrefugiado,
        fechaNpi: c.fechadecrefugio,
        causaRefugio_id: c.categoriaref, 
        observacionesref: (c.motivom ? c.motivom + '.  ' : '') +
                          (c.estatus_refugio ? c.estatus_refugio + '.  ' : '') +
                          (c.observacionesref ? c.observacionesref : '')
      );
      m.save!
      rm += 1
    end
    puts "Cantidad con refugio y sin migracion: #{rm}"
    rm = 0
    Sivel2Sjr::Casosjr.where('fechallegada IS NULL').where('fechallegadam IS NOT NULL').each do |c|
      m = Sivel2Sjr::Migracion.create(
        caso_id: c.id_caso,
        fechasalida: c.fechasalidam,
        fechallegada: c.fechallegadam,
        salida_pais_id: c.salidam ? c.salidam.id_pais : nil,
        salida_departamento_id: c.salidam ? c.salidam.id_departamento : nil,
        salida_municipio_id: c.salidam ? c.salidam.id_municipio : nil,
        salida_clase_id: c.salidam ? c.salidam.id_clase : nil,
        llegada_pais_id: c.llegadam ? c.llegadam.id_pais : nil,
        llegada_departamento_id: c.llegadam ? c.llegadam.id_departamento : nil,
        llegada_municipio_id: c.llegadam ? c.llegadam.id_municipio : nil,
        llegada_clase_id: c.llegadam ? c.llegadam.id_clase : nil,
        statusmigratorio_id: 0, # Sin Informacion
        proteccion_id: 0, # Sin Inormacion
        salvoNpi: nil,
        fechaNpi: nil,
        causaRefugio_id: nil,
        observacionesref: (c.motivom ? c.motivom + '.  ' : '')
      );
      m.save!
      rm += 1
    end
    puts "Cantidad sin refugio y con migracion: #{rm}"
  end


  def down
  end
end
