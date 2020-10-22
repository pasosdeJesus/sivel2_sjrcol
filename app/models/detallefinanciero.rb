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
    class_name: 'Cor1440Gen::Actividadpf'

  belongs_to :unidadayuda, 
    foreign_key: 'unidadayuda_id',
    optional: true,
    class_name: 'Unidadayuda'

  belongs_to :mecanismodeentrega, 
    foreign_key: 'mecanismodeentrega_id', 
    optional: true,
    class_name: 'Mecanismodeentrega'

  belongs_to :modalidadentrega, 
    foreign_key: 'modalidadentrega_id', 
    optional: true,
    class_name: 'Modalidadentrega'

  belongs_to :tipotransferencia, 
    foreign_key: 'tipotransferencia_id', 
    optional: true,
    class_name: 'Tipotransferencia'

  belongs_to :frecuenciaentrega, 
    foreign_key: 'frecuenciaentrega_id', 
    optional: true,
    class_name: 'Frecuenciaentrega'

  has_many :detallefinanciero_persona, 
    dependent: :delete_all,
    class_name: '::DetallefinancieroPersona',
    foreign_key: 'detallefinanciero_id'

  has_many :persona,
    class_name: 'Sip::Persona', 
    through: 'detallefinanciero_persona'

  validates :cantidad, :numericality => { greater_than_or_equal_to: 0 }, 
    :allow_nil => true
  validates :valorunitario, :numericality => { greater_than_or_equal_to: 0 },
    :allow_nil => true
  validates :valortotal, :numericality => { greater_than_or_equal_to: 0 },
    :allow_nil => true
  validates :numeromeses, :numericality => { greater_than_or_equal_to: 0 },
    :allow_nil => true
  validates :numeroasistencia, :numericality => { greater_than_or_equal_to: 0 },
    :allow_nil => true

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
      proyectofinanciero_id: convenio[0].id)
      .where(
      "titulo LIKE '%' || ? || '%'", valor.split(" - ")[1].strip)
    if convenio.count == 1 && actividadpf.count == 1 
      self.proyectofinanciero_id = convenio[0].id
      self.actividadpf_id = actividadpf[0].id
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

  def presenta_nombre
    id
  end
end
