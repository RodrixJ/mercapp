

CREATE TABLE `categorias` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre_categoria` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO categorias VALUES("1","Enfermedades infecciosas y parasitarias");
INSERT INTO categorias VALUES("2","Tumores");
INSERT INTO categorias VALUES("3","Enfermedades de la sangre y de los órganos hematopoyéticos");
INSERT INTO categorias VALUES("4","Enfermedades endocrinas, nutricionales y metabólicas");
INSERT INTO categorias VALUES("5","Trastornos mentales y del comportamiento");
INSERT INTO categorias VALUES("6","Enfermedades del sistema nervioso y órganos de los sentidos");
INSERT INTO categorias VALUES("7","Enfermedades del sistema circulatorio");
INSERT INTO categorias VALUES("8","Enfermedades del sistema respiratorio");
INSERT INTO categorias VALUES("9","Enfermedades del sistema digestivo");
INSERT INTO categorias VALUES("10","Enfermedades de la piel y tejido subcutáneo");
INSERT INTO categorias VALUES("11","Enfermedades del sistema osteomuscular y tejido conjuntivo");
INSERT INTO categorias VALUES("12","Enfermedades del sistema genitourinario");
INSERT INTO categorias VALUES("13","Embarazo, parto y puerperio");
INSERT INTO categorias VALUES("14","Afecciones originadas en el periodo perinatal");
INSERT INTO categorias VALUES("15","Malformaciones congénitas, deformidades y anomalías cromosómicas");
INSERT INTO categorias VALUES("16","Síntomas, signos y hallazgos anormales no clasificados en otra parte");
INSERT INTO categorias VALUES("17","Causas externas de mortalidad");



CREATE TABLE `causas` (
  `id_causa` int NOT NULL AUTO_INCREMENT,
  `codigo` varchar(25) NOT NULL,
  `descripcion` text NOT NULL,
  `categoria_id` int DEFAULT NULL,
  PRIMARY KEY (`id_causa`),
  KEY `categoria_id` (`categoria_id`),
  KEY `codigo` (`codigo`),
  CONSTRAINT `causas_ibfk_1` FOREIGN KEY (`categoria_id`) REFERENCES `categorias` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=99 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO causas VALUES("1","A00-A09","Enfermedades infecciosas intestinales","1");
INSERT INTO causas VALUES("2","A15-A19","Tuberculosis y sus efectos tardíos","1");
INSERT INTO causas VALUES("3","A39","Enfermedad meningocócica","1");
INSERT INTO causas VALUES("4","C00-C14","Tumor maligno del labio, cavidad bucal y faringe","2");
INSERT INTO causas VALUES("5","C15","Tumor maligno del esófago","2");
INSERT INTO causas VALUES("6","D50-D77","Enfermedades de la sangre y órganos hematopoyéticos","3");
INSERT INTO causas VALUES("7","E10-E14","Diabetes mellitus","4");
INSERT INTO causas VALUES("8","F10","Trastornos mentales debidos al uso de alcohol","5");
INSERT INTO causas VALUES("9","G00-G03","Meningitis","6");
INSERT INTO causas VALUES("10","I10-I15","Enfermedades hipertensivas","7");
INSERT INTO causas VALUES("11","J09-J11","Influenza","8");
INSERT INTO causas VALUES("12","K25-K28","Úlcera de estómago, duodeno y yeyuno","9");
INSERT INTO causas VALUES("13","L00-L99","Enfermedades de la piel y tejido subcutáneo","10");
INSERT INTO causas VALUES("14","M05, M06","Artritis reumatoide","11");
INSERT INTO causas VALUES("15","N00-N29","Enfermedades del riñón y uréter","12");
INSERT INTO causas VALUES("16","A40-A41","Septicemia","1");
INSERT INTO causas VALUES("17","B15-B19","Hepatitis vírica","1");
INSERT INTO causas VALUES("18","B20-B24","SIDA","1");
INSERT INTO causas VALUES("19","R75","VIH+ (portador)","1");
INSERT INTO causas VALUES("20","C16","Tumor maligno del estómago","2");
INSERT INTO causas VALUES("21","C18","Tumor maligno del colon","2");
INSERT INTO causas VALUES("22","C19-C21","Tumor maligno del recto, porción rectosigmoide y ano","2");
INSERT INTO causas VALUES("23","C22","Tumor maligno del hígado y vías biliares intrahepáticas","2");
INSERT INTO causas VALUES("24","C25","Tumor maligno del páncreas","2");
INSERT INTO causas VALUES("25","C32","Tumor maligno de la laringe","2");
INSERT INTO causas VALUES("26","C33-C34","Tumor maligno de la tráquea, bronquios y pulmón","2");
INSERT INTO causas VALUES("27","D80-D89","Ciertos trastornos del sistema inmunológico","3");
INSERT INTO causas VALUES("28","E00-E90","Otras enfermedades endocrinas, nutricionales y metabólicas","4");
INSERT INTO causas VALUES("29","F11-F16","Trastornos mentales por drogas","5");
INSERT INTO causas VALUES("30","F18-F19","Trastornos mentales por otras sustancias psicoactivas","5");
INSERT INTO causas VALUES("31","G30","Enfermedad de Alzheimer","6");
INSERT INTO causas VALUES("32","I21","Infarto agudo de miocardio","7");
INSERT INTO causas VALUES("33","I50","Insuficiencia cardíaca","7");
INSERT INTO causas VALUES("34","J12-J18","Neumonía","8");
INSERT INTO causas VALUES("35","J40-J44, J47","Enfermedades crónicas de vías respiratorias inferiores","8");
INSERT INTO causas VALUES("36","J45-J46","Asma","8");
INSERT INTO causas VALUES("37","K50-K52","Enteritis y colitis no infecciosas","9");
INSERT INTO causas VALUES("38","K55","Enfermedad vascular intestinal","9");
INSERT INTO causas VALUES("39","K70, K73, K74","Cirrosis y otras enfermedades crónicas del hígado","9");
INSERT INTO causas VALUES("40","L00-L99","Enfermedades de la piel y del tejido subcutáneo","10");
INSERT INTO causas VALUES("41","M80-M82","Osteoporosis y fractura patológica","11");
INSERT INTO causas VALUES("42","N40-N51","Enfermedades de los órganos genitales masculinos","12");
INSERT INTO causas VALUES("43","O00-O99","Embarazo, parto y puerperio","13");
INSERT INTO causas VALUES("44","P00-P96","Afecciones originadas en el periodo perinatal","14");
INSERT INTO causas VALUES("45","Q00-Q07","Malformaciones congénitas del sistema nervioso","15");
INSERT INTO causas VALUES("46","Q20-Q28","Malformaciones congénitas del sistema circulatorio","15");
INSERT INTO causas VALUES("47","R00-R74, R76-R99","Síntomas y signos anormales no clasificados en otra parte","16");
INSERT INTO causas VALUES("48","V01-Y89","Causas externas de mortalidad","17");
INSERT INTO causas VALUES("49","A00-B99, U04.9, U07.0","Resto de enfermedades infecciosas y parasitarias","1");
INSERT INTO causas VALUES("50","C45.1, C48","Otros tumores malignos digestivos","2");
INSERT INTO causas VALUES("51","C30-C39, C45.0.2","Otros tumores malignos respiratorios e intratorácicos","2");
INSERT INTO causas VALUES("52","C40, C41","Tumores malignos de hueso y cartílagos articulares","2");
INSERT INTO causas VALUES("53","C43","Melanoma maligno de la piel","2");
INSERT INTO causas VALUES("54","C44-C47, C49","Otros tumores malignos de la piel y tejidos blandos","2");
INSERT INTO causas VALUES("55","C50","Tumor maligno de la mama","2");
INSERT INTO causas VALUES("56","C53","Tumor maligno del cuello del útero","2");
INSERT INTO causas VALUES("57","C54, C55","Tumor maligno de otras partes del útero","2");
INSERT INTO causas VALUES("58","C56","Tumor maligno del ovario","2");
INSERT INTO causas VALUES("59","C51-C58","Tumores malignos de otros órganos genitales femeninos","2");
INSERT INTO causas VALUES("60","C61","Tumor maligno de la próstata","2");
INSERT INTO causas VALUES("61","C60-C63","Tumores malignos de otros órganos genitales masculinos","2");
INSERT INTO causas VALUES("62","C64","Tumor maligno del riñón (excepto pelvis renal)","2");
INSERT INTO causas VALUES("63","C67","Tumor maligno de la vejiga","2");
INSERT INTO causas VALUES("64","C64-C68","Otros tumores malignos de las vías urinarias","2");
INSERT INTO causas VALUES("65","C71","Tumor maligno del encéfalo","2");
INSERT INTO causas VALUES("66","C69-C75","Otros tumores malignos neurológicos y endocrinos","2");
INSERT INTO causas VALUES("67","C76, C80","Tumor maligno de sitios mal definidos y secundarios","2");
INSERT INTO causas VALUES("68","C81-C90, C96","Tumores malignos del tejido linfático y órganos hematopoyéticos (excepto leucemia)","2");
INSERT INTO causas VALUES("69","C91-C95","Leucemia","2");
INSERT INTO causas VALUES("70","D00-D09","Tumores in situ","2");
INSERT INTO causas VALUES("71","D10-D36","Tumores benignos","2");
INSERT INTO causas VALUES("72","D46","Síndrome mielodisplásico","2");
INSERT INTO causas VALUES("73","D37-D45, D47, D48","Otros tumores de comportamiento incierto o desconocido","2");
INSERT INTO causas VALUES("74","D50-D77","Enfermedades hematopoyéticas y ciertos trastornos de inmunidad","3");
INSERT INTO causas VALUES("75","E10-E14","Diabetes mellitus","4");
INSERT INTO causas VALUES("76","E00-E90","Otras enfermedades endocrinas, nutricionales y metabólicas","4");
INSERT INTO causas VALUES("77","F00-F09","Trastornos mentales orgánicos, senil y presenil","5");
INSERT INTO causas VALUES("78","F47","Trastornos mentales debidos al uso de alcohol","5");
INSERT INTO causas VALUES("79","F11-F19","Trastornos mentales debidos al uso de drogas","5");
INSERT INTO causas VALUES("80","F00-F99","Otros trastornos mentales y del comportamiento","5");
INSERT INTO causas VALUES("81","G00-G03","Meningitis","6");
INSERT INTO causas VALUES("82","G30","Enfermedad de Alzheimer","6");
INSERT INTO causas VALUES("83","G00-H95","Otras enfermedades del sistema nervioso y órganos de los sentidos","6");
INSERT INTO causas VALUES("84","I00-I02, I26-I49, I51","Otras enfermedades del corazón","7");
INSERT INTO causas VALUES("85","I60-I69","Enfermedades cerebrovasculares","7");
INSERT INTO causas VALUES("86","I70","Aterosclerosis","7");
INSERT INTO causas VALUES("87","I71-I99","Otras enfermedades de los vasos sanguíneos","7");
INSERT INTO causas VALUES("88","J12-J18","Neumonía","8");
INSERT INTO causas VALUES("89","J40-J44, J47","Enfermedades crónicas de las vías respiratorias inferiores (excepto asma)","8");
INSERT INTO causas VALUES("90","J45, J46","Asma","8");
INSERT INTO causas VALUES("91","J96","Insuficiencia respiratoria","8");
INSERT INTO causas VALUES("92","K00-K93","Otras enfermedades del sistema digestivo","9");
INSERT INTO causas VALUES("93","K25-K28","Úlcera de estómago, duodeno y yeyuno","9");
INSERT INTO causas VALUES("94","K50-K52","Enteritis y colitis no infecciosas","9");
INSERT INTO causas VALUES("95","K55","Enfermedad vascular intestinal","9");
INSERT INTO causas VALUES("96","K70, K72.1, K73, K74","Cirrosis y otras enfermedades crónicas del hígado","9");
INSERT INTO causas VALUES("97","K00-K93","Otras enfermedades del sistema digestivo","9");
INSERT INTO causas VALUES("98","X60-X84 ","Agresiones (homicidio)","17");



CREATE TABLE `cementerio` (
  `id_cementerio` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL,
  `latitud` double NOT NULL,
  `longitud` double NOT NULL,
  `capacidad` varchar(30) DEFAULT NULL,
  `tipo` varchar(50) DEFAULT NULL,
  `hora_apertura` time DEFAULT NULL,
  `hora_cierre` time DEFAULT NULL,
  `municipio_id_municipio` int NOT NULL,
  PRIMARY KEY (`id_cementerio`),
  KEY `municipio_id_municipio` (`municipio_id_municipio`),
  CONSTRAINT `cementerio_ibfk_1` FOREIGN KEY (`municipio_id_municipio`) REFERENCES `municipio` (`id_municipio`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO cementerio VALUES("1","Cementerio Municipal de Somoto","13.483401015091644","-86.5864211257641","500","Publico","08:00:00","17:00:00","1");
INSERT INTO cementerio VALUES("2","mausoleos fundadores FSLN","12.156571522653678","-86.2726799545071","300","Privado","08:00:00","17:00:00","51");



CREATE TABLE `defunciones` (
  `id_defuncion` int NOT NULL AUTO_INCREMENT,
  `primer_nombre` varchar(255) NOT NULL,
  `segundo_nombre` varchar(255) DEFAULT NULL,
  `primer_apellido` varchar(255) NOT NULL,
  `segundo_apellido` varchar(255) DEFAULT NULL,
  `cedula` varchar(14) DEFAULT NULL,
  `etnia` varchar(255) DEFAULT NULL,
  `municipio` int DEFAULT NULL,
  `fecha_nacimiento` date DEFAULT NULL,
  `edad_cumplida` int DEFAULT NULL,
  `sexo` enum('Masculino','Femenino') DEFAULT NULL,
  `nacionalidad` enum('Nicaraguense','Extranjero') DEFAULT NULL,
  `estado_civil` enum('Union Libre','Casado','Soltero','Otro') DEFAULT NULL,
  `nombre_conyugue` varchar(200) DEFAULT NULL,
  `ocupacion` varchar(255) DEFAULT NULL,
  `fecha_ocurrencia` date DEFAULT NULL,
  `municipio_ocurrencia` int DEFAULT NULL,
  `hora_defuncion` time DEFAULT NULL,
  `causa_muerte` int DEFAULT NULL,
  PRIMARY KEY (`id_defuncion`),
  UNIQUE KEY `cedula` (`cedula`),
  KEY `municipio` (`municipio`),
  KEY `municipio_ocurrencia` (`municipio_ocurrencia`),
  KEY `causa_muerte` (`causa_muerte`),
  CONSTRAINT `defunciones_ibfk_1` FOREIGN KEY (`municipio`) REFERENCES `municipio` (`id_municipio`),
  CONSTRAINT `defunciones_ibfk_2` FOREIGN KEY (`municipio_ocurrencia`) REFERENCES `municipio` (`id_municipio`),
  CONSTRAINT `defunciones_ibfk_3` FOREIGN KEY (`causa_muerte`) REFERENCES `causas` (`id_causa`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO defunciones VALUES("1","Cesar","Augusto","Salinas","Pinell","32115091949000","Mestizo","1","1949-09-15","26","Masculino","Nicaraguense","Casado","Esmeralda Hernandez","Profesor y Guerrillero del FSLN","1976-06-26","1","12:30:00","98");
INSERT INTO defunciones VALUES("2","Emanuel","Jeremias","Mongalo","Y rubio","321210634000E","Mestizo","108","1834-06-21","37","Masculino","Nicaraguense","Soltero","","Maestro","1872-02-01","100","04:00:00","84");
INSERT INTO defunciones VALUES("3","Jose","Dolores","Estrada","Vado","32116031824000","Mestizo","63","1824-03-16","45","Masculino","Nicaraguense","Soltero","","Heroe nacional Militar","1869-08-12","63","21:00:00","84");
INSERT INTO defunciones VALUES("4","Carlos","Alberto","Fonseca","Amador","32123061936000","Mestizo","39","1936-06-23","40","Masculino","Nicaraguense","Casado","Maria Haydee Teran","político","1976-11-08","39","00:20:00","98");



CREATE TABLE `departamento` (
  `id_departamento` int NOT NULL AUTO_INCREMENT,
  `nombre_departamento` varchar(50) NOT NULL,
  PRIMARY KEY (`id_departamento`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO departamento VALUES("1","Madriz");
INSERT INTO departamento VALUES("2","Nueva Segovia");
INSERT INTO departamento VALUES("3","Estelí");
INSERT INTO departamento VALUES("4","Jinotega");
INSERT INTO departamento VALUES("5","Matagalpa");
INSERT INTO departamento VALUES("6","Managua");
INSERT INTO departamento VALUES("7","León");
INSERT INTO departamento VALUES("8","Chinandega");
INSERT INTO departamento VALUES("9","Masaya");
INSERT INTO departamento VALUES("10","Carazo");
INSERT INTO departamento VALUES("11","Granada");
INSERT INTO departamento VALUES("12","Rivas");
INSERT INTO departamento VALUES("13","Boaco");
INSERT INTO departamento VALUES("14","Chontales");
INSERT INTO departamento VALUES("15","Río San Juan");
INSERT INTO departamento VALUES("16","Costa Caribe Norte");
INSERT INTO departamento VALUES("17","Costa Caribe Sur");



CREATE TABLE `familiar` (
  `id_familiar` int NOT NULL AUTO_INCREMENT,
  `nombre_completo` varchar(255) DEFAULT NULL,
  `sexo` enum('Masculino','Femenino') DEFAULT NULL,
  `correo` varchar(50) DEFAULT NULL,
  `usuario` varchar(255) DEFAULT NULL,
  `familiar_difunto` int DEFAULT NULL,
  PRIMARY KEY (`id_familiar`),
  KEY `familiar_difunto` (`familiar_difunto`),
  CONSTRAINT `familiar_ibfk_1` FOREIGN KEY (`familiar_difunto`) REFERENCES `defunciones` (`id_defuncion`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO familiar VALUES("1","Justo Salinas","Masculino","justo@happymemories.com","justosalinas","1");
INSERT INTO familiar VALUES("2","Bruno Mongalo","Masculino","bruno@happymemories.com","bruno","2");
INSERT INTO familiar VALUES("3","Timoteo Estrada","Masculino","timoteo@happymemories.com","timoteo","3");
INSERT INTO familiar VALUES("4","Fausto Amador","Masculino","fausto@happymemories.com","fausto","4");



CREATE TABLE `galeria` (
  `id_recuerdo` int NOT NULL AUTO_INCREMENT,
  `recurso` varchar(200) DEFAULT NULL,
  `descripcion_recuerdo` text,
  `defuncion_id_defuncion` int DEFAULT NULL,
  PRIMARY KEY (`id_recuerdo`),
  KEY `defuncion_id_defuncion` (`defuncion_id_defuncion`),
  CONSTRAINT `galeria_ibfk_1` FOREIGN KEY (`defuncion_id_defuncion`) REFERENCES `defunciones` (`id_defuncion`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO galeria VALUES("1","182111005.jpg","Augusto en vida","1");
INSERT INTO galeria VALUES("2","1786915737.jpg","protesta que se realiza cuando lo mataron","1");



CREATE TABLE `municipio` (
  `id_municipio` int NOT NULL AUTO_INCREMENT,
  `nombre_municipio` varchar(70) NOT NULL,
  `departamento_id_departamento` int DEFAULT NULL,
  PRIMARY KEY (`id_municipio`),
  KEY `departamento_id_departamento` (`departamento_id_departamento`),
  CONSTRAINT `municipio_ibfk_1` FOREIGN KEY (`departamento_id_departamento`) REFERENCES `departamento` (`id_departamento`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=154 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO municipio VALUES("1","Somoto","1");
INSERT INTO municipio VALUES("2","San Juan del Río Coco","1");
INSERT INTO municipio VALUES("3","San José de Cusmapa","1");
INSERT INTO municipio VALUES("4","Las Sabanas","1");
INSERT INTO municipio VALUES("5","San Lucas","1");
INSERT INTO municipio VALUES("6","Yalagüina","1");
INSERT INTO municipio VALUES("7","Palacagüina","1");
INSERT INTO municipio VALUES("8","Totogalpa","1");
INSERT INTO municipio VALUES("9","Telpaneca","1");
INSERT INTO municipio VALUES("10","Ciudad Antigua","2");
INSERT INTO municipio VALUES("11","Dipilto","2");
INSERT INTO municipio VALUES("12","El Jícaro","2");
INSERT INTO municipio VALUES("13","Jalapa","2");
INSERT INTO municipio VALUES("14","Macuelizo","2");
INSERT INTO municipio VALUES("15","Mozonte","2");
INSERT INTO municipio VALUES("16","Murra","2");
INSERT INTO municipio VALUES("17","Ocotal","2");
INSERT INTO municipio VALUES("18","Quilalí","2");
INSERT INTO municipio VALUES("19","San Fernando","2");
INSERT INTO municipio VALUES("20","Santa María","2");
INSERT INTO municipio VALUES("21","Wiwilí","2");
INSERT INTO municipio VALUES("22","Condega","3");
INSERT INTO municipio VALUES("23","Estelí","3");
INSERT INTO municipio VALUES("24","La Trinidad","3");
INSERT INTO municipio VALUES("25","Pueblo Nuevo","3");
INSERT INTO municipio VALUES("26","San Juan de Limay","3");
INSERT INTO municipio VALUES("27","San Nicolás","3");
INSERT INTO municipio VALUES("28","El Cuá","4");
INSERT INTO municipio VALUES("29","Jinotega","4");
INSERT INTO municipio VALUES("30","La Concordia","4");
INSERT INTO municipio VALUES("31","San José de Bocay","4");
INSERT INTO municipio VALUES("32","San Rafael del Norte","4");
INSERT INTO municipio VALUES("33","San Sebastián de Yalí","4");
INSERT INTO municipio VALUES("34","Santa María de Pantasma","4");
INSERT INTO municipio VALUES("35","Wiwilí de Jinotega","4");
INSERT INTO municipio VALUES("36","Ciudad Darío","5");
INSERT INTO municipio VALUES("37","El Tuma La Dalia","5");
INSERT INTO municipio VALUES("38","Esquipulas","5");
INSERT INTO municipio VALUES("39","Matagalpa","5");
INSERT INTO municipio VALUES("40","Matiguás","5");
INSERT INTO municipio VALUES("41","Muy Muy","5");
INSERT INTO municipio VALUES("42","Rancho Grande","5");
INSERT INTO municipio VALUES("43","Río Blanco","5");
INSERT INTO municipio VALUES("44","San Dionisio","5");
INSERT INTO municipio VALUES("45","San Isidro","5");
INSERT INTO municipio VALUES("46","San Ramón","5");
INSERT INTO municipio VALUES("47","Sébaco","5");
INSERT INTO municipio VALUES("48","Terrabona","5");
INSERT INTO municipio VALUES("49","Ciudad Sandino","6");
INSERT INTO municipio VALUES("50","El Crucero","6");
INSERT INTO municipio VALUES("51","Managua","6");
INSERT INTO municipio VALUES("52","Mateare","6");
INSERT INTO municipio VALUES("53","San Francisco Libre","6");
INSERT INTO municipio VALUES("54","San Rafael del Sur","6");
INSERT INTO municipio VALUES("55","Ticuantepe","6");
INSERT INTO municipio VALUES("56","Tipitapa","6");
INSERT INTO municipio VALUES("57","Villa Carlos Fonseca","6");
INSERT INTO municipio VALUES("58","Achuapa","7");
INSERT INTO municipio VALUES("59","El Jicaral","7");
INSERT INTO municipio VALUES("60","El Sauce","7");
INSERT INTO municipio VALUES("61","La Paz Centro","7");
INSERT INTO municipio VALUES("62","Larreynaga","7");
INSERT INTO municipio VALUES("63","León","7");
INSERT INTO municipio VALUES("64","Nagarote","7");
INSERT INTO municipio VALUES("65","Quezalguaque","7");
INSERT INTO municipio VALUES("66","Santa Rosa del Peñón","7");
INSERT INTO municipio VALUES("67","Telica","7");
INSERT INTO municipio VALUES("68","Chichigalpa","8");
INSERT INTO municipio VALUES("69","Chinandega","8");
INSERT INTO municipio VALUES("70","Cinco Pinos","8");
INSERT INTO municipio VALUES("71","Corinto","8");
INSERT INTO municipio VALUES("72","El Realejo","8");
INSERT INTO municipio VALUES("73","El Viejo","8");
INSERT INTO municipio VALUES("74","Posoltega","8");
INSERT INTO municipio VALUES("75","Puerto Morazán","8");
INSERT INTO municipio VALUES("76","San Francisco del Norte","8");
INSERT INTO municipio VALUES("77","San Pedro del Norte","8");
INSERT INTO municipio VALUES("78","Santo Tomás del Norte","8");
INSERT INTO municipio VALUES("79","Somotillo","8");
INSERT INTO municipio VALUES("80","Villa Nueva","8");
INSERT INTO municipio VALUES("81","Catarina","9");
INSERT INTO municipio VALUES("82","La Concepción","9");
INSERT INTO municipio VALUES("83","Masatepe","9");
INSERT INTO municipio VALUES("84","Masaya","9");
INSERT INTO municipio VALUES("85","Nandasmo","9");
INSERT INTO municipio VALUES("86","Nindirí","9");
INSERT INTO municipio VALUES("87","Niquinohomo","9");
INSERT INTO municipio VALUES("88","San Juan de Oriente","9");
INSERT INTO municipio VALUES("89","Tisma","9");
INSERT INTO municipio VALUES("90","Diriamba","10");
INSERT INTO municipio VALUES("91","Dolores","10");
INSERT INTO municipio VALUES("92","El Rosario","10");
INSERT INTO municipio VALUES("93","Jinotepe","10");
INSERT INTO municipio VALUES("94","La Conquista","10");
INSERT INTO municipio VALUES("95","La Paz de Oriente","10");
INSERT INTO municipio VALUES("96","San Marcos","10");
INSERT INTO municipio VALUES("97","Santa Teresa","10");
INSERT INTO municipio VALUES("98","Diriá","11");
INSERT INTO municipio VALUES("99","Diriomo","11");
INSERT INTO municipio VALUES("100","Granada","11");
INSERT INTO municipio VALUES("101","Nandaime","11");
INSERT INTO municipio VALUES("102","Altagracia","12");
INSERT INTO municipio VALUES("103","Belén","12");
INSERT INTO municipio VALUES("104","Buenos Aires","12");
INSERT INTO municipio VALUES("105","Cárdenas","12");
INSERT INTO municipio VALUES("106","Moyogalpa","12");
INSERT INTO municipio VALUES("107","Potosí","12");
INSERT INTO municipio VALUES("108","Rivas","12");
INSERT INTO municipio VALUES("109","San Jorge","12");
INSERT INTO municipio VALUES("110","San Juan del Sur","12");
INSERT INTO municipio VALUES("111","Tola","12");
INSERT INTO municipio VALUES("112","Boaco","13");
INSERT INTO municipio VALUES("113","Camoapa","13");
INSERT INTO municipio VALUES("114","San José de los Remates","13");
INSERT INTO municipio VALUES("115","San Lorenzo","13");
INSERT INTO municipio VALUES("116","Santa Lucía","13");
INSERT INTO municipio VALUES("117","Teustepe","13");
INSERT INTO municipio VALUES("118","Acoyapa","14");
INSERT INTO municipio VALUES("119","Comalapa","14");
INSERT INTO municipio VALUES("120","Cuapa","14");
INSERT INTO municipio VALUES("121","El Coral","14");
INSERT INTO municipio VALUES("122","Juigalpa","14");
INSERT INTO municipio VALUES("123","La Libertad","14");
INSERT INTO municipio VALUES("124","San Pedro de Lóvago","14");
INSERT INTO municipio VALUES("125","Santo Domingo","14");
INSERT INTO municipio VALUES("126","Santo Tomás","14");
INSERT INTO municipio VALUES("127","Villa Sandino","14");
INSERT INTO municipio VALUES("128","El Almendro","15");
INSERT INTO municipio VALUES("129","El Castillo","15");
INSERT INTO municipio VALUES("130","Morrito","15");
INSERT INTO municipio VALUES("131","San Carlos","15");
INSERT INTO municipio VALUES("132","San Juan del Norte","15");
INSERT INTO municipio VALUES("133","San Miguelito","15");
INSERT INTO municipio VALUES("134","Bonanza","16");
INSERT INTO municipio VALUES("135","Mulukukú","16");
INSERT INTO municipio VALUES("136","Prinzapolka","16");
INSERT INTO municipio VALUES("137","Puerto Cabezas","16");
INSERT INTO municipio VALUES("138","Rosita","16");
INSERT INTO municipio VALUES("139","Siuna","16");
INSERT INTO municipio VALUES("140","Waslala","16");
INSERT INTO municipio VALUES("141","Waspán","16");
INSERT INTO municipio VALUES("142","Bluefields","17");
INSERT INTO municipio VALUES("143","Corn Island","17");
INSERT INTO municipio VALUES("144","Desembocadura del Río Grande","17");
INSERT INTO municipio VALUES("145","El Ayote","17");
INSERT INTO municipio VALUES("146","El Rama","17");
INSERT INTO municipio VALUES("147","El Tortuguero","17");
INSERT INTO municipio VALUES("148","Kukra Hill","17");
INSERT INTO municipio VALUES("149","La Cruz Río Grande","17");
INSERT INTO municipio VALUES("150","Laguna de Perlas","17");
INSERT INTO municipio VALUES("151","Muelle de los Bueyes","17");
INSERT INTO municipio VALUES("152","Nueva Guinea","17");
INSERT INTO municipio VALUES("153","Paiwas","17");



CREATE TABLE `operarios` (
  `id_operario` int NOT NULL AUTO_INCREMENT,
  `nombre_completo` varchar(255) NOT NULL,
  `telefono` varchar(20) NOT NULL,
  `direccion` varchar(255) NOT NULL,
  `estado` enum('Activo','Inactivo') DEFAULT 'Activo',
  `especialidad` varchar(255) DEFAULT NULL,
  `imagenOperario` varchar(50) DEFAULT NULL,
  `cementerio_id_cementerio` int DEFAULT NULL,
  PRIMARY KEY (`id_operario`),
  KEY `cementerio_id_cementerio` (`cementerio_id_cementerio`),
  CONSTRAINT `operarios_ibfk_1` FOREIGN KEY (`cementerio_id_cementerio`) REFERENCES `cementerio` (`id_cementerio`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO operarios VALUES("3","Mechito","88888888","sector #16","Activo","Conserje","703822408.jpg","1");



CREATE TABLE `proveedor_servicio` (
  `id_proveedor` int NOT NULL AUTO_INCREMENT,
  `operario_id_operario` int DEFAULT NULL,
  `servicio_id_servicio` int DEFAULT NULL,
  PRIMARY KEY (`id_proveedor`),
  KEY `operario_id_operario` (`operario_id_operario`),
  KEY `servicio_id_servicio` (`servicio_id_servicio`),
  CONSTRAINT `proveedor_servicio_ibfk_1` FOREIGN KEY (`operario_id_operario`) REFERENCES `operarios` (`id_operario`),
  CONSTRAINT `proveedor_servicio_ibfk_2` FOREIGN KEY (`servicio_id_servicio`) REFERENCES `servicio` (`id_servicio`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;




CREATE TABLE `servicio` (
  `id_servicio` int NOT NULL AUTO_INCREMENT,
  `tipo_servicio` varchar(100) NOT NULL,
  `descripcion` text,
  `precio` float NOT NULL,
  `imagen` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id_servicio`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO servicio VALUES("1","Limpieza","Limpieza profunda de la tumba, eliminando suciedad y maleza.","50","limpieza.jpg");
