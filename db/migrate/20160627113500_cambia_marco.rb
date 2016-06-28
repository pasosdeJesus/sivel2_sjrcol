class CambiaMarco < ActiveRecord::Migration
  def up
    execute <<-SQL
    INSERT INTO sivel2_gen_categoria (id, nombre, tipocat, observaciones, 
    fechacreacion, created_at, updated_at, supracategoria_id) VALUES
    ('3000', 'HOMICIDIO EN PERSONA PROTEGIDA', 'I', 'Privación de la vida de una persona ocurrida con ocasión y en el desarrollo del conflicto armado y/o por violencia política y social (Se entiende por persona protegida: 1. Los integrantes de la población civil. 2. Las personas que no participan en hostilidades y los civiles en poder de la parte adversa. 3. Los heridos, enfermos o náufragos puestos fuera de combate. 4. El personal sanitario o religioso. 5. Los periodistas en misión o corresponsales de guerra acreditados. 6. Los combatientes que hayan depuesto las armas por captura, rendición u otra causa análoga. 7. Quienes antes del comienzo de las hostilidades fueren considerados como apátridas o refugiados. 8. Cualquier otra persona que tenga aquella condición en virtud de los Convenios I, II, III y IV de Ginebra de 1949 y los protocolos Adicionales I y II de 1977 y otros que llegaren a ratificarse. (art.135 CPC).', '2016-06-27', '2016-06-27', '2016-06-27', '100'),
    ('3001', 'ATENTADO', 'I', 'Es el intento de destruir la vida o de afectar la integridad física de una persona o grupo de personas protegidas en forma intencional con ocasión y en el desarrollo del conflicto armado y/o la violencia social y política. Importa precisar que el hecho debe estar claramente dirigido contra personas, pues no se considera como atentado el perpetrado contra bienes.', '2016-06-27', '2016-06-27', '2016-06-27', '100'),
    ('3002', 'AMENAZA INDIVIDUAL', 'I', 'Es la manifestación de violencia contra una persona protegida con ocasión y en el desarrollo del conflicto armado y/o violencia política y social, que lo colocan en situación de víctima potencial de agresiones contra su vida o integridad personal.', '2016-06-27', '2016-06-27', '2016-06-27', '100'),
    ('3502', 'AMENAZA COLECTIVA', 'O', 'Es la manifestación de violencia contra un grupo de personas protegidas con ocasión y en el desarrollo del conflicto armado y/o violencia política y social que los colocan en situación de víctimas potenciale de agresiones contra su vida, integridad personal u organización social y/o política.', '2016-06-27', '2016-06-27', '2016-06-27', '100'),
    ('3003', 'TORTURA Y TRATOS INHUMANOS, CRUELES Y DEGRADANTES', 'I', 'Son los actos por los cuales se inflije intencionalmente a una persona dolores o sufrimientos graves, ya sean físicos o mentales, con ocasión y en desarrollo del conflicto armado y/o violencia política y social.', '2016-06-27', '2016-06-27', '2016-06-27', '100'),
    ('3004', 'HERIDAS', 'I', 'Toda forma lesiones infligidas a una persona con ocasión y en desarrollo del conflicto armado,y/o violencia política y social.', '2016-06-27', '2016-06-27', '2016-06-27', '100'),
    ('3005', 'VIOLENCIA SEXUAL', 'I', 'Invasión física de naturaleza sexual o de forma coercitiva sobre una persona, con ocasión y en desarrollo del conflicto armado y/o violencia política y social. Este ítem incluye: acceso carnal violento, actos sexuales violentos, prostitución forzada, desnudo forzado, embarazo forzado, exclavitud sexual, explotación sexual, esterilización forzada, actos abusivos y toda forma de atentado contra el honor y pudor sexual, los cuales, de conocerse, deberán ser indicados en la descripción del caso.', '2016-06-27', '2016-06-27', '2016-06-27', '100'),
    ('3006', 'DESAPARICIÓN FORZADA', 'I', 'Privación de la libertad de persona protegida, cualquiera que sea la forma, seguida de su ocultamiento y de la negativa a reconocer dicha privación o de dar información sobre su paradero, sustrayéndola del amparo de la ley, con ocasión y en desarrollo de conflicto armado y/o violencia política y social.', '2016-06-27', '2016-06-27', '2016-06-27', '100'),
    ('3007', 'DETENCIÓN ARBITRARIA', 'I', 'Privar de la libertad a una o a varias personas por parte de agentes directos o indirectos del Estado, por razones y mediante procedimientos no contemplados en la ley penal.', '2016-06-27', '2016-06-27', '2016-06-27', '100'),
    ('3008', 'DEPORTACIÓN', 'I', 'Es el retorno forzado a su patria, de personas protegidas, ya sean individuos, grupos o grandes contingentes, que afluyen de manera desordenada al territorio de un país vecino con el fin de evitar los riesgos que corren en el país de origen.', '2016-06-27', '2016-06-27', '2016-06-27', '100'),
    ('3509', 'DESPLAZAMIENTO FORZADO', 'O', 'Toda persona que se ha visto forzada a migrar dentro del territorio nacional abandonando su localidad de residencia o actividades económicas habituales, porque su vida, su integridad física, su seguridad o libertad personales han sido vulneradas o se encuentran directamente amenazadas, con ocasión de cualquiera de las siguientes situaciones: Conflicto armado interno, disturbios y tensiones interiores, violencia generalizada, violaciones masivas de los Derechos Humanos, infracciones al Derecho Internacional Humanitario u otras circunstancias emanadas de las situaciones anteriores que puedan alterar o alteren drásticamente el orden público (ley 387 de 1997, Art. 1).  Se entiende como desplazamientos masivos aquellos sucesos que afectan a 50 personas o más, o a 10 familias en adelante.  Se entiende como desplazamientos múltiples aquellos sucesos que afectan ente 15 y 49 personas, o a entre 3 y 9 familias.  (Grupos posdesmovilización y desplazamiento forzado en Colombia: una aproximación cuantitativa , CODHES).  Desplazamiento forzado intraurbano  es una tipología del desplazamiento forzado interno que consiste en la migración forzada de los habitantes de un barrio de una ciudad hacia otro a causa de la presión de grupos armados ilegales que buscan ejercer control territorial y social (Desplazamiento Forzado Intraurbano y soluciones duraderas, CODHES).', '2016-06-27', '2016-06-27', '2016-06-27', '100'),
    ('3010', 'MIGRACIÓN FORZADA INTERNACIONAL', 'I', 'Toda persona que debido a fundados temores de ser perseguida por motivos de raza, religión, nacionalidad, pertenencia a determinado grupo social u opiniones políticas, se encuentre fuera del país de su nacionalidad y no pueda o, a causa de dichos temores, no quiera acogerse a la protección de tal país; o que, careciendo de nacionalidad y hallándose, a consecuencia de tales acontecimientos, fuera del país donde antes tuviera su residencia habitual, no pueda o, a causa de dichos temores, no quiera regresar a él. Se incluyen también toda persona que ha huido de sus país porque su vida, seguridad o libertad han sido amenazadas por la violencia generalizada, la agresión extranjera, los conflictos internos, la violación masiva de los derechos humanos u otras circunstancias que hayan perturbado gravemente el orden público. (Convención sobre el Estatuto de los Refugiados y Declaración de Cartagena)', '2016-06-27', '2016-06-27', '2016-06-27', '100'),
    ('3511', 'CONFINAMIENTO', 'O', 'Es la restricción a la libre movilización de las personas protegidas así como al acceso a bienes indispensables para la supervivencia con ocasión y en desarrollo de conflicto armado y/o violencia politica y social.', '2016-06-27', '2016-06-27', '2016-06-27', '100'),
    ('3012', 'SECUESTRO', 'I', 'Arrebatar, sustraer, retener u ocultar a una persona con ocasión y en desarrollo de conflicto armado y/o la violencia política y social.', '2016-06-27', '2016-06-27', '2016-06-27', '100'),
    ('3013', 'TOMA DE REHENES', 'I', 'Es la privación a una persona de su libertad condicionando ésta o su seguridad a la satisfacción de exigencias formuladas a la otra parte, o la utilice como defensa, con ocasión y en desarrollo de conflicto armado y/o la violencia política y social', '2016-06-27', '2016-06-27', '2016-06-27', '100'),
    ('3514', 'CAMPO MINADO', 'O', 'Es la presencia de Minas  Antipersonal  (MAP),  Municiones  Abandonadas  sin Explotar (MUSE) y Artefactos explosivos Improvisados (AEI) en territorios que afecten o pongan en riesgo la vida e integridad de personas protegidas.', '2016-06-27', '2016-06-27', '2016-06-27', '100'),
    ('3515', 'PILLAJE', 'O', 'Se entenderá como tal, la destrucción o apropiación ilícita, arbitraria, sistemática y violenta con ocasión y desarrollo del conflicto armado y/o violencia politica y social, de bienes de la población civil, o en perjuicio de los heridos, enfermos, náufragos o de las personas privadas de la libertad.', '2016-06-27', '2016-06-27', '2016-06-27', '100'),
    ('3516', 'ATAQUE A MISIÓN MÉDICA, HUMANITARIA O RELIGIOSA', 'O', 'Es cualquier ataque contra: (a) unidades médicas, sanitarias, de primeros auxilios, de socorro a enfermos y heridos y en fin, a cualquier organización permanente o temporal, civil o militar, cuyo propósito sea el de auxiliar, diagnosticar, curar o socorrer a heridos o enfermos, ya sean civiles o militares que se hallen en el lugar de las confrontaciones o el de prevenir enfermedades en estos mismos sitios; (b) integrantes de una misión cuyo propósito sea aliviar la situación de personas protegidas según las normas del DIH, o prevenir males graves que puedan acontecerles a causa de los enfrentamientos armados, mediante diálogos con los actores en conflicto; (c) integrantes de una misión cuyo propósito es la asistencia espiritual y religiosa a quienes están en zona de conflicto armado.', '2016-06-27', '2016-06-27', '2016-06-27', '100'),
    ('3517', 'ATAQUE O USO DE UN BIEN CIVIL', 'O', 'Agresiones graves con ocasión y en desarrollo del conflicto armado y/o violencia política y social, a los bienes que no son objetivos militares. Entre ellos se destacan algunos explícitamente: hospitales, escuelas y canchas, entre otras estructuras públicas y privadas. Incluye también ataque a bienes culturales y religiosos, bienes indispensables para la supervivencia de la población civil y al medio ambiente.', '2016-06-27', '2016-06-27', '2016-06-27', '100'),
    ('3518', 'ATAQUE A OBRAS E INSTALACIONES QUE CONTIENEN FUERZAS PELIGROSAS, ATAQUE A LA ESTRUCTURA VIAL Y/O BLOQUEO DE VÍAS', 'O', 'Consiste en atacar este tipo de infraestructuras con ocasión y en desarrollo del conflicto armado, violencia política y social que afectan a la población civil.', '2016-06-27', '2016-06-27', '2016-06-27', '100'),
    ('3519', 'Utilización de individuos o colectivos como escudo', 'O', 'Utilización de la presencia de personas o comunidades para poner puntos o zonas a cubierto de operaciones militares o para cubrir favorecer u obstaculizar operaciones militares con ocasión y esarrollo del conflicto armado, violencia política y social', '2016-06-27', '2016-06-27', '2016-06-27', '100'),
    ('3020', 'RECLUTAMIENTO DE NNA', 'I', 'Se refiere a la conscripción o alistaiento obligatorio, forzado o voluntario de NNA menores de 18 años a cualquier tipo de grupo a fuerza armada.', '2016-06-27', '2016-06-27', '2016-06-27', '100'),
    ('3021', 'USO DE NNA', 'I', 'Utilización de los NNA para funciones de apoyo, como espías, mensajeros o centinelas, para la comisión de actos ilícitos como microtráfico, extorsión, honicidios, explotación sexual y prostitución forzada, entre otros, por parte de grupos o actores armados con ocasión y en desarrollo del conflicto armado, y /o violencia política o social.', '2016-06-27', '2016-06-27', '2016-06-27', '100'),
    ('3522', 'BOMBARDEOS, AMETRALLAMIENTOS Y EMBOSCADAS', 'O', 'Son métodos de guerra que pueden ser aéreos, terrestres o navales, cuyo propósito es infligir una derrota al adversario,  producir bajas entre sus filas o  impedir el libre tránsito de las tropas enemigas.', '2016-06-27', '2016-06-27', '2016-06-27', '100'),
    ('3523', 'COMBATE', 'O', 'Es el enfrentamiento directo de los adversarios en un tiempo y espacio determinados, con el porte y utilización ostensible de armas y recursos bélicos.', '2016-06-27', '2016-06-27', '2016-06-27', '100'),
    ('3524', 'INCURSIÓN', 'O', 'Operaciones transitorias y de dimensiones limitadas consistentes en una penetración temporal en el territorio controlado por el adversario con el fin de realizar allí acciones de disturbios, de desorganización, de destrucciones o, sencillamente, para llevar a cabo misiones de información.', '2016-06-27', '2016-06-27', '2016-06-27', '100'),
    ('3525', 'ATAQUE A OBJETIVO MILITAR', 'O', 'Son los ataques que se dirigen contra bienes que por su naturaleza, ubicación, finalidad o utilización, contribuyen eficazmente a la acción militar del adversario y cuya destrucción total o parcial, captura o neutralización, ofrecen una ventaja militar definida.', '2016-06-27', '2016-06-27', '2016-06-27', '100'),
    ('3526', 'SABOTAJE', 'O', 'Es un acto de destrucción o causante de daños materiales en obras o instalaciones que por su índole o destinación contribuyen a la eficacia del accionar militar del adversario.', '2016-06-27', '2016-06-27', '2016-06-27', '100'),
    ('3527', 'ERRADICACIÓN MANUAL Y FUMIGACIONES', 'O', 'Actividad desarrollada por organizaciones estatales, con ayuda o no de externos, conducentes a la eliminación de cultivos considerados ilícitos por la normatividad nacional.', '2016-06-27', '2016-06-27', '2016-06-27', '100'),
    ('3528', 'PRESENCIA GUERRILLERA', 'O', 'Permanencia física, militar y/o simbólica de grupos guerrilleros en poblados, veredas, barrios o municipios.', '2016-06-27', '2016-06-27', '2016-06-27', '100'),
    ('3529', 'PRESENCIA PARAMILITAR', 'O', 'Permanencia física, militar y/o simbólica de grupos paramilitares, grupos paramilitares post desmovilización o Grupos Armados Locales en poblados, veredas, barrios o municipios.', '2016-06-27', '2016-06-27', '2016-06-27', '100'),
    ('3530', 'MILITARIZACIÓN', 'O', 'Permanencia exacerbada: física, militar y/ o simbólica de la Fuerza Pública en poblados, veredas, barrios o municipios.', '2016-06-27', '2016-06-27', '2016-06-27', '100'),
    ('3531', 'MEGAPROYECTOS', 'O', 'Son obras de grandes dimensiones que modifican el entorno geográfico, económico, ecológico, cultural y social de los territorios. Algunos ejemplos son los cultivos de palma y las ampliaciones portuarias.', '2016-06-27', '2016-06-27', '2016-06-27', '100'),
    ('3032', 'EXTORSIÓN', 'I', 'Constreñir a otro a hacer, tolerar u omitir alguna cosa, con el propósito de obtener provecho ilícito o cualquier utilidad o beneficio ilícito, para sí o para un tercero. (Ley 733 de 2000).', '2016-06-27', '2016-06-27', '2016-06-27', '100'),
    ('3033', 'DESPOJO DE TIERRAS', 'I', 'Acción por medio de la cual, aprovechándose de la situación de violencia, se priva arbitrariamente a una persona de la propiedad, posesión u ocupación de tierras, ya sea de hecho, mediante negocio jurídico, acto administrativo, sentencia, o mediante la comisión de delitos asociados a la situación de violencia. Incluye también el abandono de tierras, entendido como la situación temporal o permanente a la que se ve abocada una persona forzada a desplazarse, razón por la cual se ve impedida para ejercer la administración, explotación y contacto directo con los predios que debió desatender en su desplazamiento. (Ley 1448 de 2011).', '2016-06-27', '2016-06-27', '2016-06-27', '100')
    SQL
  end

  def down
    execute <<-SQL
    DELETE FROM sivel2_gen_categoria WHERE id>='3000' AND id<='3999';
    SQL
  end
end
