class Detallefinanciero < ActiveRecord::Base

  belongs_to :actividad, 
    foreign_key: 'actividad_id',
    validate: true, 
    class_name: 'Cor1440Gen::Actividad'

  belongs_to :proyectofinanciero, 
    foreign_key: 'proyectofinanciero_id', 
    validate: true, 
    class_name: 'Cor1440Gen::Proyectofinanciero'

  belongs_to :actividadpf, 
    foreign_key: 'actividadpf_id', 
    validate: true, 
    class_name: 'Cor1440Gen::Actividadpf'

  belongs_to :unidadayuda, 
    foreign_key: 'unidadayuda_id', 
    validate: true, 
    class_name: 'Unidadayuda'

  belongs_to :mecanismodeentrega, 
    foreign_key: 'mecanismodeentrega_id', 
    validate: true, 
    class_name: 'Mecanismodeentrega'

  belongs_to :modalidadentrega, 
    foreign_key: 'modalidadentrega_id', 
    validate: true, 
    class_name: 'Modalidadentrega'

  belongs_to :tipotransferencia, 
    foreign_key: 'tipotransferencia_id', 
    validate: true, 
    class_name: 'Tipotransferencia'

  belongs_to :frecuenciaentrega, 
    foreign_key: 'frecuenciaentrega_id', 
    validate: true, 
    class_name: 'Frecuenciaentrega'

  has_many :detallefinanciero_persona, 
    dependent: :delete_all,
    class_name: '::DetallefinancieroPersona',
    foreign_key: 'detallefinanciero_id'

  has_many :persona,
    class_name: 'Sip::Persona', 
    through: 'detallefinanciero_persona'

  validates :cantidad, :numericality => { greater_than_or_equal_to: 0 }
  validates :valorunitario, :numericality => { greater_than_or_equal_to: 0 }
  validates :valortotal, :numericality => { greater_than_or_equal_to: 0 }
  validates :numeromeses, :numericality => { greater_than_or_equal_to: 0 }
  validates :numeroasistencia, :numericality => { greater_than_or_equal_to: 0 }


  validates :actividadpf, uniqueness: {
    scope: :actividad,
    message: 'En talba detalle financiero no puede repetir ' +
      'actividad de marco lógico'
  }

  attr_accessor :convenioactividad

  def convenioactividad=(valor)
    if valor.nil? || valor.split(" - ").count < 2
      self.proyectofinanciero_id = nil
      self.actividadpf_id = nil
      return
    end
    convenio = Cor1440Gen::Proyectofinanciero.where(
      nombre: valor.split(" - ")[0])
    actividadpf = Cor1440Gen::Actividadpf.where(
      "titulo LIKE '%' || ? || '%'", valor.split(" - ")[1].strip)
    if convenio.count == 1 && actividadpf.count == 1 
      if self.proyectofinanciero_id.nil? && self.actividadpf_id.nil?
        # Solo necesitan establecerse para nuevos detallesfinancieros
        # los existentes ya vienen con esos campos llenos
        self.proyectofinanciero_id = convenio[0].id
        self.actividadpf_id = actividadpf[0].id
      end
    else
      puts "** No se identificó convenio '#{convenio[0].id}' con " + 
        "actividadpf '#{actividadpf[0].id}'";
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
