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
    validate: true, dependent: :destroy, 
    class_name: 'Unidadayuda'
  
  belongs_to :mecanismodeentrega, foreign_key: 'mecanismodeentrega_id', 
    validate: true, dependent: :destroy, 
    class_name: 'Mecanismodeentrega'
  
  belongs_to :modalidadentrega, foreign_key: 'modalidadentrega_id', 
    validate: true, dependent: :destroy, 
    class_name: 'Modalidadentrega'
  
  belongs_to :tipotransferencia, foreign_key: 'tipotransferencia_id', 
    validate: true, dependent: :destroy, 
    class_name: 'Tipotransferencia'
  
  belongs_to :frecuenciaentrega, foreign_key: 'frecuenciaentrega_id', 
    validate: true, dependent: :destroy, 
    class_name: 'Frecuenciaentrega'
end                                              
                                                 
                                                 
                                                 
                                                 
                                                 
                                                 