INSERT INTO servicio VALUES("2","Reparación","Reparación de lápidas y estructuras de la tumba.","150","reparacion.jpg");
INSERT INTO servicio VALUES("3","Pintura","Pintura de lápidas y ornamentaciones.","100","pintura");
INSERT INTO servicio VALUES("4","Mantenimiento General","Mantenimiento regular, incluyendo limpieza y revisión de estructuras.","75","mantenimiento");
INSERT INTO servicio VALUES("5","Otro","Servicio personalizado según las necesidades del cliente.","200","otros");
INSERT INTO servicio VALUES("6","Monumento Personalizado","Diseño y creación de monumentos personalizados.","300","personalizado.jpg");
INSERT INTO servicio VALUES("7","Floristería","Entrega de flores frescas o artificiales para adornar tumbas.","40","floristeria.jpg");
INSERT INTO servicio VALUES("8","Servicios de Grabado","Grabado de nombres y fechas en lápidas.","100","grabado.jpg");
INSERT INTO servicio VALUES("9","Mantenimiento de Jardines","Cuidado de áreas verdes alrededor de tumbas.","60","flor.jpg");



CREATE TABLE `servicio_mantenimiento` (
  `id_mantenimiento` int NOT NULL AUTO_INCREMENT,
  `ubicacion_descanso_id` int NOT NULL,
  `servicio_id_servicio` int NOT NULL,
  `fecha_servicio` date NOT NULL,
  `estado` enum('Completado','Pendiente','Cancelado') NOT NULL,
  `observaciones` text,
  PRIMARY KEY (`id_mantenimiento`),
  KEY `ubicacion_descanso_id` (`ubicacion_descanso_id`),
  KEY `servicio_id_servicio` (`servicio_id_servicio`),
  CONSTRAINT `servicio_mantenimiento_ibfk_1` FOREIGN KEY (`ubicacion_descanso_id`) REFERENCES `ubicacion_descanso` (`id_ubicacion`),
  CONSTRAINT `servicio_mantenimiento_ibfk_2` FOREIGN KEY (`servicio_id_servicio`) REFERENCES `servicio` (`id_servicio`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO servicio_mantenimiento VALUES("7","3","1","2024-10-20","Cancelado","tambien que aprovecha a barrer");



CREATE TABLE `ubicacion_descanso` (
  `id_ubicacion` int NOT NULL AUTO_INCREMENT,
  `latitud` double DEFAULT NULL,
  `longitud` double DEFAULT NULL,
  `descripcion_lugar` varchar(150) DEFAULT NULL,
  `defuncion_id_defuncion` int NOT NULL,
  `cementerio_id_cementerio` int NOT NULL,
  `imagen_descanso` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id_ubicacion`),
  KEY `defuncion_id_defuncion` (`defuncion_id_defuncion`),
  KEY `cementerio_id_cementerio` (`cementerio_id_cementerio`),
  CONSTRAINT `ubicacion_descanso_ibfk_1` FOREIGN KEY (`defuncion_id_defuncion`) REFERENCES `defunciones` (`id_defuncion`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `ubicacion_descanso_ibfk_2` FOREIGN KEY (`cementerio_id_cementerio`) REFERENCES `cementerio` (`id_cementerio`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO ubicacion_descanso VALUES("3","13.483675347286194","-86.5858912345425","prueba de actualizacion","1","1","1981037115.jpeg");
INSERT INTO ubicacion_descanso VALUES("4","12.156658575111726","-86.27264072127882","Monumento de uno de los fundadores del frente","4","2","872585122.jpg");



CREATE TABLE `usuario` (
  `id_usuario` int NOT NULL AUTO_INCREMENT,
  `nombre_usuario` varchar(45) NOT NULL,
  `clave` varchar(255) NOT NULL,
  `rol` varchar(255) NOT NULL,
  PRIMARY KEY (`id_usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO usuario VALUES("1","admin","$2y$10$bwqJzNwo7MsGxSI6Sy6.tOmRb4QExFuSXJSt9RDwgKTopEvozg45y","administrador");
INSERT INTO usuario VALUES("2","justosalinas","$2y$10$.wPwtS73cXrnng1dv1YJCulxQuxshKAHwu4E.xuuZB/VLGRvnbfAa","familiar");
INSERT INTO usuario VALUES("3","bruno","$2y$10$HEIJ7ZDhNTQcYyyr2Q1uqO85fwIcjq/.btYeFxkCrJSmoGZ8JgeGe","familiar");
INSERT INTO usuario VALUES("8","timoteo","$2y$10$RJ/nkcJG7WPav8NNvSHU7.HQJ.CdF8h.QcI7kNNpXd1xxGY1B69K.","familiar");
INSERT INTO usuario VALUES("9","fausto","$2y$10$YR5oLvj0OZpDGDRpn3dlve/7g0OzZ5b8K9DB85mKhGHrssqRk9Fn.","familiar");
INSERT INTO usuario VALUES("11","mechito","$2y$10$oBD5frTCHTkoJH9YA3vxAu3K71M7VGYaqqMyFgXyQQw3ebh0weyWG","operario");

