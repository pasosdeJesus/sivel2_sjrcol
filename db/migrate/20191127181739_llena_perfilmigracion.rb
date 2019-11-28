class LlenaPerfilmigracion < ActiveRecord::Migration[6.0]
  def up
    Perfilmigracion.create!(
      id: 1, nombre: 'CON VOCACIÓN DE PERMANENCIA', fechacreacion: '2019-11-27',
      observaciones: '')
    Perfilmigracion.create(
      id: 2, nombre: 'EN TRANSITO',  fechacreacion: '2019-11-27',
      observaciones: 'Grupo familiar que buscan atravesar Colombia con la finalidad de llegar a un tercer país')
    Perfilmigracion.create(
      id: 3, nombre: 'PENDULAR', fechacreacion: '2019-11-27',
      observaciones: 'Grupo familiar que cruza de manera constante la frontera, viene a Colombia a recibir la ayuda o dotarse de bienes y servicios y retorna a Venezuela')
  end
  def down
    Perfilmigracion.where(id: [1,2,3]).destroy_all
  end
end
