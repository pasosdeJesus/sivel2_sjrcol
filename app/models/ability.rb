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
    'Buscar casos y ver casos con etiqueta de compartidos. ' +
    'Buscar y ver artículos de prensa.' , # ROLINV
 
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
    'Ver documentos en nube. ', # ROLCOOR

    'Realizar conteos de casos. ' +
    'Ver casos de todas las oficinas, crear casos y editar los de su oficina. ' +
    'Ver actividades e informes de actividades de todas las oficinas y editar los de su oficina. ' +
    'Administrar artículos de prensa. ' +
    'Ver documentos en nube. ', # ROLANALI

    'Realizar conteos de casos. ' +
    'Ver casos de todas las oficinas, crear casos y editar sólo sus casos. ' +
    'Ver actividades e informes de actividades de todas las oficinas y editar los de su oficina. ' +
    'Buscar y ver artículos de prensa' +
    'Ver documentos en nube. ', # ROLSIST

    'Realizar conteos de casos. ' +
    'Ver actividades e informes de actividades de todas las oficinas y editar los de su oficina. ' +
    'Administrar artículos de prensa. ' +
    'Ver documentos en nube. '#ROLANALIPRENSA


  ]

  BASICAS_PROPIAS =  [
    ['Sivel2Sjr', 'accionjuridica'],
    ['Sivel2Sjr', 'motivosjr'], 
    ['Sivel2Sjr', 'regimensalud'],
    ['Sip', 'lineaactorsocial'],
    ['Sip', 'tipoanexo'],
    ['Sip', 'tipoactorsocial'],
    ['', 'agresionmigracion'],
    ['', 'autoridadrefugio'],
    ['', 'causaagresion'],
    ['', 'causamigracion'],
    ['', 'dificultadmigracion'],
    ['', 'discapacidad'],
    ['', 'espaciopart'],
    ['', 'indicadorgifmm'],
    ['', 'frecuenciaentrega'],
    ['', 'mecanismodeentrega'],
    ['', 'miembrofamiliar'],
    ['', 'migracontactopre'],
    ['', 'modalidadentrega'],
    ['', 'perfilmigracion'],
    ['', 'sectorgifmm'],
    ['', 'tipoproteccion'],
    ['', 'tipotransferencia'],
    ['', 'trivalentepositiva'],
    ['', 'unidadayuda'],
    ['', 'viadeingreso']
  ]
  
  def tablasbasicas 
    Sip::Ability::BASICAS_PROPIAS + 
      Cor1440Gen::Ability::BASICAS_PROPIAS +
      Sal7711Gen::Ability::BASICAS_PROPIAS + 
      Sivel2Gen::Ability::BASICAS_PROPIAS + 
      Sivel2Sjr::Ability::BASICAS_PROPIAS + 
      BASICAS_PROPIAS - [
        ['Sip', 'grupo'],
        ['Sip', 'perfilactorsocial'],
        ['Sivel2Gen', 'filiacion'],
        ['Sivel2Gen', 'frontera'],
        ['Sivel2Gen', 'iglesia'],
        ['Sivel2Gen', 'intervalo'],
        ['Sivel2Gen', 'organizacion'],
        ['Sivel2Gen', 'pconsolidado'],
        ['Sivel2Gen', 'region'],
        ['Sivel2Gen', 'sectorsocial'],
        ['Sivel2Gen', 'vinculoestado'],
        ['Sivel2Sjr', 'idioma'],
        ['Sivel2Sjr', 'clasifdesps']
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

  if !ActiveRecord::Base.connection.data_source_exists?(
      'sivel2_gen_consexpcaso') && 
     ActiveRecord::Base.connection.data_source_exists?('sivel2_gen_caso')
    Sivel2Gen::Consexpcaso.crea_consexpcaso(nil)
  end

  CAMPOS_PLANTILLAS_PROPIAS = { 
    'Caso' => { 
      campos: [
        :caso_id,
        :fecharecepcion,
        :asesor,
        :oficina,
        :fechadespemb,
        :expulsion,
        :llegada,
        :descripcion,
        :ultimaatencion_mes,
        :ultimaatencion_fecha,
        :contacto,
        :contacto_nombres,
        :contacto_apellidos,
        :contacto_identificacion,
        :contacto_sexo,
        :contacto_etnia,
        :contacto_edad_ultimaatencion,
        :contacto_rangoedad_ultimaatencion,
        :beneficiarios_0_5,
        :beneficiarios_6_12,
        :beneficiarios_13_17,
        :beneficiarios_18_26,
        :beneficiarios_27_59,
        :beneficiarios_60_,
        :beneficiarias_0_5,
        :beneficiarias_6_12,
        :beneficiarias_13_17,
        :beneficiarias_18_26,
        :beneficiarias_27_59,
        :beneficiarias_60_,
        :ultimaatencion_derechosvul,
        :ultimaatencion_as_humanitaria,
        :ultimaatencion_as_juridica,
        :ultimaatencion_descripcion_at,
        :tipificacion,
        :victimas, 
        :ubicaciones, 
        :presponsables, 
        :memo1612
      ],
      controlador: 'Sivel2Sjr::CasosController',
        ruta: '/casos'
    }
#    'Actividad' => { 
#      campos: [
#        'id', 'nombre', 'fecha', 'lugar', 'oficina', 
#        'tipos_de_actividad', 'convenios_financieros', 'areas', 'subareas', 
#        'responsable', 'corresponsables', 'objetivo', 
#        'resultado', 'poblacionmujeres', 'poblacionhombres', 'poblacion',
#        'observaciones', 
#        'creacion', 'actualizacion'
#      ],
#      controlador: 'Cor1440Gen::ActividadesController',
#      ruta: '/actividades'
#    }

  }

  def campos_plantillas
    Heb412Gen::Ability::CAMPOS_PLANTILLAS_PROPIAS.clone.
      merge(Sivel2Sjr::Ability::CAMPOS_PLANTILLAS_PROPIAS.clone).
      merge(Cor1440Gen::Ability::CAMPOS_PLANTILLAS_PROPIAS.clone).
      merge(CAMPOS_PLANTILLAS_PROPIAS.clone)
  end

  def initialize(usuario = nil)
    can :read, [Sip::Pais, Sip::Departamento, Sip::Municipio, Sip::Clase]
    if !usuario || usuario.fechadeshabilitacion
      return
    end
    can :read, Sal7711Gen::Categoriaprensa      

    can :descarga_anexo, Sip::Anexo
    can :contar, Sip::Ubicacion
    can :nuevo, Sip::Ubicacion

    can :contar, Sivel2Gen::Caso
    can :buscar, Sivel2Gen::Caso
    can :lista, Sivel2Gen::Caso
    can :nuevo, Sivel2Gen::Presponsable
    can :nuevo, Sivel2Gen::Victima

    can :nuevo, Sivel2Sjr::Desplazamiento
    can :nuevo, Sivel2Sjr::Migracion
    can :nuevo, Sivel2Sjr::Respuesta

    if !usuario.nil? && !usuario.rol.nil? then
      can :read, Sal7711Gen::Articulo
      
      can :read, Sip::Persona
      
      can :read, Heb412Gen::Plantilladoc
      can :read, Heb412Gen::Plantillahcm
      can :read, Heb412Gen::Plantillahcr

      case usuario.rol 
      when Ability::ROLINV
        #cannot :buscar, Sivel2Gen::Caso
        can [:read, :index], Sivel2Gen::Caso, 
          etiqueta: { id: usuario.etiqueta.map(&:id) }

      when Ability::ROLANALIPRENSA
        can :manage, Cor1440Gen::Actividad, oficina_id: [1, usuario.oficina_id]
        can [:read, :new], Cor1440Gen::Actividad
        can :read, Cor1440Gen::Informe
        can :read, Cor1440Gen::Proyectofinanciero
        
        can :read, Heb412Gen::Doc
        can :create, Heb412Gen::Doc

        can :manage, Sal7711Gen::Articulo

      when Ability::ROLSIST

        can [:new, :read], Cor1440Gen::Actividad
        can :manage, Cor1440Gen::Actividad, oficina_id: [1, usuario.oficina_id]
        can :read, Cor1440Gen::Proyectofinanciero

        can :read, Heb412Gen::Doc
        can :create, Heb412Gen::Doc

        can :manage, Sip::Persona

        can :manage, Sivel2Gen::Acto
        can :read, Sivel2Gen::Caso, casosjr: { oficina_id: usuario.oficina_id }
        can [:update, :create, :destroy], Sivel2Gen::Caso, 
          casosjr: { asesor: usuario.id, oficina_id:usuario.oficina_id }
        can :new, Sivel2Gen::Caso 
        
        can :read, Sivel2Sjr::Consactividadcaso

      when Ability::ROLANALI

        can :manage, Cor1440Gen::Actividad, oficina_id: [1, usuario.oficina_id]
        can [:read, :new], Cor1440Gen::Actividad
        can :read, Cor1440Gen::Informe
        can :index, Cor1440Gen::Mindicadorpf
        can :read, Cor1440Gen::Proyectofinanciero

        can :read, Heb412Gen::Doc
        can :create, Heb412Gen::Doc

        can :manage, Sal7711Gen::Articulo

        can :manage, Sip::Persona

        can :manage, Sivel2Gen::Acto
        can :read, Sivel2Gen::Caso
        can :new, Sivel2Gen::Caso
        can [:update, :create, :destroy, :edit], Sivel2Gen::Caso, 
          casosjr: { oficina_id: usuario.oficina_id }

        can :read, Sivel2Sjr::Consactividadcaso
      when Ability::ROLCOOR
        can :manage, Cor1440Gen::Informe
        can [:read, :new], Cor1440Gen::Actividad
        can :manage, Cor1440Gen::Actividad, oficina_id: [1, usuario.oficina_id]
        can :read, Cor1440Gen::Proyectofinanciero

        can :read, Heb412Gen::Doc
        can :create, Heb412Gen::Doc

        can [:new, :create, :read, :index, :edit, :update], Sip::Actorsocial
        can :manage, Sip::Persona

        can :manage, Sivel2Gen::Acto
        can :read, Sivel2Gen::Caso
        can :new, Sivel2Gen::Caso
        can [:update, :create, :destroy, :poneretcomp], Sivel2Gen::Caso, 
          casosjr: { oficina_id: usuario.oficina_id }

        can :read, Sivel2Sjr::Consactividadcaso

      when Ability::ROLADMIN, Ability::ROLDIR
        can :manage, Cor1440Gen::Actividad
        can :manage, Cor1440Gen::Informe
        can :manage, Cor1440Gen::Mindicadorpf
        can :manage, Cor1440Gen::Proyectofinanciero
        can :manage, Cor1440Gen::Sectoractor

        can :manage, Heb412Gen::Doc
        can :manage, Heb412Gen::Plantilladoc
        can :manage, Heb412Gen::Plantillahcm
        can :manage, Heb412Gen::Plantillahcr

        can :manage, Mr519Gen::Formulario

        can :manage, Sal7711Gen::Articulo

        can :manage, Sip::Actorsocial
        can :manage, Sip::Sectoractor
        can :manage, Sip::Persona

        can :manage, Sivel2Gen::Caso
        can :manage, Sivel2Gen::Acto

        can :read, Sivel2Sjr::Consactividadcaso

        can :manage, Usuario
        can :manage, :tablasbasicas
        tablasbasicas.each do |t|
          c = Ability.tb_clase(t)
          can :manage, c
        end
      end
      cannot :solocambiaretiquetas, Sivel2Gen::Caso
    end

  end


end
