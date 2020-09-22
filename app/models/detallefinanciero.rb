# encoding: UTF-8
class Detallefinanciero < ActiveRecord::Base

  validates :cantidad, :numericality => { greater_than_or_equal_to: 0 }
  validates :valorunitario, :numericality => { greater_than_or_equal_to: 0 }
  validates :valortotal, :numericality => { greater_than_or_equal_to: 0 }
  validates :numeromeses, :numericality => { greater_than_or_equal_to: 0 }
  validates :numeroasistencia, :numericality => { greater_than_or_equal_to: 0 }

  belongs_to :actividad, foreign_key: 'actividad_id',
    validate: true, class_name: 'Cor1440Gen::Actividad'

  belongs_to :proyectofinanciero, foreign_key: 'proyectofinanciero_id', 
    validate: true, class_name: 'Cor1440Gen::Proyectofinanciero'
  
  belongs_to :actividadpf, foreign_key: 'actividadpf_id', 
    validate: true, class_name: 'Cor1440Gen::Actividadpf'
  
  belongs_to :unidadayuda, foreign_key: 'unidadayuda_id', 
    validate: true, class_name: 'Unidadayuda'
  
  belongs_to :mecanismodeentrega, foreign_key: 'mecanismodeentrega_id', 
    validate: true, class_name: 'Mecanismodeentrega'
  
  belongs_to :modalidadentrega, foreign_key: 'modalidadentrega_id', 
    validate: true, class_name: 'Modalidadentrega'
  
  belongs_to :tipotransferencia, foreign_key: 'tipotransferencia_id', 
    validate: true, class_name: 'Tipotransferencia'
  
  belongs_to :frecuenciaentrega, foreign_key: 'frecuenciaentrega_id', 
    validate: true, class_name: 'Frecuenciaentrega'
  
  attr_accessor :convenioactividad

  def convenioactividad=(valor)
    convenio = Cor1440Gen::Proyectofinanciero.where(
      nombre: valor.split(" - ")[0])
    actividadpf = Cor1440Gen::Actividadpf.where(
      "titulo LIKE '%' || ? || '%'", valor.split(" - ")[1].strip)
    if convenio.count == 1 && actividadpf.count == 1
      self.proyectofinanciero_id = convenio[0].id
      self.actividadpf_id = actividadpf[0].id
    else
      puts "** No se identificó convenio '#{convenio}' con " + 
        "actividadpf '#{actividadpf}'";
    end
  end
  
  def convenioactividad
    if self.proyectofinanciero_id and self.actividadpf_id
      convenio = Cor1440Gen::Proyectofinanciero.find(self.proyectofinanciero_id).nombre
      actividadpf = Cor1440Gen::Actividadpf.find(self.actividadpf_id).titulo
      return convenio + ' - ' + actividadpf
    else
      return ''
    end
  end
end                                              
                                                 
                                                 
                                                 
                                                 
                                                 
                                                 
