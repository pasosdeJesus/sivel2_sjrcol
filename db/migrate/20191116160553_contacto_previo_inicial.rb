class ContactoPrevioInicial < ActiveRecord::Migration[6.0]
  def up
    Migracontactopre.create!(
      { id: 1, nombre: 'AMIGO', fechacreacion: '2019-11-16'})
    Migracontactopre.create!(
      { id: 2, nombre: 'CONOCIDO', fechacreacion: '2019-11-16'})
    Migracontactopre.create!(
      { id: 3, nombre: 'FAMILIAR', fechacreacion: '2019-11-16'})
    Migracontactopre.create!(
      { id: 4, nombre: 'NINGUNO', fechacreacion: '2019-11-16'})
  end

  def down
    Migracontactopre.where(id: [1,2,3,4]).destroy_all
  end
end
