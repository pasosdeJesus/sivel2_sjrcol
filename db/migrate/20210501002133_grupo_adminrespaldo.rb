class GrupoAdminrespaldo < ActiveRecord::Migration[6.1]
  def up
    Sip::Grupo.create!(id: 25,
                       nombre: 'ADMINISTRA COPIAS',
                       fechacreacion: Date.today,
                       created_at: Date.today,
                       updated_at: Date.today
                     )
    Heb412Gen::Carpetaexclusiva.create!(carpeta: '/Respaldos', 
                                        grupo_id: 25, 
                                        created_at: Date.today,
                                        updated_at: Date.today)
  end
  def down
    Heb412Gen::Carpetaexclusiva.where(carpeta: '/Respaldos').destroy_all
    Sip::Grupo.where(id: 25).destroy_all
  end
end
