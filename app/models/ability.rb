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
    ['', 'depgifmm'],
    ['', 'dificultadmigracion'],
    ['', 'discapacidad'],
    ['', 'espaciopart'],
    ['', 'indicadorgifmm'],
    ['', 'frecuenciaentrega'],
    ['', 'mecanismodeentrega'],
    ['', 'miembrofamiliar'],
    ['', 'migracontactopre'],
    ['', 'modalidadentrega'],
    ['', 'mungifmm'],
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

  # CAMPOS PARA EXPORTAR DESDE CASOS

  PREFIJOS_PERSONAS_CAMPOS = ['contacto', 'familiar1', 'familiar2', 
                              'familiar3', 'familiar4', 'familiar5']

  CAMPOS_PERSONAVIC = [
    'nombres',
    'actividadoficio',
    'actualtrabajando',
    'apellidos',
    'asisteescuela',
    'anionac',
    'cabezafamilia',
    'dianac',
    'discapacidad',
    'estadocivil',
    'escolaridad',
    'filiacion',
    'identificacion',
    'pais',
    'departamento',
    'municipio',
    'clase',
    'mesnac',
    'maternidad',
    'numeroanexos',
    'numeroanexosconsen',
    'numerodocumento',
    'organizacion',
    'profesion',
    'regimensalud',
    'sexo',
    'etnia',
    'orientacionsexual',
    'rolfamilia',
    'tdocumento',
    'tienesisben',
    'vinculoestado'
  ]

  PREFIJOS_UBICACIONES_CAMPOS = ['ubicacion1', 'ubicacion2', 'ubicacion3'] 

  CAMPOS_UBICACIONES = [
    'pais', 
    'departamento',
    'municipio',
    'clase',
    'longitud',
    'latitud',
    'lugar',
    'sitio',
    'tsitio'
  ]

  CAMPOS_MIGRA_SIMPLES = [
    'fechasalida',
    'fechallegada',
    'ubifamilia',
    'valor_pago',
    'concepto_pago',
    'actor_pago',
    'perpetradoresagresion',
    'perpeagresenpais',
    'observacionesref',
    'fechaNpi',
    'salvoNpi',
    'tiempoenpais'
  ]
  CAMPOS_MIGRA_RELA = [
    'salida_pais',
    'salida_departamento',
    'salida_municipio',
    'salida_clase',
    'llegada_pais',
    'llegada_departamento',
    'llegada_municipio',
    'llegada_clase',
    'viadeingreso',
    'causamigracion',
    'pagoingreso',
    'perfilmigracion',
    'migracontactopre',
    'estatus_migratorio',
    'proteccion',
    'autoridadrefugio',
    'causaRefugio',
    'miembrofamiliar',
    'tipoproteccion'
  ]
  CAMPOS_MIGRA_MULTI = [
    'dificultadmigracion',
    'agresionmigracion',
    'causaagresion',
    'agresionenpais',
    'causaagrpais'
  ]
  CAMPOS_DESPLAZA_SIMPLES = [
    'fechaexpulsion',
    'fechallegada',
    'descripcion',
    'otrosdatos',
    'declaro',
    'hechosdeclarados',
    'fechadeclaracion',
    'oficioantes',
    'materialesperdidos',
    'inmaterialesperdidos',
    'documentostierra'
  ]
  CAMPOS_DESPLAZA_RELA = [
    'clasifdesp',
    'tipodesp',
    'declaroante',
    'inclusion',
    'acreditacion',
    'modalidadtierra'
  ]
  CAMPOS_DESPLAZA_MULTI = [
    'categoria'
  ]
  CAMPOS_DESPLAZA_ESPECIALES = [
    'expulsion',
    'llegada',
    'modalidadgeo',
    'submodalidadgeo'
  ]
  CAMPOS_DESPLAZA_BOOL = [
    'retornado',
    'reubicado',
    'connacionalretorno',
    'acompestado',
    'connacionaldeportado',
    'protegiorupta'
  ]

  PREFIJOS_PRESPONSABLES_CAMPOS = ['presponsable1', 'presponsable2', 
                                   'presponsable3'] 
  CAMPOS_CASOPRESPONSABLES = [
    'presponsable',
    'tipo',
    'bloque',
    'frente',
    'brigada',
    'batallon',
    'division',
    'otro'
  ]

  PREFIJOS_ACTOS_CAMPOS = ['acto1', 'acto2', 'acto3', 'acto4', 'acto5']

  CAMPOS_ACTOS = [
    'presponsable',
    'categoria',
    'persona',
    'fecha',
    'desplazamiento'
  ]

  PREFIJOS_RESPUESTAS_CAMPOS = ['respuesta1','respuesta2', 'respuesta3', 
                                'respuesta4', 'respuesta5'] 

  CAMPOS_RESPUESTAS = [
    'actividad',
    'fecha',
    'proyectofinanciero',
    'actividadpf'
  ]

  PREFIJOS_ETIQUETAS_CAMPOS = ['etiqueta1', 'etiqueta2', 'etiqueta3', 
                               'etiqueta4', 'etiqueta5'] 

  CAMPOS_ETIQUETAS =  [
    'etiqueta',
    'fecha',
    'usuario',
    'observaciones'
  ]

  CAMPOS_PROYECTOS_FINANCIEROS_BAS = [
    'id',
    'nombres',
    'financiador',
    'fechainicio',
    'fechacierre',
    'responsable',
    'compromisos',
    'observaciones',
    'monto',
    'area',
    'equipotrabajo',
    'objetivos',
    'obj1_cod',
    'obj1_texto',
    'obj2_cod',
    'obj2_texto',
    'indicadores_obj',
    'resultados',
    'indicadoresres',
    'actividadespf'
  ]

  CAMPOS_INDICADORES_OBJ = [
    'refobj',
    'codigo',
    'nombre',
    'tipo',
  ]
  CAMPOS_RESULTADOS = [
    'refobj',
    'codigo',
    'resultado'
  ]
  CAMPOS_INDICADORES_RES = [ 
    'refres',
    'codigo',
    'tipo',
    'indicador'
  ]
  CAMPOS_ACTIVIDADESPF = [
    'refresultado',
    'codigo',
    'tipo',
    'actividad',
    'descripcion',
    'indicadoresgifmm'
  ]
  CAMPOS_PERSONAS_CASOS = []
  PREFIJOS_PERSONAS_CAMPOS.each do |pp| 
    CAMPOS_PERSONAVIC.each do |campo| 
      CAMPOS_PERSONAS_CASOS.push((pp + '_' + campo).to_sym)
    end
  end

  CAMPOS_UBICACIONES_CASOS = []
  PREFIJOS_UBICACIONES_CAMPOS.each do |pu| 
    CAMPOS_UBICACIONES.each do |campo| 
      CAMPOS_UBICACIONES_CASOS.push((pu + '_' + campo).to_sym)
    end
  end

  CAMPOS_RESPUESTAS_CASOS = []
  PREFIJOS_RESPUESTAS_CAMPOS.each do |res| 
    CAMPOS_RESPUESTAS.each do |campo| 
      CAMPOS_RESPUESTAS_CASOS.push((res + '_' + campo).to_sym)
    end
  end

  CAMPOS_PRESPONSABLES_CASOS = []
  PREFIJOS_PRESPONSABLES_CAMPOS.each do |pr| 
    CAMPOS_CASOPRESPONSABLES.each do |campo| 
      CAMPOS_UBICACIONES_CASOS.push((pr + '_' + campo).to_sym)
    end
  end

  CAMPOS_ACTOS_CASOS = []
  PREFIJOS_ACTOS_CAMPOS.each do |pac| 
    CAMPOS_ACTOS.each do |campo| 
      CAMPOS_ACTOS_CASOS.push((pac + '_' + campo).to_sym)
    end
  end

  CAMPOS_ETIQUETAS_CASOS = []
  PREFIJOS_ETIQUETAS_CAMPOS.each do |et| 
    CAMPOS_ETIQUETAS.each do |campo| 
      CAMPOS_ETIQUETAS_CASOS.push((et + '_' + campo).to_sym)
    end
  end

  PREFIJOS_CAMPOS_INDICADORES_OBJ = ['indicadorobj1', 'indicadorobj2', 'indicadorobj3', 'indicadorobj4']
  CAMPOS_INDICADORES_OBJ_T = []
  PREFIJOS_CAMPOS_INDICADORES_OBJ.each do |cod| 
    CAMPOS_INDICADORES_OBJ.each do |campo| 
      CAMPOS_INDICADORES_OBJ_T.push((cod + '_' + campo).to_sym)
    end
  end

  PREFIJOS_CAMPOS_RESULTADOS = ['resultado1', 'resultado2', 'resultado3', 'resultado4']
  CAMPOS_RESULTADOS_T= []
  PREFIJOS_CAMPOS_RESULTADOS.each do |cod|
    CAMPOS_RESULTADOS.each do |campo|
      CAMPOS_RESULTADOS_T.push((cod + '_' + campo).to_sym)
    end
  end

  PREFIJOS_CAMPOS_INDICADORES_RES = ['indicadorres1', 'indicadorres2', 'indicadorres3', 'indicadorres4', 'indicadorres5', 'indicadorres6']
  CAMPOS_INDICADORES_RES_T = []
  PREFIJOS_CAMPOS_INDICADORES_RES.each do |cod| 
    CAMPOS_INDICADORES_RES.each do |campo| 
      CAMPOS_INDICADORES_RES_T.push((cod + '_' + campo).to_sym)
    end
  end


  PREFIJOS_CAMPOS_ACTIVIDADESPF = ['actividadpf1', 'actividadpf2', 'actividadpf3', 'actividadpf4', 'actividadpf5', 'actividadpf6', 'actividadpf7', 'actividadpf8']
  CAMPOS_ACTIVIDADESPF_T = []
  PREFIJOS_CAMPOS_ACTIVIDADESPF.each do |cod|
    CAMPOS_ACTIVIDADESPF.each do |campo| 
      CAMPOS_ACTIVIDADESPF_T.push((cod + '_' + campo).to_sym)
    end
  end

  CAMPOS_PLANTILLAS_PROPIAS = {
    'Caso' => {
      campos: 
      CAMPOS_PERSONAS_CASOS +
      CAMPOS_UBICACIONES_CASOS +
      CAMPOS_MIGRA_SIMPLES +
      CAMPOS_MIGRA_RELA +
      CAMPOS_MIGRA_MULTI +
      CAMPOS_DESPLAZA_SIMPLES +
      CAMPOS_DESPLAZA_RELA +
      CAMPOS_DESPLAZA_MULTI +
      CAMPOS_DESPLAZA_BOOL +
      CAMPOS_DESPLAZA_ESPECIALES + 
      CAMPOS_RESPUESTAS_CASOS + 
      CAMPOS_PRESPONSABLES_CASOS +
      CAMPOS_ACTOS_CASOS +
      CAMPOS_ETIQUETAS_CASOS +
      [
        :actividades_departamentos,
        :actividades_municipios,
        :actividades_perfiles,
        :actividades_a_humanitaria_tipos_de_ayuda,
        :actividades_a_humanitaria_valor_de_ayuda,
        :actividades_a_humanitaria_modalidades_entrega,
        :actividades_a_humanitarias_convenios_financiados,
        :actividad_asesorias_juridicas,
        :actividades_as_juridicas_convenios_financiados,
        :actividades_acompañamientos_psicosociales,
        :actividades_a_psicosociales_convenios_financiados,

        :asesor,

        :beneficiarias_0_5_fecha_recepcion,
        :beneficiarias_6_12_fecha_recepcion,
        :beneficiarias_13_17_fecha_recepcion,
        :beneficiarias_18_26_fecha_recepcion,
        :beneficiarias_27_59_fecha_recepcion,
        :beneficiarias_60m_fecha_recepcion,
        :beneficiarias_se_fecha_recepcion,
        :beneficiarios_0_5_fecha_recepcion,
        :beneficiarios_6_12_fecha_recepcion,
        :beneficiarios_13_17_fecha_recepcion,
        :beneficiarios_18_26_fecha_recepcion,
        :beneficiarios_27_59_fecha_recepcion,
        :beneficiarios_60m_fecha_recepcion,
        :beneficiarios_se_fecha_recepcion,
        :beneficiarios_ss_0_5_fecha_recepcion,
        :beneficiarios_ss_6_12_fecha_recepcion,
        :beneficiarios_ss_13_17_fecha_recepcion,
        :beneficiarios_ss_18_26_fecha_recepcion,
        :beneficiarios_ss_27_59_fecha_recepcion,
        :beneficiarios_ss_60m_fecha_recepcion,
        :beneficiarios_ss_se_fecha_recepcion,

        :beneficiarias_0_5_fecha_salida,
        :beneficiarias_6_12_fecha_salida,
        :beneficiarias_13_17_fecha_salida,
        :beneficiarias_18_26_fecha_salida,
        :beneficiarias_27_59_fecha_salida,
        :beneficiarias_60m_fecha_salida,
        :beneficiarias_se_fecha_salida,
        :beneficiarios_0_5_fecha_salida,
        :beneficiarios_6_12_fecha_salida,
        :beneficiarios_13_17_fecha_salida,
        :beneficiarios_18_26_fecha_salida,
        :beneficiarios_27_59_fecha_salida,
        :beneficiarios_60m_fecha_salida,
        :beneficiarios_se_fecha_salida,
        :beneficiarios_ss_0_5_fecha_salida,
        :beneficiarios_ss_6_12_fecha_salida,
        :beneficiarios_ss_13_17_fecha_salida,
        :beneficiarios_ss_18_26_fecha_salida,
        :beneficiarios_ss_27_59_fecha_salida,
        :beneficiarios_ss_60m_fecha_salida,
        :beneficiarios_ss_se_fecha_salida,

        :caso_id,
        :contacto_comosupo,
        :contacto_consentimientosjr,
        :contacto_consentimientobd,
        :contacto_edad_fecha_recepcion,
        :contacto_edad_fecha_salida,
        :contacto_edad_ultimaatencion,
        :contacto_rangoedad_fecha_recepcion,
        :contacto_rangoedad_fecha_salida,
        :contacto_rangoedad_ultimaatencion,
        :contacto,
        :descripcion,
        :direccion,
        :expulsion,
        :fechadespemb,
        :fecharecepcion,
        :hora,
        :llegada,
        :memo,
        :memo1612,
        :numeroanexos,
        :numero_beneficiarios,
        :numero_madres_gestantes,
        :oficina,
        :presponsables,
        :tipificacion,
        :telefono,
        :ubicaciones,
        :ultimaatencion_actividad_id,
        :ultimaatencion_ac_juridica,
        :ultimaatencion_as_humanitaria,
        :ultimaatencion_as_juridica,
        :ultimaatencion_beneficiarios_0_5,
        :ultimaatencion_beneficiarios_6_12,
        :ultimaatencion_beneficiarios_13_17,
        :ultimaatencion_beneficiarios_18_26,
        :ultimaatencion_beneficiarios_27_59,
        :ultimaatencion_beneficiarios_60m,
        :ultimaatencion_beneficiarios_se,
        :ultimaatencion_beneficiarias_0_5,
        :ultimaatencion_beneficiarias_6_12,
        :ultimaatencion_beneficiarias_13_17,
        :ultimaatencion_beneficiarias_18_26,
        :ultimaatencion_beneficiarias_27_59,
        :ultimaatencion_beneficiarias_60m,
        :ultimaatencion_beneficiarias_se,
        :ultimaatencion_beneficiarios_ss_0_5,
        :ultimaatencion_beneficiarios_ss_6_12,
        :ultimaatencion_beneficiarios_ss_13_17,
        :ultimaatencion_beneficiarios_ss_18_26,
        :ultimaatencion_beneficiarios_ss_27_59,
        :ultimaatencion_beneficiarios_ss_60m,
        :ultimaatencion_beneficiarios_ss_se,
        :ultimaatencion_derechosvul,
        :ultimaatencion_fecha,
        :ultimaatencion_mes,
        :ultimaatencion_objetivo,
        :ultimaatencion_otros_ser_as,
        :victimas
      ],
      controlador: 'Sivel2Sjr::CasosController',
      ruta: '/casos'
    },

    'Actividad' => {
      campos: [
        Cor1440Gen::Actividad.human_attribute_name(
          :actividadareas).downcase.gsub(' ', '_'),
        Cor1440Gen::Actividad.human_attribute_name(
          :actividadpf).downcase.gsub(' ', '_'),
          'actualizacion',
          'anexo_1_desc',
          'anexo_2_desc',
          'anexo_3_desc',
          'anexo_4_desc',
          'anexo_5_desc',
          'anexos_ids',
          'campos_dinamicos',
          'corresponsables',
          'covid19',
          'creacion',
          'departamento',
          'departamento_altas_bajas',
          'detalles_financieros_ids',
          'fecha',
          'fecha_localizada',
          'id',
          'listado_casos_ids',
          'lugar',
          'mes',
          'municipio',
          'municipio_altas_bajas',
          'nombre',
          'numero_anexos',
          'numero_detalles_financieros',
          'objetivo',
          'observaciones',
          'objetivo_convenio_financiero',
          'oficina',
          'organizaciones_sociales',
          'organizaciones_sociales_ids',
          'poblacion',
          'poblacion_com_acogida',
          'poblacion_ids',
          'poblacion_hombres_adultos',
          'poblacion_hombres_adultos_ids',
          'poblacion_hombres_l',
          'poblacion_hombres_l_g1',
          'poblacion_hombres_l_g2',
          'poblacion_hombres_l_g3',
          'poblacion_hombres_l_g4',
          'poblacion_hombres_l_g5',
          'poblacion_hombres_l_g6',
          'poblacion_hombres_l_g7',
          'poblacion_hombres_r',
          'poblacion_hombres_r_g1',
          'poblacion_hombres_r_g1_ids',
          'poblacion_hombres_r_g2',
          'poblacion_hombres_r_g2_ids',
          'poblacion_hombres_r_g3',
          'poblacion_hombres_r_g3_ids',
          'poblacion_hombres_r_g4',
          'poblacion_hombres_r_g4_ids',
          'poblacion_hombres_r_g5',
          'poblacion_hombres_r_g5_ids',
          'poblacion_hombres_r_g6',
          'poblacion_hombres_r_g6_ids',
          'poblacion_hombres_r_g7',
          'poblacion_hombres_r_g7_ids',
          'poblacion_mujeres_adultas',
          'poblacion_mujeres_adultas_ids',
          'poblacion_mujeres_l',
          'poblacion_mujeres_l_g1',
          'poblacion_mujeres_l_g2',
          'poblacion_mujeres_l_g3',
          'poblacion_mujeres_l_g4',
          'poblacion_mujeres_l_g5',
          'poblacion_mujeres_l_g6',
          'poblacion_mujeres_l_g7',
          'poblacion_mujeres_r',
          'poblacion_mujeres_r_g1',
          'poblacion_mujeres_r_g1_ids',
          'poblacion_mujeres_r_g2',
          'poblacion_mujeres_r_g2_ids',
          'poblacion_mujeres_r_g3',
          'poblacion_mujeres_r_g3_ids',
          'poblacion_mujeres_r_g4',
          'poblacion_mujeres_r_g4_ids',
          'poblacion_mujeres_r_g5',
          'poblacion_mujeres_r_g5_ids',
          'poblacion_mujeres_r_g6',
          'poblacion_mujeres_r_g6_ids',
          'poblacion_mujeres_r_g7',
          'poblacion_mujeres_r_g7_ids',
          'poblacion_niñas_adolescentes_y_se',
          'poblacion_niñas_adolescentes_y_se_ids',
          'poblacion_niños_adolescentes_y_se',
          'poblacion_niños_adolescentes_y_se_ids',
          'poblacion_sinsexo',
          'poblacion_sinsexo_adultos',
          'poblacion_sinsexo_adultos_ids',
          'poblacion_sinsexo_g1',
          'poblacion_sinsexo_g1_ids',
          'poblacion_sinsexo_g2',
          'poblacion_sinsexo_g2_ids',
          'poblacion_sinsexo_g3',
          'poblacion_sinsexo_g3_ids',
          'poblacion_sinsexo_g4',
          'poblacion_sinsexo_g4_ids',
          'poblacion_sinsexo_g5',
          'poblacion_sinsexo_g5_ids',
          'poblacion_sinsexo_g6',
          'poblacion_sinsexo_g6_ids',
          'poblacion_sinsexo_g7',
          'poblacion_sinsexo_g7_ids',
          Cor1440Gen::Actividad.human_attribute_name(
            :proyectofinanciero).downcase.gsub(' ', '_'),
          Cor1440Gen::Actividad.human_attribute_name(
            :proyectos).downcase.gsub(' ', '_'),
          'responsable',
          'resultado'
      ],
      controlador: 'Cor1440Gen::ActividadesController',
      ruta: '/actividades'
    },
    'Proyecto' => {
      campos: 
        CAMPOS_PROYECTOS_FINANCIEROS_BAS+
        CAMPOS_INDICADORES_OBJ_T +
        CAMPOS_RESULTADOS_T +
        CAMPOS_INDICADORES_RES_T +
        CAMPOS_ACTIVIDADESPF_T,
      controlador: 'Sivel2Sjr::CasosController',
      ruta: '/proyectofinanciero'
    },
    'Consgifmm' => {
      solo_multiple: true,
      campos: [
          'actividad_id',
          'actividad_observaciones',
          'actividad_responsable',
          'actividadmarcologico_nombre',
          'beneficiarias_nuevas_niñas_adolescentes_y_se',
          'beneficiarias_nuevas_mujeres_adultas',
          'beneficiarias_nuevas_mujeres_0_5',
          'beneficiarias_nuevas_mujeres_6_12',
          'beneficiarias_nuevas_mujeres_13_17',
          'beneficiarias_nuevas_mujeres_18_59',
          'beneficiarias_nuevas_mujeres_60_o_mas',
          'beneficiarios',
          'beneficiarios_nuevos_afrodescendientes',
          'beneficiarios_nuevos_colombianos_retornados',
          'beneficiarios_nuevos_comunidades_de_acogida',
          'beneficiarios_nuevos_con_discapacidad',
          'beneficiarios_nuevos_en_transito',
          'beneficiarios_nuevos_hombres_adultos',
          'beneficiarios_nuevos_hombres_0_5',
          'beneficiarios_nuevos_hombres_6_12',
          'beneficiarios_nuevos_hombres_13_17',
          'beneficiarios_nuevos_hombres_18_59',
          'beneficiarios_nuevos_hombres_60_o_mas',
          'beneficiarios_nuevos_indigenas',
          'beneficiarios_nuevos_lgbti',
          'beneficiarios_nuevos_mes',
          'beneficiarios_nuevos_niños_adolescentes_y_se',
          'beneficiarios_nuevos_otra_etnia',
          'beneficiarios_nuevos_pendulares',
          'beneficiarios_nuevos_sinsexo_adultos',
          'beneficiarios_nuevos_sinsexo_menores_y_se',
          'beneficiarios_nuevos_vocacion_permanencia',
          'conveniofinanciado_nombre',
          'covid19',
          'departamento_gifmm',
          'detalleah_unidad',
          'detalleah_cantidad',
          'detalleah_modalidad',
          'detalleah_tipo_transferencia',
          'detalleah_mecanismo_entrega',
          'detalleah_frecuencia_entrega',
          'detalleah_monto_por_persona',
          'detalleah_numero_meses_cobertura',
          'estado',
          'fecha',
          'indicador_gifmm',
          'mes',
          'municipio_gifmm',
          'objetivo',
          'oficina',
          'parte_rmrp',
          'sector_gifmm',
          'socio_implementador',
          'socio_principal',
          'tipo_implementacion'
      ],
      controlador: '::Consgifmm',
      ruta: '/consgifmm'
    }


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
    can :busca, Sivel2Gen::Caso
    can :lista, Sivel2Gen::Caso
    can :personas_casos, Sivel2Gen::Caso
    can :poblacion_sexo_rangoedadac, Sivel2Gen::Caso

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
        can [:read, :new], Cor1440Gen::Actividadpf
        can :read, Cor1440Gen::Informe
        can :read, Cor1440Gen::Proyectofinanciero

        can :read, Heb412Gen::Doc
        can :create, Heb412Gen::Doc

        can :manage, Sal7711Gen::Articulo

      when Ability::ROLSIST

        can [:new, :read], Cor1440Gen::Actividad
        can [:new, :read], Cor1440Gen::Actividadpf
        can :manage, Cor1440Gen::Actividad, oficina_id: [1, usuario.oficina_id]
        can :read, Cor1440Gen::Proyectofinanciero
        can [:index, :read], Cor1440Gen::Rangoedadac

        can :read, Heb412Gen::Doc
        can :create, Heb412Gen::Doc

        can :manage, Sip::Persona

        can :manage, Sivel2Gen::Acto
        can :read, Sivel2Gen::Caso, casosjr: { oficina_id: usuario.oficina_id }
        can [:update, :create, :destroy], Sivel2Gen::Caso,
          casosjr: { asesor: usuario.id, oficina_id:usuario.oficina_id }
        can :new, Sivel2Gen::Caso

        can :read, Sivel2Sjr::Consactividadcaso
        can :read, ::Consgifmm

      when Ability::ROLANALI

        can :manage, Cor1440Gen::Actividad, oficina_id: [1, usuario.oficina_id]
        can [:read, :new], Cor1440Gen::Actividad
        can [:read, :new], Cor1440Gen::Actividadpf
        can :read, Cor1440Gen::Informe
        can :index, Cor1440Gen::Mindicadorpf
        can :read, Cor1440Gen::Proyectofinanciero
        can [:index, :read], Cor1440Gen::Rangoedadac

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
        can :read, ::Consgifmm
      when Ability::ROLCOOR
        can :manage, Cor1440Gen::Informe
        can [:read, :new], Cor1440Gen::Actividad
        can [:read, :new], Cor1440Gen::Actividadpf
        can :manage, Cor1440Gen::Actividad, oficina_id: [1, usuario.oficina_id]
        can :read, Cor1440Gen::Proyectofinanciero
        can [:index, :read], Cor1440Gen::Rangoedadac

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
        can :read, ::Consgifmm

      when Ability::ROLADMIN, Ability::ROLDIR
        can :manage, Cor1440Gen::Actividad
        can :manage, Cor1440Gen::Actividadpf
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
        can :read, ::Consgifmm

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
