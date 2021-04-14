# encoding: UTF-8

require_relative '../../test_helper'

module Sivel2Sjr
  class MigracionTest < ActiveSupport::TestCase

    PRUEBA_CASO= {
      titulo: "ejemplo",
      fecha: "2021-04-14",
      memo: "Desplazamiento",
      created_at: "2021-04-14",
    }

    PRUEBA_PERSONA = {
      nombres: "Juan",
      apellidos: "Perez",
      sexo: 'M',
      created_at: "2021-04-14",
    }

    PRUEBA_CASOSJR = {
      id_caso: 0, # por llenar
      contacto_id: 0, # por llenar
      fecharec: "2021-04-14",
      asesor: 1,
      created_at: "2021-04-14",
    }
    
    PRUEBA_UBICACIONPRE1= {
      pais_id: 170,
      nombre: 'COLOMBIA',
      latitud: 1.1,
      longitud: 1.2,
      lugar: 'lugar1',
      sitio: 'sitio1',
      tsitio_id: 1,
      created_at: "2021-04-14",
      updated_at: "2021-04-14"
    }
    
    PRUEBA_UBICACIONPRE2= {
      pais_id: 862,
      departamento_id: 1,
      municipio_id: 25,
      clase_id: 217,
      nombre: 'VENEZUELA / DISTRITO CAPITAL / BOLIVARIANO LIBERTADOR / CARACAS',
      latitud: 2.1,
      longitud: 2.2,
      lugar: 'lugar2',
      sitio: 'sitio2',
      tsitio_id: 2,
      created_at: "2021-04-14",
      updated_at: "2021-04-14"
    }
 
    PRUEBA_MIGRACION = {
      caso_id: 0, # por llenar
      fechasalida: "2021-04-12",
      fechallegada: "2021-04-13"
    }

    test "valido" do
      caso = Sivel2Gen::Caso.create(PRUEBA_CASO)
      assert caso.valid?
      persona= Sip::Persona.create(PRUEBA_PERSONA)
      assert persona.valid?
      victima= Sivel2Gen::Victima.create({
        id_caso: caso.id,
        id_persona: persona.id
      })
      assert victima.valid?
      casosjr = Sivel2Sjr::Casosjr.create(PRUEBA_CASOSJR.merge(
        {id_caso: caso.id, contacto_id: persona.id}))
      assert casosjr.valid?
      u1 = Sip::Ubicacionpre.create(PRUEBA_UBICACIONPRE1)
      assert u1.valid?
      u2 = Sip::Ubicacionpre.create(PRUEBA_UBICACIONPRE2)
      assert u2.valid?

      migracion = Migracion.create(PRUEBA_MIGRACION.merge(
        { caso_id: caso.id, 
          salidaubicacionpre_id: u1.id, 
          llegadaubicacionpre_id: u2.id, 
      }))
      assert migracion.valid?

      assert_equal 170, migracion.salida_pais_id
      assert_equal 170, migracion.salida_pais.id
      assert_nil migracion.salida_departamento_id
      assert_nil migracion.salida_departamento
      assert_nil migracion.salida_municipio_id
      assert_nil migracion.salida_municipio
      assert_nil migracion.salida_clase_id
      assert_nil migracion.salida_clase
      assert_equal 'lugar1', migracion.salida_lugar
      assert_equal 'sitio1', migracion.salida_sitio
      assert_equal 1.1, migracion.salida_latitud
      assert_equal 1.2, migracion.salida_longitud
      assert_equal 1, migracion.salida_tsitio_id

      assert_equal 862, migracion.llegada_pais_id
      assert_equal 862, migracion.llegada_pais.id
      assert_equal 1, migracion.llegada_departamento_id
      assert_equal 1, migracion.llegada_departamento.id
      assert_equal 25, migracion.llegada_municipio_id
      assert_equal 25, migracion.llegada_municipio.id
      assert_equal 217, migracion.llegada_clase_id
      assert_equal 217, migracion.llegada_clase.id
      assert_equal 'lugar2', migracion.llegada_lugar
      assert_equal 'sitio2', migracion.llegada_sitio
      assert_equal 2.1, migracion.llegada_latitud
      assert_equal 2.2, migracion.llegada_longitud
      assert_equal 2, migracion.llegada_tsitio_id

      migracion.destroy
      u2.destroy
      u1.destroy
      casosjr.destroy
      victima.destroy
      persona.destroy
      caso.destroy
    end

    test "no valido" do
      migracion = Migracion.new PRUEBA_MIGRACION.merge({fechasalida: nil})
      assert_not migracion.valid?
      migracion.destroy
    end


  end
end
