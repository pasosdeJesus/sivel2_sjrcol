# encoding: UTF-8
class Ability
  include CanCan::Ability

  ROLADMIN  = 1
  ROLINV    = 2
  ROLDIR    = 3
  ROLCOOR   = 4
  ROLANALI  = 5
  ROLSIST   = 6

  ROLES = [
    ["Administrador", ROLADMIN], 
    ["Invitado Nacional", ROLINV], 
    ["Director Nacional", ROLDIR], 
    ["Coordinador oficina", ROLCOOR], 
    ["Analista", ROLANALI], 
    ["Sistematizador", ROLSIST]
  ]

  @@tablasbasicas = [
    'actividadarea', 'actividadoficio', 'aslegal', 'ayudaestado',
    'ayudasjr', 
    'categoria', 'clase', 'comosupo',
    'departamento', 'derecho',
    'escolaridad', 'estadocivil', 'etiqueta', 'etnia', 
    'iglesia', 
    'maternidad', 'motivosjr', 'municipio', 
    'pais', 'presponsable', 'profesion', 'progestado',
    'supracategoria',
    'rangoedad', 'rangoedadac', 'regionsjr', 'rolfamilia', 
    'tclase', 'tdocumento', 'tsitio', 'tviolencia'
  ]

  def self.tablasbasicas
    @@tablasbasicas
  end

  # Tablas basicas cuya secuencia es de la forma tabla_id_seq 
  @@basicas_seq_con_id = [ "actividadarea", "comosupo", "pais", "rangoedadac", "tdocumento" ]

  def self.basicas_seq_con_id
    @@basicas_seq_con_id
  end

  # Tablas básicas cuyo id no es autoincremental
  @@basicas_id_noauto = [ 
    "categoria", "clase", "departamento", "municipio", 
    "supracategoria", "tclase", "tviolencia" 
  ]

  def self.basicas_id_noauto
    @@basicas_id_noauto
  end
  
  # Tablas no básicas pero que tienen índice
  @@nobasicas_indice = ['caso', 'persona', 'ubicacion', 'usuario']

  def self.nobasicas_indice
    @@nobasicas_indice
  end

  # Tablas básicas que deben volcarse primero --por ser requeridas por otras básicas
  @@tablasbasicas_prio = [
    "pconsolidado", "tviolencia", "supracategoria",
    "tclase", "pais", "departamento", "municipio", "clase",
    "intervalo", "filiacion", "organizacion", "sectorsocial",
    "vinculoestado", "regimensalud", 
    "acreditacion", "clasifdesp", "declaroante", "inclusion", "modalidadtierra",
    "tipodesp", "personadesea", "ayudaestado", "derecho", "progestado",
    "motivosjr"
  ];

  def self.tablasbasicas_prio
    @@tablasbasicas_prio
  end

  # Ver documentacion de este metodo en app/models/ability de sivel2_gen
  def initialize(usuario)
    can :contar, Caso
    can :buscar, Caso
    can :lista, Caso
    can :descarga_anexo, Anexo
    can :descarga_anexoactividad, Anexoactividad
    can :nuevo, Desplazamiento
    can :nuevo, Respuesta
    can :nuevo, Ubicacion
    can :nuevo, Presponsable
    can :nuevo, Victima
    if !usuario.nil? && !usuario.rol.nil? then
      case usuario.rol 
      when Ability::ROLSIST
        can :read, Caso, casosjr: { id_regionsjr: usuario.regionsjr_id }
        can [:update, :create, :destroy], Caso, 
          casosjr: { asesor: usuario.id, id_regionsjr:usuario.regionsjr_id }
        can :read, Actividad
        can :new, Actividad
        can :new, Caso 
        can [:update, :create, :destroy], Actividad, 
          oficina: { id: usuario.regionsjr_id}
      when Ability::ROLANALI
        can :read, Caso
        can :new, Caso
        can [:update, :create, :destroy], Caso, 
          casosjr: { id_regionsjr: usuario.regionsjr_id }
        can :read, Actividad
        can :new, Actividad
        can [:update, :create, :destroy], Actividad, 
          oficina: { id: usuario.regionsjr_id}
      when Ability::ROLCOOR
        can :read, Caso
        can :new, Caso
        can [:update, :create, :destroy, :poneretcomp], Caso, 
          casosjr: { id_regionsjr: usuario.regionsjr_id }
        can :read, Actividad
        can :new, Actividad
        can [:update, :create, :destroy], Actividad, 
          oficina: { id: usuario.regionsjr_id}
        can :new, Usuario
        can [:read, :manage], Usuario, regionsjr: { id: usuario.regionsjr_id}
      when Ability::ROLDIR
        can [:read, :new, :update, :create, :destroy, :ponetetcomp], Caso
        can [:read, :new, :update, :create, :destroy], Actividad
        can :manage, Usuario
        can :manage, :tablasbasicas
        @@tablasbasicas.each do |t|
          c = t.capitalize.constantize
          can :manage, c
        end
      when Ability::ROLINV
        cannot :buscar, Caso
        can :read, Caso 
      when Ability::ROLADMIN
        can :manage, Caso
        can :manage, Actividad
        can :manage, Usuario
        can :manage, :tablasbasicas
        @@tablasbasicas.each do |t|
          c = t.capitalize.constantize
          can :manage, c
        end
      end
    end
  end
end
