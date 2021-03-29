# encoding: UTF-8
require 'sivel2_sjr/concerns/models/desplazamiento'

class Sivel2Sjr::Desplazamiento < ActiveRecord::Base
  include Sivel2Sjr::Concerns::Models::Desplazamiento

  attr_accessor :destino_pais_id
  attr_accessor :destino_departamento_id
  attr_accessor :destino_municipio_id
  attr_accessor :destino_clase_id
  attr_accessor :destino_sitio, :destino_lugar, :destino_tsitio_id
  attr_accessor :destino_latitud, :destino_longitud

  has_and_belongs_to_many :categoria, 
    class_name: 'Sivel2Gen::Categoria',
    foreign_key: :desplazamiento_id, 
    association_foreign_key: 'categoria_id',
    join_table: 'sivel2_sjr_categoria_desplazamiento'

  belongs_to :destino_pais, 
    class_name: 'Sip::Pais', foreign_key: "destino_pais_id", optional: true
  belongs_to :destino_departamento, 
    class_name: 'Sip::Departamento', foreign_key: "destino_departamento_id", 
    optional: true
  belongs_to :destino_municipio, 
    class_name: 'Sip::Municipio', foreign_key: "destino_municipio_id", 
    optional: true
  belongs_to :destino_clase, 
    class_name: 'Sip::Clase', foreign_key: "destino_clase_id", optional: true
  belongs_to :destino_tsitio, 
    class_name: 'Sip::Tsitio', foreign_key: "destino_tsitio_id", optional: true
  validates :tipodesp, presence: true

  def destino_pais_id
    if self.destinoubicacionpre_id
      return Sip::Ubicacionpre.find(self.destinoubicacionpre_id).pais_id
    else
      return ''
    end
  end
  def destino_departamento_id
    if self.destinoubicacionpre_id
      return Sip::Ubicacionpre.find(self.destinoubicacionpre_id).departamento_id
    else
      return ''
    end 
  end
  def destino_municipio_id
    if self.destinoubicacionpre_id
      return Sip::Ubicacionpre.find(self.destinoubicacionpre_id).municipio_id
    else
      return ''
    end 
  end
  def destino_clase_id
    if self.destinoubicacionpre_id
      return Sip::Ubicacionpre.find(self.destinoubicacionpre_id).clase_id
    else
      return ''
    end 
  end

  def destino_lugar
    if self.destinoubicacionpre_id
      return Sip::Ubicacionpre.find(self.destinoubicacionpre_id).lugar
    else
      return ''
    end 
  end

  def destino_sitio
    if self.destinoubicacionpre_id
      return Sip::Ubicacionpre.find(self.destinoubicacionpre_id).sitio
    else
      return ''
    end 
  end

  def destino_latitud
    if self.destinoubicacionpre_id
      return Sip::Ubicacionpre.find(self.destinoubicacionpre_id).latitud
    else
      return ''
    end 
  end

  def destino_longitud
    if self.destinoubicacionpre_id
      return Sip::Ubicacionpre.find(self.destinoubicacionpre_id).longitud
    else
      return ''
    end 
  end

  def destino_tsitio_id
    if self.destinoubicacionpre_id
      return Sip::Ubicacionpre.find(self.destinoubicacionpre_id).tsitio_id
    else
      return ''
    end 
  end
end

