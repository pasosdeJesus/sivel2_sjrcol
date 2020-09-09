class LlenaIndicadorgifmm < ActiveRecord::Migration[6.0]
  def up
    execute <<-SQL
      INSERT INTO public.indicadorgifmm (id, sectorgifmm_id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES( 1, 1, '# de la población provista de kits de saneamiento o higiene o artículos clave de higiene o acceso a puntos de lavado de manos con jabón o similar los  estándares los estándares Esfera y a la normativa nacional vigente.', null, '2020-09-08', null, '2020-09-08', '2020-09-08');
      INSERT INTO public.indicadorgifmm (id, sectorgifmm_id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES( 2, 1, '# de niños y niñas en espacios de aprendizaje incluidos espacios de desarrollo infantil con acceso a servicios WASH según los  estándares los estándares Esfera y a la normativa nacional vigente.', null, '2020-09-08', null, '2020-09-08', '2020-09-08');
      INSERT INTO public.indicadorgifmm (id, sectorgifmm_id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES( 3, 1, '# de personas (hombres, mujeres, niños y niñas) a nivel comunitario (incluida las comunidades de acogida) con acceso agua segura  y saneamiento básico de acuerdo a los estándares Esfera y a la normativa nacional vigente.', null, '2020-09-08', null, '2020-09-08', '2020-09-08');
      INSERT INTO public.indicadorgifmm (id, sectorgifmm_id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES( 4, 1, '# de personas (hombres, mujeres, niños y niñas) en los puntos de prestación de servicios (centros de salud, refugios, comedores, puntos de migración y puntos de tránsito)  con acceso DIARIO a los servicios de WASH según los estándares los estándares Esfera y a la normativa nacional vigente.', null, '2020-09-08', null, '2020-09-08', '2020-09-08');
      INSERT INTO public.indicadorgifmm (id, sectorgifmm_id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES( 5, 1, '# de personas que reciben servicios de Agua y saneamiento a nivel comunitario e institucional ', null, '2020-09-08', null, '2020-09-08', '2020-09-08');
      INSERT INTO public.indicadorgifmm (id, sectorgifmm_id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES( 6, 2, '# de población objetivo apoyada con actividades de asentamiento', null, '2020-09-08', null, '2020-09-08', '2020-09-08');
      INSERT INTO public.indicadorgifmm (id, sectorgifmm_id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES( 7, 2, '# de refugiados y migrantes de Venezuela apoyados con refugio colectivo', null, '2020-09-08', null, '2020-09-08', '2020-09-08');
      INSERT INTO public.indicadorgifmm (id, sectorgifmm_id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES( 8, 2, '# de refugiados y migrantes de Venezuela apoyados con refugio individual a corto plazo', null, '2020-09-08', null, '2020-09-08', '2020-09-08');
      INSERT INTO public.indicadorgifmm (id, sectorgifmm_id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES( 9, 2, '# de refugiados y migrantes de Venezuela apoyados con refugio individual a mediano y largo plazo', null, '2020-09-08', null, '2020-09-08', '2020-09-08');
      INSERT INTO public.indicadorgifmm (id, sectorgifmm_id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES( 10, 3, '# de boletines abiertos', null, '2020-09-08', null, '2020-09-08', '2020-09-08');
      INSERT INTO public.indicadorgifmm (id, sectorgifmm_id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES( 11, 3, '# de productos de comunicación publicados', null, '2020-09-08', null, '2020-09-08', '2020-09-08');
      INSERT INTO public.indicadorgifmm (id, sectorgifmm_id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES( 12, 3, '# de visitas a la página web R4V.info', null, '2020-09-08', null, '2020-09-08', '2020-09-08');
      INSERT INTO public.indicadorgifmm (id, sectorgifmm_id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES( 13, 3, '# de campañas contra la xenofobia y la discriminación implementadas', null, '2020-09-08', null, '2020-09-08', '2020-09-08');
      INSERT INTO public.indicadorgifmm (id, sectorgifmm_id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES( 14, 3, '# de personas contactadas con mensajes contra la xenofobia y la discriminación como parte de las campañas', null, '2020-09-08', null, '2020-09-08', '2020-09-08');
      INSERT INTO public.indicadorgifmm (id, sectorgifmm_id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES( 15, 4, '# de mecanismos de comunicación de doble vía establecido', null, '2020-09-08', null, '2020-09-08', '2020-09-08');
      INSERT INTO public.indicadorgifmm (id, sectorgifmm_id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES( 16, 4, '# de personas que acceden mecanismos de comunicación de doble vía para expresar sus necesidades/preocupaciones/retroalimentación', null, '2020-09-08', null, '2020-09-08', '2020-09-08');
      INSERT INTO public.indicadorgifmm (id, sectorgifmm_id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES( 17, 5, '# de grupos de sectores activos', null, '2020-09-08', null, '2020-09-08', '2020-09-08');
      INSERT INTO public.indicadorgifmm (id, sectorgifmm_id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES( 18, 5, '# de reuniones sectoriales e intersectoriales celebradas', null, '2020-09-08', null, '2020-09-08', '2020-09-08');
      INSERT INTO public.indicadorgifmm (id, sectorgifmm_id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES( 19, 5, '# de socios, incluidas ONG, agencias de la ONU, organizaciones de la sociedad civil, donantes y el Movimiento de la Cruz Roja, que participan en la coordinación regional', null, '2020-09-08', null, '2020-09-08', '2020-09-08');
      INSERT INTO public.indicadorgifmm (id, sectorgifmm_id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES( 20, 6, '# de docentes que reciben material educativo en espacios de educación formales', null, '2020-09-08', null, '2020-09-08', '2020-09-08');
      INSERT INTO public.indicadorgifmm (id, sectorgifmm_id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES( 21, 6, '# de instituciones educativas apoyadas con suministros, construidas, establecidas o rehabilitadas', null, '2020-09-08', null, '2020-09-08', '2020-09-08');
      INSERT INTO public.indicadorgifmm (id, sectorgifmm_id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES( 22, 6, '# de niños en edad escolar (niñas y niños) de Venezuela inscritos en instituciones educativas apoyadas y escuelas nacionales', null, '2020-09-08', null, '2020-09-08', '2020-09-08');
      INSERT INTO public.indicadorgifmm (id, sectorgifmm_id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES( 23, 6, '# de refugiados y migrantes de Venezuela que acceden a servicios de educación de emergencia no formales y formales', null, '2020-09-08', null, '2020-09-08', '2020-09-08');
      INSERT INTO public.indicadorgifmm (id, sectorgifmm_id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES( 24, 6, '# de refugiados y migrantes de Venezuela que reciben asistencia para el reconocimiento de títulos académicos, títulos, etc.', null, '2020-09-08', null, '2020-09-08', '2020-09-08');
      INSERT INTO public.indicadorgifmm (id, sectorgifmm_id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES( 25, 6, '# de instituciones educativas apoyadas con suministros (Educación: materiales pedagógicos, didácticos; higiene y lavado de manos WASH; Alimentación escolar: alimentos y suplementos saludables), construidas, establecidas o rehabilitadas.', null, '2020-09-08', null, '2020-09-08', '2020-09-08');
      INSERT INTO public.indicadorgifmm (id, sectorgifmm_id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES( 26, 6, '# Niños refugiados y migrantes de Venezuela que se incorporan a los mecanismos de educación a distancia a través de diferentes métodos de capacitación (radio, TV, guías y material impreso)', null, '2020-09-08', null, '2020-09-08', '2020-09-08');
      INSERT INTO public.indicadorgifmm (id, sectorgifmm_id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES( 27, 7, '# de campañas contra la xenofobia y contra la discriminación.', null, '2020-09-08', null, '2020-09-08', '2020-09-08');
      INSERT INTO public.indicadorgifmm (id, sectorgifmm_id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES( 28, 7, '# de individuos alcanzados con actividades de inclusión financiera', null, '2020-09-08', null, '2020-09-08', '2020-09-08');
      INSERT INTO public.indicadorgifmm (id, sectorgifmm_id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES( 29, 7, '# de individuos alcanzados con apoyo para iniciativas de autoempleo o emprendimiento.', null, '2020-09-08', null, '2020-09-08', '2020-09-08');
      INSERT INTO public.indicadorgifmm (id, sectorgifmm_id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES( 30, 7, '# de individuos apoyados para acceder a oportunidades de empleo', null, '2020-09-08', null, '2020-09-08', '2020-09-08');
      INSERT INTO public.indicadorgifmm (id, sectorgifmm_id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES( 31, 7, '# de personas alcanzadas con mensajes contra la xenofobia y contra la discriminación como parte de las campañas', null, '2020-09-08', null, '2020-09-08', '2020-09-08');
      INSERT INTO public.indicadorgifmm (id, sectorgifmm_id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES( 32, 7, '# de personas que participan en actividades que promueven la cohesión social', null, '2020-09-08', null, '2020-09-08', '2020-09-08');
      INSERT INTO public.indicadorgifmm (id, sectorgifmm_id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES( 33, 7, '# de refugiados y migrantes de Venezuela que recibieron asistencia para el reconocimiento de títulos y / o habilidades profesionales.', null, '2020-09-08', null, '2020-09-08', '2020-09-08');
      INSERT INTO public.indicadorgifmm (id, sectorgifmm_id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES( 34, 7, '# de individuos alcanzados con actividades de inclusión financiera', null, '2020-09-08', null, '2020-09-08', '2020-09-08');
      INSERT INTO public.indicadorgifmm (id, sectorgifmm_id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES( 35, 7, '# de personas alcanzadas con mensajes contra la xenofobia y contra la discriminación como parte de las campañas', null, '2020-09-08', null, '2020-09-08', '2020-09-08');
      INSERT INTO public.indicadorgifmm (id, sectorgifmm_id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES( 36, 7, '# de campañas contra la xenofobia y contra la discriminación.', null, '2020-09-08', null, '2020-09-08', '2020-09-08');
      INSERT INTO public.indicadorgifmm (id, sectorgifmm_id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES( 37, 7, '# de productos elaborados y difundidos con recomendaciones y/o mensajes claves sobre medidas de mitigación del impacto en el trabajo en el contexto de COVID-19.', null, '2020-09-08', null, '2020-09-08', '2020-09-08');
      INSERT INTO public.indicadorgifmm (id, sectorgifmm_id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES( 38, 8, '# de actores que informan bajo el marco de monitoreo de RMRP', null, '2020-09-08', null, '2020-09-08', '2020-09-08');
      INSERT INTO public.indicadorgifmm (id, sectorgifmm_id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES( 39, 8, '# de grupos de trabajo de mensajería instantánea regionales y nacionales activos.', null, '2020-09-08', null, '2020-09-08', '2020-09-08');
      INSERT INTO public.indicadorgifmm (id, sectorgifmm_id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES( 40, 8, '# de plataformas nacionales y subregionales con páginas web activas', null, '2020-09-08', null, '2020-09-08', '2020-09-08');
      INSERT INTO public.indicadorgifmm (id, sectorgifmm_id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES( 41, 8, '# de productos comunes de gestión de información, incluidas infografías, conjuntos de datos, estadísticas disponibles de forma regular o ad hoc.', null, '2020-09-08', null, '2020-09-08', '2020-09-08');
      INSERT INTO public.indicadorgifmm (id, sectorgifmm_id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES( 42, 9, '# de beneficiarios de transferencias multipropósito en efectivo', null, '2020-09-08', null, '2020-09-08', '2020-09-08');
      INSERT INTO public.indicadorgifmm (id, sectorgifmm_id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES( 43, 10, '# de refugiados y migrantes de Venezuela provistos de artículos no alimentarios', null, '2020-09-08', null, '2020-09-08', '2020-09-08');
      INSERT INTO public.indicadorgifmm (id, sectorgifmm_id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES( 44, 11, '# de mujeres embarazadas y lactantes que reciben intervenciones nutricionales', null, '2020-09-08', null, '2020-09-08', '2020-09-08');
      INSERT INTO public.indicadorgifmm (id, sectorgifmm_id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES( 45, 11, '# de niños que reciben intervenciones nutricionales', null, '2020-09-08', null, '2020-09-08', '2020-09-08');
      INSERT INTO public.indicadorgifmm (id, sectorgifmm_id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES( 46, 11, '# cuidadores con consejería en nutrición infantil', null, '2020-09-08', null, '2020-09-08', '2020-09-08');
      INSERT INTO public.indicadorgifmm (id, sectorgifmm_id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES( 47, 12, '# de refugiados y migrantes de Venezuela provistos de servicios de telecomunicaciones', null, '2020-09-08', null, '2020-09-08', '2020-09-08');
      INSERT INTO public.indicadorgifmm (id, sectorgifmm_id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES( 48, 13, '# de mecanismos de presentación de informes seguros y accesibles para la PEAS', null, '2020-09-08', null, '2020-09-08', '2020-09-08');
      INSERT INTO public.indicadorgifmm (id, sectorgifmm_id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES( 49, 14, '# de grupos comunitarios fortalecidos', null, '2020-09-08', null, '2020-09-08', '2020-09-08');
      INSERT INTO public.indicadorgifmm (id, sectorgifmm_id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES( 50, 14, '# de personas alcanzadas a través de actividades de información y sensibilización ', null, '2020-09-08', null, '2020-09-08', '2020-09-08');
      INSERT INTO public.indicadorgifmm (id, sectorgifmm_id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES( 51, 14, '# de refugiados y migrantes de Venezuela afectados por el conflicto armado que recibieron asistencia de protección (incluidos desplazados internos, amenazas, asesinatos, desaparición, uso y reclutamiento como consecuencia del conflicto armado colombiano)', null, '2020-09-08', null, '2020-09-08', '2020-09-08');
      INSERT INTO public.indicadorgifmm (id, sectorgifmm_id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES( 52, 14, '# de refugiados y migrantes de Venezuela asistidos con asistencia legal (asistencia, representación y / o asesoramiento)', null, '2020-09-08', null, '2020-09-08', '2020-09-08');
      INSERT INTO public.indicadorgifmm (id, sectorgifmm_id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES( 53, 14, '# de refugiados y migrantes de Venezuela que recibieron servicios de protección (excluyendo servicios legales)', null, '2020-09-08', null, '2020-09-08', '2020-09-08');
      INSERT INTO public.indicadorgifmm (id, sectorgifmm_id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES( 54, 14, '# de refugiados y migrantes LGTBI que recibieron servicios especializados de información, prevención y respuesta.', null, '2020-09-08', null, '2020-09-08', '2020-09-08');
      INSERT INTO public.indicadorgifmm (id, sectorgifmm_id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES( 55, 14, '# de refugiados, migrantes y la comunidad de acogida asistida a través de espacios de apoyo', null, '2020-09-08', null, '2020-09-08', '2020-09-08');
      INSERT INTO public.indicadorgifmm (id, sectorgifmm_id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES( 56, 14, '# de personas asistidas a través de Espacios de Apoyo', null, '2020-09-08', null, '2020-09-08', '2020-09-08');
      INSERT INTO public.indicadorgifmm (id, sectorgifmm_id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES( 57, 14, '# de acciones institucionales implementadas en la protección de refugiados y migrantes de Venezuela', null, '2020-09-08', null, '2020-09-08', '2020-09-08');
      INSERT INTO public.indicadorgifmm (id, sectorgifmm_id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES( 58, 14, '# de espacios de apoyo establecidos y operando', null, '2020-09-08', null, '2020-09-08', '2020-09-08');
      INSERT INTO public.indicadorgifmm (id, sectorgifmm_id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES( 59, 15, '# de actores capacitados en protección infantil (incluida la prevención, mitigación y respuesta a la violencia)', null, '2020-09-08', null, '2020-09-08', '2020-09-08');
      INSERT INTO public.indicadorgifmm (id, sectorgifmm_id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES( 60, 15, '# de niños refugiados y migrantes de Venezuela que recibieron asistencia jurídica (asistencia, representación y / o asesoramiento)', null, '2020-09-08', null, '2020-09-08', '2020-09-08');
      INSERT INTO public.indicadorgifmm (id, sectorgifmm_id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES( 61, 15, '# de niños refugiados y migrantes de Venezuela que recibieron servicios especializados de protección infantil (prevención y respuesta a la violencia), excluidos los servicios legales', null, '2020-09-08', null, '2020-09-08', '2020-09-08');
      INSERT INTO public.indicadorgifmm (id, sectorgifmm_id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES( 62, 15, '# de personas contactadas a través de actividades de información y sensibilización sobre prevención, mitigación y respuesta de riesgos de protección infantil', null, '2020-09-08', null, '2020-09-08', '2020-09-08');
      INSERT INTO public.indicadorgifmm (id, sectorgifmm_id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES( 63, 16, '# de entidades donantes que asisten a reuniones sectoriales y / o de plataforma', null, '2020-09-08', null, '2020-09-08', '2020-09-08');
      INSERT INTO public.indicadorgifmm (id, sectorgifmm_id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES( 64, 16, '# de productos de promoción conjunta desarrollados', null, '2020-09-08', null, '2020-09-08', '2020-09-08');
      INSERT INTO public.indicadorgifmm (id, sectorgifmm_id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES( 65, 16, '# de sesiones informativas conjuntas de donantes proporcionadas', null, '2020-09-08', null, '2020-09-08', '2020-09-08');
      INSERT INTO public.indicadorgifmm (id, sectorgifmm_id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES( 66, 17, '# de atenciones de enfermería prenatales ', null, '2020-09-08', null, '2020-09-08', '2020-09-08');
      INSERT INTO public.indicadorgifmm (id, sectorgifmm_id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES( 67, 17, '# de atenciones ginecológicas prenatales ', null, '2020-09-08', null, '2020-09-08', '2020-09-08');
      INSERT INTO public.indicadorgifmm (id, sectorgifmm_id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES( 68, 17, '# de atenciones intergrales prenatales (incl. entrega de medicamentos y exámenes)', null, '2020-09-08', null, '2020-09-08', '2020-09-08');
      INSERT INTO public.indicadorgifmm (id, sectorgifmm_id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES( 69, 17, '# de atenciones médicas prenatales ', null, '2020-09-08', null, '2020-09-08', '2020-09-08');
      INSERT INTO public.indicadorgifmm (id, sectorgifmm_id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES( 70, 17, '# de brotes que fueron detectados y controlados', null, '2020-09-08', null, '2020-09-08', '2020-09-08');
      INSERT INTO public.indicadorgifmm (id, sectorgifmm_id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES( 71, 17, '# de consultas de atención de emergencia para refugiados y migrantes de Venezuela, incluidos el parto y la atención del recién nacido', null, '2020-09-08', null, '2020-09-08', '2020-09-08');
      INSERT INTO public.indicadorgifmm (id, sectorgifmm_id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES( 72, 17, '# de consultas de atención primaria de salud para refugiados y migrantes de Venezuela, incluyendo TBC, VIH / SIDA, enfermedades no transmisibles, salud mental, apoyo psicosocial y otros problemas de salud.', null, '2020-09-08', null, '2020-09-08', '2020-09-08');
      INSERT INTO public.indicadorgifmm (id, sectorgifmm_id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES( 73, 17, '# de consultas sobre salud sexual y reproductiva para refugiados y migrantes de Venezuela de 15 a 49 años', null, '2020-09-08', null, '2020-09-08', '2020-09-08');
      INSERT INTO public.indicadorgifmm (id, sectorgifmm_id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES( 74, 17, '# de establecimientos de salud apoyados (incluidos equipos, recursos humanos o suministros, etc.)', null, '2020-09-08', null, '2020-09-08', '2020-09-08');
      INSERT INTO public.indicadorgifmm (id, sectorgifmm_id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES( 75, 17, '# de individuos atendidos en salud mental o soporte psicosocial', null, '2020-09-08', null, '2020-09-08', '2020-09-08');
      INSERT INTO public.indicadorgifmm (id, sectorgifmm_id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES( 76, 17, '# de individuos vacunados de acuerdo con el calendario nacional', null, '2020-09-08', null, '2020-09-08', '2020-09-08');
      INSERT INTO public.indicadorgifmm (id, sectorgifmm_id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES( 77, 17, '# de instalaciones de EMONC (atención obstétrica de emergencia y del recién nacido) disponibles por cada 500,000 personas', null, '2020-09-08', null, '2020-09-08', '2020-09-08');
      INSERT INTO public.indicadorgifmm (id, sectorgifmm_id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES( 78, 17, '# de niños y niñas menores de 5 años con DNT aguda atendidos', null, '2020-09-08', null, '2020-09-08', '2020-09-08');
      INSERT INTO public.indicadorgifmm (id, sectorgifmm_id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES( 79, 17, '# de personas beneficiadas de información, educación y comunicación en salud ', null, '2020-09-08', null, '2020-09-08', '2020-09-08');
      INSERT INTO public.indicadorgifmm (id, sectorgifmm_id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES( 80, 17, '# de planes de contingencia o emergencia de salud pública preparados', null, '2020-09-08', null, '2020-09-08', '2020-09-08');
      INSERT INTO public.indicadorgifmm (id, sectorgifmm_id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES( 81, 17, '# de trabajadores comunitarios de salud capacitados', null, '2020-09-08', null, '2020-09-08', '2020-09-08');
      INSERT INTO public.indicadorgifmm (id, sectorgifmm_id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES( 82, 17, '# de trabajadores de la salud capacitados', null, '2020-09-08', null, '2020-09-08', '2020-09-08');
      INSERT INTO public.indicadorgifmm (id, sectorgifmm_id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES( 83, 17, '# de trabajadores de la salud capacitados en emergencias en salud pública', null, '2020-09-08', null, '2020-09-08', '2020-09-08');
      INSERT INTO public.indicadorgifmm (id, sectorgifmm_id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES( 84, 17, '# de trabajadores de la salud capacitados en enfermedades transmisibles y no transmisibles', null, '2020-09-08', null, '2020-09-08', '2020-09-08');
      INSERT INTO public.indicadorgifmm (id, sectorgifmm_id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES( 85, 17, '# de trabajadores de la salud capacitados en salud materna', null, '2020-09-08', null, '2020-09-08', '2020-09-08');
      INSERT INTO public.indicadorgifmm (id, sectorgifmm_id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES( 86, 17, '# de trabajadores de la salud capacitados en salud sexual y reproductiva', null, '2020-09-08', null, '2020-09-08', '2020-09-08');
      INSERT INTO public.indicadorgifmm (id, sectorgifmm_id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES( 87, 17, '# de trabajadores de la salud capacitados en violencia sexual', null, '2020-09-08', null, '2020-09-08', '2020-09-08');
      INSERT INTO public.indicadorgifmm (id, sectorgifmm_id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES( 88, 17, '# de países que han asegurado el acceso continuo y permanente de las personas refugiadas y migrantes a los servicios esenciales de salud durante la repuesta de emergencia ante el COVID19', null, '2020-09-08', null, '2020-09-08', '2020-09-08');
      INSERT INTO public.indicadorgifmm (id, sectorgifmm_id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES( 89, 18, '# de beneficiarios de proyectos productivos de respuesta rápida (Incl. entrega de insumos agropecuarios, asistencia técnica, etc.)', null, '2020-09-08', null, '2020-09-08', '2020-09-08');
      INSERT INTO public.indicadorgifmm (id, sectorgifmm_id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES( 90, 18, '# de beneficiarios que aumentan la disponibilidad y el acceso a alimentos a través de la producción para el autoconsumo.', null, '2020-09-08', null, '2020-09-08', '2020-09-08');
      INSERT INTO public.indicadorgifmm (id, sectorgifmm_id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES( 91, 18, '# de personas que reciben asistencia alimentaria.', null, '2020-09-08', null, '2020-09-08', '2020-09-08');
      INSERT INTO public.indicadorgifmm (id, sectorgifmm_id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES( 92, 18, '# de personas que reciben comidas calientes en comedores comunitarios', null, '2020-09-08', null, '2020-09-08', '2020-09-08');
      INSERT INTO public.indicadorgifmm (id, sectorgifmm_id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES( 93, 18, '# de personas que reciben alimentación escolar', null, '2020-09-08', null, '2020-09-08', '2020-09-08');
      INSERT INTO public.indicadorgifmm (id, sectorgifmm_id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES( 94, 18, '# de personas que reciben kits de comida para caminantes ', null, '2020-09-08', null, '2020-09-08', '2020-09-08');
      INSERT INTO public.indicadorgifmm (id, sectorgifmm_id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES( 95, 18, '# de personas que reciben raciones alimentarias ', null, '2020-09-08', null, '2020-09-08', '2020-09-08');
      INSERT INTO public.indicadorgifmm (id, sectorgifmm_id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES( 96, 19, '# de refugiados y migrantes de Venezuela provistos de asistencia de transporte', null, '2020-09-08', null, '2020-09-08', '2020-09-08');
      INSERT INTO public.indicadorgifmm (id, sectorgifmm_id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES( 97, 20, '# de personal que participa en actividades de creación de capacidad para respuestas de lucha contra la trata o contrabando.', null, '2020-09-08', null, '2020-09-08', '2020-09-08');
      INSERT INTO public.indicadorgifmm (id, sectorgifmm_id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES( 98, 20, '# de personas en riesgo a las que se llegó con actividades de prevención de la trata en zonas de tránsito o destino.', null, '2020-09-08', null, '2020-09-08', '2020-09-08');
      INSERT INTO public.indicadorgifmm (id, sectorgifmm_id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES( 99, 20, '# de refugiados y migrantes venezolanos a los que se llegó con servicios de asistencia para víctimas de trata.', null, '2020-09-08', null, '2020-09-08', '2020-09-08');
      INSERT INTO public.indicadorgifmm (id, sectorgifmm_id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES( 100, 20, '# mecanismos institucionales nacionales, subnacionales y/o regionales apoyados y/o creados para la prevención, protección, asistencia y/o judicialización de trata y tráfico ilícito de personas refugiadas y migrantes de Venezuela. ', null, '2020-09-08', null, '2020-09-08', '2020-09-08');
      INSERT INTO public.indicadorgifmm (id, sectorgifmm_id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES( 101, 21, '# de mecanismos de informes seguros y accesibles para PSEA', null, '2020-09-08', null, '2020-09-08', '2020-09-08');
      INSERT INTO public.indicadorgifmm (id, sectorgifmm_id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES( 102, 21, '# de personas capacitadas en prevención y respuesta de VG', null, '2020-09-08', null, '2020-09-08', '2020-09-08');
      INSERT INTO public.indicadorgifmm (id, sectorgifmm_id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES( 103, 21, '# de refugiados y migrantes de Venezuela que recibieron servicios de información, prevención y respuesta de violencia de género', null, '2020-09-08', null, '2020-09-08', '2020-09-08');
      INSERT INTO public.indicadorgifmm (id, sectorgifmm_id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES( 104, 21, '# de herramientas, directrices y modelos proporcionados para apoyar la adaptación de la prestación de servicios especializados VBG.', null, '2020-09-08', null, '2020-09-08', '2020-09-08');
      INSERT INTO public.indicadorgifmm (id, sectorgifmm_id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at)
        VALUES( 105, 21, '# de vías de referencia de VBG actualizadas regularmente', null, '2020-09-08', null, '2020-09-08', '2020-09-08');
      SELECT setval('public.indicadorgifmm_id_seq', 100);
    SQL
  end

  def down
    execute <<-SQL
          DELETE FROM public.indicadorgifmm WHERE id>='1' AND id<='105'
    SQL
  end
end
