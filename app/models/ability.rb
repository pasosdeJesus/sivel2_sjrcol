# encoding: UTF-8

class Ability < Sivel2Sjr::Ability

  ROLADMIN  = 1
  ROLINV    = 2
  ROLDIR    = 3
  ROLCOOR   = 4
  ROLANALI  = 5
  ROLSIST   = 6
  ROLANALIPRENSA  = 7

  ROLES = [
    ["Administrador", ROLADMIN], 
    ["Invitado Nacional", ROLINV], 
    ["Director Nacional", ROLDIR], 
    ["Coordinador oficina", ROLCOOR], 
    ["Analista", ROLANALI], 
    ["Sistematizador", ROLSIST],
    ["Analista de Prensa", ROLANALIPRENSA]
  ]

  BASICAS_PROPIAS =  [
    ['Sivel2Sjr', 'acreditacion'], 
    ['Sivel2Sjr', 'ayudaestado'], 
    ['Sivel2Sjr', 'clasifdesp'], 
    ['Sivel2Sjr', 'declaroante'], 
    ['Sivel2Sjr', 'derecho'], 
    ['Sivel2Sjr', 'inclusion'], 
    ['Sivel2Sjr', 'modalidadtierra'], 
    ['Sivel2Sjr', 'motivosjr'], 
    ['Sivel2Sjr', 'personadesea'], 
    ['Sivel2Sjr', 'progestado'], 
    ['Sivel2Sjr', 'regimensalud'],
    ['Sivel2Sjr', 'tipodesp']
  ]
  
  def tablasbasicas 
    Sip::Ability::BASICAS_PROPIAS + 
      Cor1440Gen::Ability::BASICAS_PROPIAS +
      Sal7711Gen::Ability::BASICAS_PROPIAS + 
      Sivel2Gen::Ability::BASICAS_PROPIAS + 
      Sivel2Sjr::Ability::BASICAS_PROPIAS + 
      BASICAS_PROPIAS - [
        ['Sivel2Gen', 'filiacion'],
        ['Sivel2Gen', 'frontera'],
        ['Sivel2Gen', 'iglesia'],
        ['Sivel2Gen', 'intervalo'],
        ['Sivel2Gen', 'organizacion'],
        ['Sivel2Gen', 'pconsolidado'],
        ['Sivel2Gen', 'region'],
        ['Sivel2Gen', 'sectorsocial'],
        ['Sivel2Gen', 'vinculoestado'],
        ['Sivel2Sjr', 'idioma']
      ]
  end

  def basicas_id_noauto 
    Sip::Ability::BASICAS_ID_NOAUTO +
      Sivel2Gen::Ability::BASICAS_ID_NOAUTO 
  end

  def nobasicas_indice_seq_con_id 
    Sip::Ability::NOBASICAS_INDSEQID +
      Sivel2Gen::Ability::NOBASICAS_INDSEQID 
  end

  def tablasbasicas_prio 
    Sip::Ability::BASICAS_PRIO +
      Sivel2Gen::Ability::BASICAS_PRIO +
      Sivel2Sjr::Ability::BASICAS_PRIO
  end

  def acciones_plantillas 
    {'Listado de casos' => 
     { 
       campos: [
         'ultimaatencion_mes', 'ultimaatencion_fecha', 
         'contacto_nombres', 'contacto_apellidos', 'contacto_identificacion', 
         'contacto_sexo', 'contacto_edad', 'contacto_etnia',
         'beneficiarios_0_5', 'beneficiarios_6_12',
         'beneficiarios_13_17', 'beneficiarios_18_26',
         'beneficiarios_27_59', 'beneficiarios_60_',
         'beneficiarias_0_5', 'beneficiarias_6_12',
         'beneficiarias_13_17', 'beneficiarias_18_26',
         'beneficiarias_27_59', 'beneficiarias_60_',
         'ultimaatencion_derechosvul', 'ultimaatencion_as_humanitaria',
         'ultimaatencion_as_juridica', 'ultimaatencion_otros_ser_as', 
         'ultimaatencion_descripcion_at',
         'oficina' ],
         controlador: 'Sivel2Sjr::CasosController#index',
         unregistro: false # Son muchos registros debe iterarse
     }
    }
  end

  def initialize(usuario = nil)

    can :read, [Sip::Pais, Sip::Departamento, Sip::Municipio, Sip::Clase]
    if !usuario || usuario.fechadeshabilitacion
      return
    end
    can :contar, Sivel2Gen::Caso
    can :contar, Sip::Ubicacion
    can :buscar, Sivel2Gen::Caso
    can :lista, Sivel2Gen::Caso
    can :descarga_anexo, Sip::Anexo
    can :nuevo, Sivel2Sjr::Desplazamiento
    can :nuevo, Sivel2Sjr::Respuesta
    can :nuevo, Sip::Ubicacion
    can :nuevo, Sivel2Gen::Presponsable
    can :nuevo, Sivel2Gen::Victima
    can :read, Sal7711Gen::Categoriaprensa      
    if !usuario.nil? && !usuario.rol.nil? then
      can :read, Sal7711Gen::Articulo
      case usuario.rol 
      when Ability::ROLINV
        cannot :buscar, Sivel2Gen::Caso
        can :read, Sivel2Gen::Caso 
      when Ability::ROLANALIPRENSA
        can :manage, Sal7711Gen::Articulo
      when Ability::ROLSIST
        can :read, Sivel2Gen::Caso, casosjr: { oficina_id: usuario.oficina_id }
        can [:update, :create, :destroy], Sivel2Gen::Caso, 
          casosjr: { asesor: usuario.id, oficina_id:usuario.oficina_id }
        can [:read, :new], Cor1440Gen::Actividad
        can :new, Sivel2Gen::Caso 
        can [:update, :create, :destroy], Cor1440Gen::Actividad, 
          oficina: { id: usuario.oficina_id}
        can :manage, Sivel2Gen::Acto
        can :manage, Sip::Persona
      when Ability::ROLANALI
        can :read, Sivel2Gen::Caso
        can :manage, Sal7711Gen::Articulo
        can :new, Sivel2Gen::Caso
        can [:update, :create, :destroy], Sivel2Gen::Caso, 
          casosjr: { oficina_id: usuario.oficina_id }
        can :read, Cor1440Gen::Informe
        can :read, Cor1440Gen::Actividad
        can :new, Cor1440Gen::Actividad
        can [:update, :create, :destroy], Cor1440Gen::Actividad, 
          oficina: { id: usuario.oficina_id}
        can :manage, Sivel2Gen::Acto
        can :manage, Sip::Persona
      when Ability::ROLCOOR
        can :read, Sivel2Gen::Caso
        can :new, Sivel2Gen::Caso
        can [:update, :create, :destroy, :poneretcomp], Sivel2Gen::Caso, 
          casosjr: { oficina_id: usuario.oficina_id }
        can :manage, Cor1440Gen::Informe
        can :read, Cor1440Gen::Actividad
        can :new, Cor1440Gen::Actividad
        can [:update, :create, :destroy], Cor1440Gen::Actividad, 
          oficina: { id: usuario.oficina_id}
        can :manage, Sivel2Gen::Acto
        can :manage, Sip::Persona
        can :new, Usuario
        can [:read, :manage], Usuario, oficina: { id: usuario.oficina_id}
      when Ability::ROLADMIN, Ability::ROLDIR
        can :manage, Sivel2Gen::Caso
        can :manage, Sal7711Gen::Articulo
        can :manage, Cor1440Gen::Actividad
        can :manage, Cor1440Gen::Informe
        can :manage, Sivel2Gen::Acto
        can :manage, Sip::Persona
        can :manage, Usuario
        can :manage, Heb412Gen::Doc
        can :manage, :tablasbasicas
        byebug
        tablasbasicas.each do |t|
          c = Ability.tb_clase(t)
          can :manage, c
        end
      end
    end
  end

end
