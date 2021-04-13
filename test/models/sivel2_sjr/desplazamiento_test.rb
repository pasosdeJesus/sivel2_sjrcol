# encoding: UTF-8

require_relative '../../test_helper'

module Sivel2Sjr
  class DesplazamientoTest < ActiveSupport::TestCase

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
      created_at: "2021-04-14",
      updated_at: "2021-04-14"
    }
    
    PRUEBA_UBICACIONPRE2= {
      pais_id: 862,
      nombre: 'VENEZUELA',
      created_at: "2021-04-14",
      updated_at: "2021-04-14"
    }
 
    PRUEBA_DESPLAZAMIENTO= {
      id_caso: 0, # por llenar
      fechaexpulsion: "2021-04-12",
      fechallegada: "2021-04-13",
      created_at: "2014-12-02",
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

      desplazamiento = Desplazamiento.create(PRUEBA_DESPLAZAMIENTO.merge(
        { expulsionubicacionpre_id: u1.id, llegadaubicacionpre_id: u2.id, }))
      assert desplazamiento.valid?
      desplazamiento.destroy
      u2.destroy
      u1.destroy
      casosjr.destroy
      victima.destroy
      persona.destroy
      caso.destroy
    end

    test "no valido" do
      desplazamiento = Desplazamiento.new PRUEBA_DESPLAZAMIENTO
      assert_not desplazamiento.valid?
      desplazamiento.destroy
    end


  end
end
