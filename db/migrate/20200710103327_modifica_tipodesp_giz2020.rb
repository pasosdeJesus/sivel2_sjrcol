class ModificaTipodespGiz2020 < ActiveRecord::Migration[6.0]
  def up
    if Sivel2Sjr::Tipodesp.where(id: 1).count == 1
      Sivel2Sjr::Tipodesp.find(1).fechadeshabilitacion='2020-07-07'
    end
    if Sivel2Sjr::Tipodesp.where(id: 101).count == 0
      Sivel2Sjr::Tipodesp.create(id:101,
                                 nombre: 'INDIVIDUAL',
                                 observaciones: 'Persona que se ha visto forzada a migrar dentro del territorio nacional, abandonando su residencia o actividades económicas habituales, porque su vida, integridad física, seguridad o libertad personales han sido vulneradas o se encuentran directamente amenazadas, con ocasión una situación de conflicto armado interno, violencia generalizada y/o violaciones de derechos.')
    end
    if Sivel2Sjr::Tipodesp.where(id: 102).count == 0
      Sivel2Sjr::Tipodesp.create(id:102,
                                 nombre: 'MÚLTIPLE',
                                 observaciones: 'Sucesos que afectan ente 15 y 49 personas, o a entre 3 y 9 familias.')
    end
  end
end
