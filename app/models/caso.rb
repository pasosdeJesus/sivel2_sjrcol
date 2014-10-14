# encoding: UTF-8
class Caso < ActiveRecord::Base

  @current_usuario = nil
  attr_accessor :current_usuario

	# Ordenados por foreign_key para facilitar comparar con esquema en base
	has_many :acto, foreign_key: "id_caso", validate: true, dependent: :destroy
	accepts_nested_attributes_for :acto, allow_destroy: true, 
    reject_if: :all_blank
	has_many :actosjr, :through => :acto, dependent: :destroy
	accepts_nested_attributes_for :actosjr, allow_destroy: true, 
    reject_if: :all_blank
	has_many :actocolectivo, foreign_key: "id_caso", validate: true, 
    dependent: :destroy
	has_many :anexo, foreign_key: "id_caso", validate: true, 
    dependent: :destroy
	accepts_nested_attributes_for :anexo, allow_destroy: true, 
    reject_if: :all_blank
	has_many :antecedente_caso, foreign_key: "id_caso", validate: true, 
    dependent: :destroy
	has_many :antecedente_comunidad, foreign_key: "id_caso", validate: true, 
    dependent: :destroy
	has_many :antecedente_victima, foreign_key: "id_caso", validate: true, 
    dependent: :destroy
	has_many :caso_categoria_presponsable, foreign_key: "id_caso", 
    validate: true, dependent: :destroy
	has_many :caso_contexto, foreign_key: "id_caso", validate: true, 
    dependent: :destroy
	has_many :caso_etiqueta, foreign_key: "id_caso", validate: true, 
    dependent: :destroy
	accepts_nested_attributes_for :caso_etiqueta, allow_destroy: true, 
    reject_if: :all_blank
	has_many :caso_ffrecuente, foreign_key: "id_caso", validate: true, 
    dependent: :destroy
	has_many :caso_fotra, foreign_key: "id_caso", validate: true, 
    dependent: :destroy
	has_many :caso_frontera, foreign_key: "id_caso", validate: true, 
    dependent: :destroy
	has_many :caso_presponsable, foreign_key: "id_caso", validate: true, 
    dependent: :destroy
	has_many :presponsable, through: :caso_presponsable
	accepts_nested_attributes_for :caso_presponsable, allow_destroy: true, 
    reject_if: :all_blank
	has_many :caso_region, foreign_key: "id_caso", validate: true, 
    dependent: :destroy
	has_many :caso_usuario, foreign_key: "id_caso", validate: true, 
    dependent: :destroy

	has_one :casosjr, foreign_key: "id_caso", inverse_of: :caso, validate: true, 
    dependent: :destroy
	# respuseta deberìa ser con :through => :casosjr pero más dificil guardar
	has_many :respuesta, foreign_key: "id_caso", validate:true, 
    dependent: :destroy
	accepts_nested_attributes_for :respuesta, allow_destroy: true, 
    reject_if: :all_blank
	accepts_nested_attributes_for :casosjr, allow_destroy: true, 
    update_only: true

	has_many :comunidad_filiacion, foreign_key: "id_caso", validate: true, 
    dependent: :destroy
	has_many :comunidad_organizacion, foreign_key: "id_caso", validate: true, 
    dependent: :destroy
	has_many :comunidad_profesion, foreign_key: "id_caso", validate: true, 
    dependent: :destroy
	has_many :comunidad_rangoedad, foreign_key: "id_caso", validate: true, 
    dependent: :destroy
	has_many :comunidad_sectorsocial, foreign_key: "id_caso", validate: true, 
    dependent: :destroy
	has_many :comunidad_vinculoestado, foreign_key: "id_caso", validate: true, 
    dependent: :destroy
	has_many :ubicacion, foreign_key: "id_caso", validate: true, 
    dependent: :destroy
	accepts_nested_attributes_for :ubicacion, allow_destroy: true, 
    reject_if: :all_blank
	has_many :desplazamiento, foreign_key: "id_caso", validate: true, 
    dependent: :destroy
	accepts_nested_attributes_for :desplazamiento , allow_destroy: true, 
    reject_if: :all_blank
	has_many :victima,  foreign_key: "id_caso", dependent: :destroy
	has_many :victimasjr, :through => :victima, dependent: :destroy
	has_many :persona, :through => :victima
	accepts_nested_attributes_for :persona,  reject_if: :all_blank
	accepts_nested_attributes_for :victimasjr, allow_destroy: true, 
    reject_if: :all_blank
	accepts_nested_attributes_for :victima, allow_destroy: true, 
    reject_if: :all_blank
	has_many :victimacolectiva, foreign_key: "id_caso", validate: true, 
    dependent: :destroy

  has_one :conscaso, foreign_key: "caso_id"

	belongs_to :intervalo, foreign_key: "id_intervalo", validate: true

	validates_presence_of :fecha

  validate :rol_usuario
  def rol_usuario
    # current_usuario será nil cuando venga de validaciones por ejemplo
    # validate_presence_of :caso
    # que se hace desde acto
    if (current_usuario &&
        current_usuario.rol != Ability::ROLADMIN &&
        current_usuario.rol != Ability::ROLDIR &&
        current_usuario.rol != Ability::ROLSIST &&
        current_usuario.rol != Ability::ROLCOOR &&
        current_usuario.rol != Ability::ROLANALI) 
      errors.add(:id, "Rol de usuario no apropiado para editar")
    end
    if (current_usuario &&
        current_usuario.rol == Ability::ROLSIST && 
        (casosjr.asesor != current_usuario.id))
      errors.add(:id, "Sistematizador solo puede editar sus casos")
    end
  end


  def self.refresca_conscaso
    if !ActiveRecord::Base.connection.table_exists? 'conscaso'
      ActiveRecord::Base.connection.execute(
        "CREATE OR REPLACE VIEW conscaso1 
        AS SELECT casosjr.id_caso as caso_id, 
        ARRAY_TO_STRING(ARRAY(SELECT nombres || ' ' || apellidos FROM persona
          WHERE persona.id=casosjr.contacto), ', ')
          AS contacto_nombre, 
        casosjr.fecharec,
        regionsjr.nombre AS regionsjr_nombre,
        usuario.nusuario,
        caso.fecha AS caso_fecha,
        ARRAY_TO_STRING(ARRAY(SELECT departamento.nombre || '/' || 
        municipio.nombre
        FROM departamento, municipio, ubicacion, desplazamiento
        WHERE desplazamiento.fechaexpulsion=caso.fecha
        AND desplazamiento.id_caso=caso.id
        AND desplazamiento.id_expulsion=ubicacion.id
        AND ubicacion.id_departamento=departamento.id
        AND ubicacion.id_departamento=municipio.id
        AND ubicacion.id_municipio=municipio.id ), ', ') AS expulsion,
        ARRAY_TO_STRING(ARRAY(SELECT departamento.nombre || '/' || 
        municipio.nombre
        FROM departamento, municipio, ubicacion, desplazamiento
        WHERE desplazamiento.fechaexpulsion=caso.fecha
        AND desplazamiento.id_caso=caso.id
        AND desplazamiento.id_llegada=ubicacion.id
        AND ubicacion.id_departamento=departamento.id
        AND ubicacion.id_departamento=municipio.id
        AND ubicacion.id_municipio=municipio.id ), ', ') AS llegada,
        ARRAY_TO_STRING(ARRAY(SELECT fechaatencion FROM respuesta
          WHERE respuesta.id_caso=casosjr.id_caso 
          ORDER BY fechaatencion DESC LIMIT 1), ', ')
          AS respuesta_ultimafechaatencion,
        caso.memo AS caso_memo
        FROM casosjr, caso, regionsjr,usuario
        WHERE casosjr.id_caso = caso.id
          AND regionsjr.id=casosjr.id_regionsjr
          AND usuario.id = casosjr.asesor
      ")
      ActiveRecord::Base.connection.execute(
        "CREATE MATERIALIZED VIEW conscaso 
        AS SELECT caso_id, contacto_nombre, fecharec, regionsjr_nombre, 
          nusuario, caso_fecha, expulsion, llegada,
          respuesta_ultimafechaatencion, caso_memo,
          to_tsvector('spanish', unaccent(caso_id || ' ' || contacto_nombre || 
            ' ' || replace(cast(fecharec AS varchar), '-', ' ') || 
            ' ' || regionsjr_nombre || ' ' || nusuario || ' ' || 
            replace(cast(caso_fecha AS varchar), '-', ' ') || ' ' ||
            expulsion  || ' ' || llegada || ' ' || 
            replace(cast(respuesta_ultimafechaatencion AS varchar), '-', ' ')
            || ' ' || caso_memo )) as q
        FROM conscaso1"
      );
      ActiveRecord::Base.connection.execute(
        "CREATE INDEX busca_conscaso ON conscaso USING gin(q);"
      )
    else
      ActiveRecord::Base.connection.execute(
        "REFRESH MATERIALIZED VIEW conscaso"
      )
    end
  end

end
