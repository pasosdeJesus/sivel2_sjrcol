class HomologaDatosbioCarTejedores < ActiveRecord::Migration[6.0]

  HESCOLARIDAD = {
    0 => 1136, #SIN INFORMACIÓN -> Ninguno
    1 => 1111, #PREESCOLAR
    2 => 1117, #PRIMARIA -> Quinto Primaria
    3 => 1123, #SECUNDARIA -> Once Media
    4 => 1127, #TÉCNICO -> 3 año Técnico Tecnólogo
    5 => 1132, #PROFESIONAL -> 5 año Universidad
    6 => 1136, #NINGUNO
    7 => 1136, #ANALFABETA -> Ninguno
    8 => 1115, #PRIMARIA INCOMPLETA -> Tercero Primaria
    9 => 1120  #SECUNDARIA INCOMPLETA -> Octavo
  }

  HCOTIZANTE = {  # Tipo de afiliación
    'C' => 1145, # Cotizante
    'B' => 1146  # Beneficiario
  }

  def up
    nump = 1
    dbs = Sip::Datosbio.where('persona_id IS NOT NULL').
      where('telefono IS NOT NULL AND TRIM(telefono)<>\'\'').
      where('persona_id NOT IN (
      SELECT persona_id FROM cor1440_gen_caracterizacionpersona AS c 
      JOIN mr519_gen_respuestafor AS r ON c.respuestafor_id=r.id 
      AND formulario_id=101)').order('id')
    dbs.each do |db|
      puts "Procesando datos de persona #{nump} con id #{db.persona_id}"
      r = Mr519Gen::Respuestafor.create(formulario_id: 101,
                                        fechaini: Date.today,
                                        fechacambio: Date.today)
      Mr519Gen::Valorcampo.create(respuestafor_id: r.id,
                                  campo_id: 1041,
                                  valor: db.res_departamento_id)
      Mr519Gen::Valorcampo.create(respuestafor_id: r.id,
                                  campo_id: 1042,
                                  valor: db.res_municipio_id)
      Mr519Gen::Valorcampo.create(respuestafor_id: r.id,
                                  campo_id: 1040,
                                  valor: db.veredares)
      Mr519Gen::Valorcampo.create(respuestafor_id: r.id,
                                  campo_id: 1039,
                                  valor: db.direccionres)
      Mr519Gen::Valorcampo.create(respuestafor_id: r.id,
                                  campo_id: 1043,
                                  valor: db.telefono)
      Mr519Gen::Valorcampo.create(respuestafor_id: r.id,
                                  campo_id: 1044,
                                  valor: db.correo)
      if db.discapacidad_id
        Mr519Gen::Valorcampo.create(
          respuestafor_id: r.id,
          campo_id: 1048,
          valorjson: ['', db.discapacidad_id])
      end
      Mr519Gen::Valorcampo.create(respuestafor_id: r.id,
                                  campo_id: 1049,
                                  valor: db.otradiscapacidad)
      # cvulnerabilidad_id no es homologable, solo está en 13 registros
      if db.escolaridad_id && db.escolaridad_id > 0
        Mr519Gen::Valorcampo.create(respuestafor_id: r.id,
                                    campo_id: 1054,
                                    valor: HESCOLARIDAD[db.escolaridad_id])
      end

      Mr519Gen::Valorcampo.create(respuestafor_id: r.id,
                                  campo_id: 1055,
                                  valor: db.anioaprobacion)
      if db.nivelsisben  
        # nivelsisben integer 1057  no tiene datos sensatos
        Mr519Gen::Valorcampo.create(respuestafor_id: r.id,
                                    campo_id: 1056,
                                    valor: 1137) # si
      end

      Mr519Gen::Valorcampo.create(respuestafor_id: r.id,
                                  campo_id: 1059,
                                  valor: db.eps)

      if db.tipocotizante
        # tipocotizante varchar(1)  C o B
        Mr519Gen::Valorcampo.create(respuestafor_id: r.id,
                                    campo_id: 1060,
                                    valor: HCOTIZANTE[db.tipocotizante]) 
        Mr519Gen::Valorcampo.create(respuestafor_id: r.id,
                                    campo_id: 1058,
                                    valor: 1143)  # Afiliacion servicio Salud Si
      end

      if db.sistemapensional || db.sistemapensional === false
        Mr519Gen::Valorcampo.create(respuestafor_id: r.id,
                                    campo_id: 1061,
                                    valor: db.sistemapensional ? 1147 : 1148)
      end

      if db.afiliadoarl || db.afiliadoarl === false
        Mr519Gen::Valorcampo.create(respuestafor_id: r.id,
                                    campo_id: 1062,
                                    valor: db.afiliadoarl ? 1149 : 1150)
      end

      if db.subsidioestado.strip.length > 0
        Mr519Gen::Valorcampo.create(respuestafor_id: r.id,
                                    campo_id: 1063,
                                    valor: 1151)  # Si en subsidios del estado
        Mr519Gen::Valorcampo.create(respuestafor_id: r.id,
                                    campo_id: 1064,
                                    valor: db.subsidioestado)
      end

      Mr519Gen::Valorcampo.create(respuestafor_id: r.id,
                                  campo_id: 1065,
                                  valor: db.personashogar)
      Mr519Gen::Valorcampo.create(respuestafor_id: r.id,
                                  campo_id: 1066,
                                  valor: db.menores12acargo)
      Mr519Gen::Valorcampo.create(respuestafor_id: r.id,
                                  campo_id: 1067,
                                  valor: db.mayores60acargo)
      # espaciopp es null para todos
      # nombreespaciopp no homologable está en 70 registros
      # fecahingespaciopp no homologable está en 1 registro
      # fecharecoleccion no homologable
      #
      # espaciopart_id no homologable está en 9 registros
      cp = Cor1440Gen::Caracterizacionpersona.create(
        persona_id: db.persona_id,
        respuestafor_id: r.id,
        ulteditor_id: 1
      )
      cp.save!
      nump += 1
    end
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
