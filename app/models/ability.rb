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

  ROLES_CA = [
    'Realizar conteos de casos. ' +
    'Admministrar casos de todas las oficinas. ' +
    'Administrar actividades de todas las oficinas. ' +
    'Administrar artículos de prensa. ' +
    'Administrar usuarios. ' + 
    'Administrar documentos en nube. ' +
    'Administrar tablas básicas. ', #ROLADMIN

    'Realizar conteos de casos. ' +
    'Buscar casos y ver casos con etiqueta de compartidos. ', #ROLINV
 
    'Realizar conteos de casos. ' +
    'Admministrar casos de todas las oficinas. ' +
    'Administrar actividades de todas las oficinas. ' +
    'Administrar artículos de prensa. ' +
    'Administrar usuarios. ' + 
    'Administrar documentos en nube. ' +
    'Administrar tablas básicas. ', #ROLDIR
 
    'Realizar conteos de casos. ' +
    'Ver casos de todas las oficinas, crear casos, editar los de su oficina y poner etiquetas de compartir. ' +
    'Ver actividades e informes de actividades de todas las oficinas y editar los de su oficina. ' +
    'Administrar artículos de prensa. ' +
    'Administrar usuarios de su oficina. ', # ROLCOOR

    'Realizar conteos de casos. ' +
    'Ver casos de todas las oficinas, crear casos y editar los de su oficina. ' +
    'Ver actividades e informes de actividades de todas las oficinas y editar los de su oficina. ' +
    'Administrar artículos de prensa. ', # ROLANALI

    'Realizar conteos de casos. ' +
    'Ver casos de todas las oficinas, crear casos y editar sólo sus casos. ' +
    'Ver actividades e informes de actividades de todas las oficinas y editar los de su oficina. ', # ROLSIST

    'Realizar conteos de casos. ' +
    'Ver actividades e informes de actividades de todas las oficinas y editar los de su oficina. ' +
    'Administrar artículos de prensa. ' #ROLANALIPRENSA


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
        ['Sip', 'grupo'],
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

  if ActiveRecord::Base.connection.data_source_exists?('sivel2_gen_caso')
    Sivel2Gen::Consexpcaso.crea_consexpcaso(nil)
  end

  CAMPOS_PLANTILLAS_PROPIAS = { 
    'Caso' => { 
      campos: ActiveRecord::Base.connection.data_source_exists?(
        'sivel2_gen_consexpcaso') ?
        Sivel2Gen::Consexpcaso.column_names : [],
        controlador: 'Sivel2Sjr::CasosController'
    },
    'Actividad' => { 
      campos: [
        'id', 'nombre', 'fecha', 'lugar', 'oficina', 
        'tipos_de_actividad', 'convenios_financieros', 'areas', 'subareas', 
        'responsable', 'corresponsables', 'objetivo', 
        'resultado', 'poblacionmujeres', 'poblacionhombres', 'poblacion',
        'observaciones', 
        'creacion', 'actualizacion'
      ],
      controlador: 'Cor1440Gen::ActividadesController'
    }

  }

  def campos_plantillas
      Heb412Gen::Ability::CAMPOS_PLANTILLAS_PROPIAS.clone.
        merge(Cor1440Gen::Ability::CAMPOS_PLANTILLAS_PROPIAS.clone).
        merge(CAMPOS_PLANTILLAS_PROPIAS)
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
        can :read, Cor1440Gen::Informe
        can :read, Cor1440Gen::Actividad
        can :read, Cor1440Gen::Proyectofinanciero
        can :new, Cor1440Gen::Actividad
        can [:update, :create, :destroy], Cor1440Gen::Actividad, 
          oficina: { id: usuario.oficina_id}
        can :manage, Sal7711Gen::Articulo
        can :read, Heb412Gen::Doc
        can :read, Heb412Gen::Plantillahcm

      when Ability::ROLSIST
        can :read, Sivel2Gen::Caso, casosjr: { oficina_id: usuario.oficina_id }
        can [:update, :create, :destroy], Sivel2Gen::Caso, 
          casosjr: { asesor: usuario.id, oficina_id:usuario.oficina_id }
        can :new, Sivel2Gen::Caso 
        can :manage, Sivel2Gen::Acto
        can :manage, Sip::Persona
        can [:read, :new], Cor1440Gen::Actividad
        can :read, Cor1440Gen::Proyectofinanciero
        can [:update, :create, :destroy], Cor1440Gen::Actividad, 
          oficina: { id: usuario.oficina_id}
        can :read, Heb412Gen::Doc
        can :read, Heb412Gen::Plantillahcm

      when Ability::ROLANALI
        can :read, Sivel2Gen::Caso
        can :new, Sivel2Gen::Caso
        can :manage, Sivel2Gen::Acto
        can :manage, Sip::Persona
        can [:update, :create, :destroy], Sivel2Gen::Caso, 
          casosjr: { oficina_id: usuario.oficina_id }
        can :read, Cor1440Gen::Informe
        can :read, Cor1440Gen::Actividad
        can :read, Cor1440Gen::Proyectofinanciero
        can :new, Cor1440Gen::Actividad
        can [:update, :create, :destroy], Cor1440Gen::Actividad, 
          oficina: { id: usuario.oficina_id}
        can :read, Heb412Gen::Doc
        can :read, Heb412Gen::Plantillahcm
        can :manage, Sal7711Gen::Articulo

      when Ability::ROLCOOR
        can :read, Sivel2Gen::Caso
        can :new, Sivel2Gen::Caso
        can :manage, Sivel2Gen::Acto
        can :manage, Sip::Persona
        can [:update, :create, :destroy, :poneretcomp], Sivel2Gen::Caso, 
          casosjr: { oficina_id: usuario.oficina_id }
        can :manage, Cor1440Gen::Informe
        can :read, Cor1440Gen::Actividad
        can :read, Cor1440Gen::Proyectofinanciero
        can :new, Cor1440Gen::Actividad
        can [:update, :create, :destroy], Cor1440Gen::Actividad, 
          oficina: { id: usuario.oficina_id}
        can :read, Heb412Gen::Doc
        can :read, Heb412Gen::Plantillahcm
        can :new, Usuario
        can [:read, :manage], Usuario, oficina: { id: usuario.oficina_id}

      when Ability::ROLADMIN, Ability::ROLDIR
        can :manage, Sivel2Gen::Caso
        can :manage, Sivel2Gen::Acto
        can :manage, Sip::Persona
        can :manage, Cor1440Gen::Actividad
        can :manage, Cor1440Gen::Proyectofinanciero
        can :manage, Cor1440Gen::Informe
        can :manage, Sal7711Gen::Articulo
        can :manage, Usuario
        can :manage, Heb412Gen::Doc
        can :manage, Heb412Gen::Plantillahcm
        can :manage, :tablasbasicas
        tablasbasicas.each do |t|
          c = Ability.tb_clase(t)
          can :manage, c
        end
      end
    end
  end


end
