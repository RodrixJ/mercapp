create database memorialdb;
use memorialdb;


 -- Tabla Usuario
CREATE TABLE usuario(
    id_usuario INT PRIMARY KEY AUTO_INCREMENT,
    nombre_usuario VARCHAR (45) NOT NULL,
    clave VARCHAR (255) NOT NULL,
    rol VARCHAR (255) NOT NULL
)ENGINE=InnoDB;
 
 -- Tabla departamento
 create table departamento(
 id_departamento int auto_increment primary key,
 nombre_departamento varchar(50) NOT NULL
 )engine=InnoDB;


 -- Tabla municipio
 create table municipio(
 id_municipio int auto_increment primary key,
 nombre_municipio varchar(70) NOT NULL,
 departamento_id_departamento int,
 foreign key(departamento_id_departamento)references departamento(id_departamento) on delete set null on update cascade
 )engine=InnoDB;

 -- Tabla categorias
 CREATE TABLE  categorias (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre_categoria VARCHAR(255) NOT NULL
)engine=InnoDB;

 -- Tabla causas
CREATE TABLE causas (
    id_causa INT AUTO_INCREMENT PRIMARY KEY,
    codigo VARCHAR(25) NOT NULL,    -- Código CIE-10
    descripcion TEXT NOT NULL,      -- Descripción de la enfermedad
    categoria_id INT,               -- Llave foránea a la tabla de categorías
    FOREIGN KEY (categoria_id) REFERENCES categorias(id) ON DELETE CASCADE,
    INDEX (codigo)
)engine=InnoDB;

 -- Tabla cementerio
create table cementerio(
 id_cementerio int auto_increment primary key,
 nombre varchar(50)  NOT NULL,
 latitud double NOT NULL,
 longitud double NOT NULL,
 capacidad varchar(30),
 tipo varchar(50),
 hora_apertura time,
 hora_cierre time,
 municipio_id_municipio int NOT NULL,
 foreign key (municipio_id_municipio) references municipio(id_municipio)
 )engine=InnoDB;


 -- Tabla defunciones
CREATE TABLE defunciones (
  id_defuncion INT AUTO_INCREMENT PRIMARY KEY,
  
  -- A. DATOS DEL FALLECIDO
  primer_nombre VARCHAR(255) NOT NULL,
  segundo_nombre VARCHAR(255),
  primer_apellido VARCHAR(255) NOT NULL,
  segundo_apellido VARCHAR(255),
  cedula VARCHAR(14) UNIQUE ,
  etnia VARCHAR(255),
  
  -- RESIDENCIA HABITUAL
  municipio INT,
  fecha_nacimiento DATE,
  edad_cumplida INT,
  sexo ENUM('Masculino', 'Femenino'),
  nacionalidad ENUM('Nicaraguense', 'Extranjero'),
  estado_civil ENUM('Union Libre', 'Casado', 'Soltero', 'Otro'),
  nombre_conyugue VARCHAR(200),
  ocupacion VARCHAR(255),
  
  -- B. DATOS DE LA DEFUNCIÓN
  fecha_ocurrencia DATE,
  municipio_ocurrencia INT,
  hora_defuncion TIME,
  
  -- C. CAUSAS DE LA DEFUNCIÓN
  causa_muerte INT,
  
  FOREIGN KEY (municipio) REFERENCES municipio(id_municipio),
  FOREIGN KEY (municipio_ocurrencia) REFERENCES municipio(id_municipio),
  FOREIGN KEY (causa_muerte) REFERENCES causas(id_causa)
)engine=InnoDB;

 -- Tabla familiar
 create table familiar(
   -- DATOS DEL Familiar
	id_familiar int primary key auto_increment,
  nombre_completo VARCHAR(255),
  sexo ENUM('Masculino', 'Femenino'),
  correo varchar(50),
  usuario VARCHAR(255),
  familiar_difunto int,
    FOREIGN KEY (familiar_difunto) REFERENCES defunciones(id_defuncion)
 )engine=InnoDB;



 -- Tabla ubicacion descando
create table ubicacion_descanso (
id_ubicacion int auto_increment primary key, 
latitud double,
longitud double,
descripcion_lugar varchar(150),
defuncion_id_defuncion int not null,
cementerio_id_cementerio int not null,
imagen_descanso varchar(30),
 foreign key(defuncion_id_defuncion)references defunciones(id_defuncion) on delete cascade on update restrict,
 foreign key(cementerio_id_cementerio)references cementerio(id_cementerio) on delete cascade on update restrict
 )engine=InnoDB;
 
 select * from defunciones inner join ubicacion_descanso on id_defuncion=defuncion_id_defuncion  where id_defuncion=1;

SELECT *FROM ubicacion_descanso;

SELECT 
    d.*
    FROM 
    defunciones d
   
    LEFT JOIN 
    ubicacion_descanso u ON d.id_defuncion = u.defuncion_id_defuncion
    WHERE 
    u.defuncion_id_defuncion IS NULL;
    
    SELECT 
        d.*,u.*
        FROM 
        ubicacion_descanso u
        Inner JOIN 
        defunciones d ON d.id_defuncion = u.defuncion_id_defuncion;

  -- Tabla ubicacion galeria
 create table galeria(
 id_recuerdo int auto_increment primary key,
 recurso varchar(200),
 descripcion_recuerdo text,
 defuncion_id_defuncion int,
  foreign key(defuncion_id_defuncion)references defunciones(id_defuncion) on delete cascade
 )engine=InnoDB;

CREATE TABLE servicio (
    id_servicio INT AUTO_INCREMENT PRIMARY KEY,
    tipo_servicio varchar(100) NOT NULL,
    descripcion TEXT,
    precio float not null,
    imagen varchar(50)
) ENGINE=InnoDB;


CREATE TABLE operarios (
    id_operario INT AUTO_INCREMENT PRIMARY KEY,
    nombre_completo VARCHAR(255) NOT NULL,
    telefono VARCHAR(20) NOT NULL,
    direccion VARCHAR(255) NOT NULL,
    estado ENUM('Activo', 'Inactivo') DEFAULT 'Activo',
    especialidad VARCHAR(255), -- EJM Limpieza, Reparación, etc.
    imagenOperario varchar(50), -- Foto de el operario,
    cementerio_id_cementerio int, -- llave foranea de relacion del cementerio con el operario
    FOREIGN KEY (cementerio_id_cementerio) REFERENCES cementerio(id_cementerio) ON DELETE SET NULL
) ENGINE=InnoDB;

select *from operarios;

-- proveedor servicios PENDIENTE
CREATE TABLE proveedor_servicio (
    id_proveedor INT AUTO_INCREMENT PRIMARY KEY,
    operario_id_operario int,
    servicio_id_servicio int,
    FOREIGN KEY (operario_id_operario) REFERENCES operarios(id_operario),
    FOREIGN KEY (servicio_id_servicio) REFERENCES servicio(id_servicio)
) ENGINE=InnoDB;

select *from proveedor_servicio inner join operarios on operario_id_operario=id_operario inner join servicio on servicio_id_servicio=id_servicio;

CREATE TABLE servicio_mantenimiento (
    id_mantenimiento INT AUTO_INCREMENT PRIMARY KEY,
    ubicacion_descanso_id INT NOT NULL, -- Llave foránea a la tabla ubicacion_descanso
    servicio_id_servicio INT NOT NULL,           -- Llave foránea a la tabla proveedor_servicio
    fecha_servicio DATE NOT NULL,
    estado ENUM('Completado', 'Pendiente', 'Cancelado') NOT NULL,
    observaciones TEXT,
    FOREIGN KEY (ubicacion_descanso_id) REFERENCES ubicacion_descanso(id_ubicacion) ,
    FOREIGN KEY (servicio_id_servicio) REFERENCES servicio(id_servicio)
) ENGINE=InnoDB;

select *from servicio_mantenimiento inner join ubicacion_descanso on id_ubicacion=ubicacion_descanso_id inner join servicio on id_servicio=servicio_id_servicio;

select *from servicio_mantenimiento inner join ubicacion_descanso on id_ubicacion=ubicacion_descanso_id ;


INSERT INTO servicio (tipo_servicio, descripcion, precio) VALUES 
('Limpieza', 'Limpieza profunda de la tumba, eliminando suciedad y maleza.', 50.00),
('Reparación', 'Reparación de lápidas y estructuras de la tumba.', 150.00),
('Pintura', 'Pintura de lápidas y ornamentaciones.', 100.00),
('Mantenimiento General', 'Mantenimiento regular, incluyendo limpieza y revisión de estructuras.', 75.00),
('Otro', 'Servicio personalizado según las necesidades del cliente.', 200.00);

INSERT INTO servicio (tipo_servicio, descripcion, precio) VALUES 
('Monumento Personalizado', 'Diseño y creación de monumentos personalizados.', 300.00),
('Floristería', 'Entrega de flores frescas o artificiales para adornar tumbas.', 40.00),
('Servicios de Grabado', 'Grabado de nombres y fechas en lápidas.', 100.00),
('Mantenimiento de Jardines', 'Cuidado de áreas verdes alrededor de tumbas.', 60.00);


 




-- ######### CONSULTAS ###############
-- Consulta para agregar todos los DEPARTAMENTOS
 INSERT INTO departamento (nombre_departamento) VALUES ("Madriz"), ("Nueva Segovia"), ("Estelí"), ("Jinotega"), ("Matagalpa"), ("Managua"), 
 ("León"), ("Chinandega"), ("Masaya"), ("Carazo"), ("Granada"), ("Rivas"), ("Boaco"), ("Chontales"), ("Río San Juan"), ("Costa Caribe Norte"), ("Costa Caribe Sur");
 
 -- Procedimiento de Almacenado para agregar MUNICIPIO a los DEPARTAMENTOS
 DELIMITER //
CREATE PROCEDURE ingresarMunicipios(
    IN municipio VARCHAR(50),
    IN deptoNombre VARCHAR(255)
)
BEGIN
    DECLARE deptoId INT;

    -- Obtener el id del departamento basado en su nombre
    SELECT id_departamento INTO deptoId
    FROM departamento
    WHERE nombre_departamento = deptoNombre;
    
    -- Inserta los municipios, si el departamento existe
    IF deptoId IS NOT NULL THEN
        INSERT INTO municipio (nombre_municipio, departamento_id_departamento) VALUES (municipio, deptoId);
    ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Departamento no encontrado';
    END IF;
END //
DELIMITER ;

-- Agregando los municipios de MADRIZ
CALL ingresarMunicipios ('Somoto', 'Madriz');
CALL ingresarMunicipios ('San Juan del Río Coco', 'Madriz');
CALL ingresarMunicipios ('San José de Cusmapa', 'Madriz');
CALL ingresarMunicipios ('Las Sabanas', 'Madriz');
CALL ingresarMunicipios ('San Lucas', 'Madriz');
CALL ingresarMunicipios ('Yalagüina', 'Madriz');
CALL ingresarMunicipios ('Palacagüina', 'Madriz');
CALL ingresarMunicipios ('Totogalpa', 'Madriz');
CALL ingresarMunicipios ('Telpaneca', 'Madriz');

-- Agregando los municipios de NUEVA SEGOVIA
CALL ingresarMunicipios ('Ciudad Antigua', 'Nueva Segovia');
CALL ingresarMunicipios ('Dipilto', 'Nueva Segovia');
CALL ingresarMunicipios ('El Jícaro', 'Nueva Segovia');
CALL ingresarMunicipios ('Jalapa', 'Nueva Segovia');
CALL ingresarMunicipios ('Macuelizo', 'Nueva Segovia');
CALL ingresarMunicipios ('Mozonte', 'Nueva Segovia');
CALL ingresarMunicipios ('Murra', 'Nueva Segovia');
CALL ingresarMunicipios ('Ocotal', 'Nueva Segovia');
CALL ingresarMunicipios ('Quilalí', 'Nueva Segovia');
CALL ingresarMunicipios ('San Fernando', 'Nueva Segovia');
CALL ingresarMunicipios ('Santa María', 'Nueva Segovia');
CALL ingresarMunicipios ('Wiwilí', 'Nueva Segovia');

-- Agregando los municipios de ESTELÍ
CALL ingresarMunicipios ('Condega', 'Estelí');
CALL ingresarMunicipios ('Estelí', 'Estelí');
CALL ingresarMunicipios ('La Trinidad', 'Estelí');
CALL ingresarMunicipios ('Pueblo Nuevo', 'Estelí');
CALL ingresarMunicipios ('San Juan de Limay', 'Estelí');
CALL ingresarMunicipios ('San Nicolás', 'Estelí');

-- Agregando los municipios de JINOTEGA
CALL ingresarMunicipios ('El Cuá', 'Jinotega');
CALL ingresarMunicipios ('Jinotega', 'Jinotega');
CALL ingresarMunicipios ('La Concordia', 'Jinotega');
CALL ingresarMunicipios ('San José de Bocay', 'Jinotega');
CALL ingresarMunicipios ('San Rafael del Norte', 'Jinotega');
CALL ingresarMunicipios ('San Sebastián de Yalí', 'Jinotega');
CALL ingresarMunicipios ('Santa María de Pantasma', 'Jinotega');
CALL ingresarMunicipios ('Wiwilí de Jinotega', 'Jinotega');

-- Agregando los municipios de MATAGALPA
CALL ingresarMunicipios ('Ciudad Darío', 'Matagalpa');
CALL ingresarMunicipios ('El Tuma La Dalia', 'Matagalpa');
CALL ingresarMunicipios ('Esquipulas', 'Matagalpa');
CALL ingresarMunicipios ('Matagalpa', 'Matagalpa');
CALL ingresarMunicipios ('Matiguás', 'Matagalpa');
CALL ingresarMunicipios ('Muy Muy', 'Matagalpa');
CALL ingresarMunicipios ('Rancho Grande', 'Matagalpa');
CALL ingresarMunicipios ('Río Blanco', 'Matagalpa');
CALL ingresarMunicipios ('San Dionisio', 'Matagalpa');
CALL ingresarMunicipios ('San Isidro', 'Matagalpa');
CALL ingresarMunicipios ('San Ramón', 'Matagalpa');
CALL ingresarMunicipios ('Sébaco', 'Matagalpa');
CALL ingresarMunicipios ('Terrabona', 'Matagalpa');

-- Agregando los municipios de MANAGUA
CALL ingresarMunicipios ('Ciudad Sandino', 'Managua');
CALL ingresarMunicipios ('El Crucero', 'Managua');
CALL ingresarMunicipios ('Managua', 'Managua');
CALL ingresarMunicipios ('Mateare', 'Managua');
CALL ingresarMunicipios ('San Francisco Libre', 'Managua');
CALL ingresarMunicipios ('San Rafael del Sur', 'Managua');
CALL ingresarMunicipios ('Ticuantepe', 'Managua');
CALL ingresarMunicipios ('Tipitapa', 'Managua');
CALL ingresarMunicipios ('Villa Carlos Fonseca', 'Managua');

-- Agregando los municipios de LEÓN
CALL ingresarMunicipios ('Achuapa', 'León');
CALL ingresarMunicipios ('El Jicaral', 'León');
CALL ingresarMunicipios ('El Sauce', 'León');
CALL ingresarMunicipios ('La Paz Centro', 'León');
CALL ingresarMunicipios ('Larreynaga', 'León');
CALL ingresarMunicipios ('León', 'León');
CALL ingresarMunicipios ('Nagarote', 'León');
CALL ingresarMunicipios ('Quezalguaque', 'León');
CALL ingresarMunicipios ('Santa Rosa del Peñón', 'León');
CALL ingresarMunicipios ('Telica', 'León');

-- Agregando los municipios de CHINANDEGA
CALL ingresarMunicipios ('Chichigalpa', 'Chinandega');
CALL ingresarMunicipios ('Chinandega', 'Chinandega');
CALL ingresarMunicipios ('Cinco Pinos', 'Chinandega');
CALL ingresarMunicipios ('Corinto', 'Chinandega');
CALL ingresarMunicipios ('El Realejo', 'Chinandega');
CALL ingresarMunicipios ('El Viejo', 'Chinandega');
CALL ingresarMunicipios ('Posoltega', 'Chinandega');
CALL ingresarMunicipios ('Puerto Morazán', 'Chinandega');
CALL ingresarMunicipios ('San Francisco del Norte', 'Chinandega');
CALL ingresarMunicipios ('San Pedro del Norte', 'Chinandega');
CALL ingresarMunicipios ('Santo Tomás del Norte', 'Chinandega');
CALL ingresarMunicipios ('Somotillo', 'Chinandega');
CALL ingresarMunicipios ('Villa Nueva', 'Chinandega');

-- Agregando los municipios de MASAYA
CALL ingresarMunicipios ('Catarina', 'Masaya');
CALL ingresarMunicipios ('La Concepción', 'Masaya');
CALL ingresarMunicipios ('Masatepe', 'Masaya');
CALL ingresarMunicipios ('Masaya', 'Masaya');
CALL ingresarMunicipios ('Nandasmo', 'Masaya');
CALL ingresarMunicipios ('Nindirí', 'Masaya');
CALL ingresarMunicipios ('Niquinohomo', 'Masaya');
CALL ingresarMunicipios ('San Juan de Oriente', 'Masaya');
CALL ingresarMunicipios ('Tisma', 'Masaya');

-- Agregando los municipios de CARAZO
CALL ingresarMunicipios ('Diriamba', 'Carazo');
CALL ingresarMunicipios ('Dolores', 'Carazo');
CALL ingresarMunicipios ('El Rosario', 'Carazo');
CALL ingresarMunicipios ('Jinotepe', 'Carazo');
CALL ingresarMunicipios ('La Conquista', 'Carazo');
CALL ingresarMunicipios ('La Paz de Oriente', 'Carazo');
CALL ingresarMunicipios ('San Marcos', 'Carazo');
CALL ingresarMunicipios ('Santa Teresa', 'Carazo');

-- Agregando los municipios de GRANADA
CALL ingresarMunicipios ('Diriá', 'Granada');
CALL ingresarMunicipios ('Diriomo', 'Granada');
CALL ingresarMunicipios ('Granada', 'Granada');
CALL ingresarMunicipios ('Nandaime', 'Granada');

-- Agregando los municipios de RIVAS
CALL ingresarMunicipios ('Altagracia', 'Rivas');
CALL ingresarMunicipios ('Belén', 'Rivas');
CALL ingresarMunicipios ('Buenos Aires', 'Rivas');
CALL ingresarMunicipios ('Cárdenas', 'Rivas');
CALL ingresarMunicipios ('Moyogalpa', 'Rivas');
CALL ingresarMunicipios ('Potosí', 'Rivas');
CALL ingresarMunicipios ('Rivas', 'Rivas');
CALL ingresarMunicipios ('San Jorge', 'Rivas');
CALL ingresarMunicipios ('San Juan del Sur', 'Rivas');
CALL ingresarMunicipios ('Tola', 'Rivas');

-- Agregando los municipios de BOACO
CALL ingresarMunicipios ('Boaco', 'Boaco');
CALL ingresarMunicipios ('Camoapa', 'Boaco');
CALL ingresarMunicipios ('San José de los Remates', 'Boaco');
CALL ingresarMunicipios ('San Lorenzo', 'Boaco');
CALL ingresarMunicipios ('Santa Lucía', 'Boaco');
CALL ingresarMunicipios ('Teustepe', 'Boaco');

-- Agregando los municipios de CHONTALES
CALL ingresarMunicipios ('Acoyapa', 'Chontales');
CALL ingresarMunicipios ('Comalapa', 'Chontales');
CALL ingresarMunicipios ('Cuapa', 'Chontales');
CALL ingresarMunicipios ('El Coral', 'Chontales');
CALL ingresarMunicipios ('Juigalpa', 'Chontales');
CALL ingresarMunicipios ('La Libertad', 'Chontales');
CALL ingresarMunicipios ('San Pedro de Lóvago', 'Chontales');
CALL ingresarMunicipios ('Santo Domingo', 'Chontales');
CALL ingresarMunicipios ('Santo Tomás', 'Chontales');
CALL ingresarMunicipios ('Villa Sandino', 'Chontales');

-- Agregando los municipios de RÍO SAN JUAN
CALL ingresarMunicipios ('El Almendro', 'Río San Juan');
CALL ingresarMunicipios ('El Castillo', 'Río San Juan');
CALL ingresarMunicipios ('Morrito', 'Río San Juan');
CALL ingresarMunicipios ('San Carlos', 'Río San Juan');
CALL ingresarMunicipios ('San Juan del Norte', 'Río San Juan');
CALL ingresarMunicipios ('San Miguelito', 'Río San Juan');

-- Agregando los municipios de COSTA CARIBE NORTE
CALL ingresarMunicipios ('Bonanza', 'Costa Caribe Norte');
CALL ingresarMunicipios ('Mulukukú', 'Costa Caribe Norte');
CALL ingresarMunicipios ('Prinzapolka', 'Costa Caribe Norte');
CALL ingresarMunicipios ('Puerto Cabezas', 'Costa Caribe Norte');
CALL ingresarMunicipios ('Rosita', 'Costa Caribe Norte');
CALL ingresarMunicipios ('Siuna', 'Costa Caribe Norte');
CALL ingresarMunicipios ('Waslala', 'Costa Caribe Norte');
CALL ingresarMunicipios ('Waspán', 'Costa Caribe Norte');

-- Agregando los municipios de COSTA CARIBE SUR
CALL ingresarMunicipios ('Bluefields', 'Costa Caribe Sur');
CALL ingresarMunicipios ('Corn Island', 'Costa Caribe Sur');
CALL ingresarMunicipios ('Desembocadura del Río Grande', 'Costa Caribe Sur');
CALL ingresarMunicipios ('El Ayote', 'Costa Caribe Sur');
CALL ingresarMunicipios ('El Rama', 'Costa Caribe Sur');
CALL ingresarMunicipios ('El Tortuguero', 'Costa Caribe Sur');
CALL ingresarMunicipios ('Kukra Hill', 'Costa Caribe Sur');
CALL ingresarMunicipios ('La Cruz Río Grande', 'Costa Caribe Sur');
CALL ingresarMunicipios ('Laguna de Perlas', 'Costa Caribe Sur');
CALL ingresarMunicipios ('Muelle de los Bueyes', 'Costa Caribe Sur');
CALL ingresarMunicipios ('Nueva Guinea', 'Costa Caribe Sur');
CALL ingresarMunicipios ('Paiwas', 'Costa Caribe Sur');

INSERT INTO categorias (nombre_categoria) VALUES 
('Enfermedades infecciosas y parasitarias'),
('Tumores'),
('Enfermedades de la sangre y de los órganos hematopoyéticos'),
('Enfermedades endocrinas, nutricionales y metabólicas'),
('Trastornos mentales y del comportamiento'),
('Enfermedades del sistema nervioso y órganos de los sentidos'),
('Enfermedades del sistema circulatorio'),
('Enfermedades del sistema respiratorio'),
('Enfermedades del sistema digestivo'),
('Enfermedades de la piel y tejido subcutáneo'),
('Enfermedades del sistema osteomuscular y tejido conjuntivo'),
('Enfermedades del sistema genitourinario'),
('Embarazo, parto y puerperio'),
('Afecciones originadas en el periodo perinatal'),
('Malformaciones congénitas, deformidades y anomalías cromosómicas'),
('Síntomas, signos y hallazgos anormales no clasificados en otra parte'),
('Causas externas de mortalidad');

INSERT INTO causas (codigo, descripcion, categoria_id) VALUES
('A00-A09', 'Enfermedades infecciosas intestinales', 1),
('A15-A19', 'Tuberculosis y sus efectos tardíos', 1),
('A39', 'Enfermedad meningocócica', 1),
('C00-C14', 'Tumor maligno del labio, cavidad bucal y faringe', 2),
('C15', 'Tumor maligno del esófago', 2),
('D50-D77', 'Enfermedades de la sangre y órganos hematopoyéticos', 3),
('E10-E14', 'Diabetes mellitus', 4),
('F10', 'Trastornos mentales debidos al uso de alcohol', 5),
('G00-G03', 'Meningitis', 6),
('I10-I15', 'Enfermedades hipertensivas', 7),
('J09-J11', 'Influenza', 8),
('K25-K28', 'Úlcera de estómago, duodeno y yeyuno', 9),
('L00-L99', 'Enfermedades de la piel y tejido subcutáneo', 10),
('M05, M06', 'Artritis reumatoide', 11),
('N00-N29', 'Enfermedades del riñón y uréter', 12);

INSERT INTO causas (codigo, descripcion, categoria_id) VALUES
('A40-A41', 'Septicemia', 1),
('B15-B19', 'Hepatitis vírica', 1),
('B20-B24', 'SIDA', 1),
('R75', 'VIH+ (portador)', 1),
('C16', 'Tumor maligno del estómago', 2),
('C18', 'Tumor maligno del colon', 2),
('C19-C21', 'Tumor maligno del recto, porción rectosigmoide y ano', 2),
('C22', 'Tumor maligno del hígado y vías biliares intrahepáticas', 2),
('C25', 'Tumor maligno del páncreas', 2),
('C32', 'Tumor maligno de la laringe', 2),
('C33-C34', 'Tumor maligno de la tráquea, bronquios y pulmón', 2),
('D80-D89', 'Ciertos trastornos del sistema inmunológico', 3),
('E00-E90', 'Otras enfermedades endocrinas, nutricionales y metabólicas', 4),
('F11-F16', 'Trastornos mentales por drogas', 5),
('F18-F19', 'Trastornos mentales por otras sustancias psicoactivas', 5),
('G30', 'Enfermedad de Alzheimer', 6),
('I21', 'Infarto agudo de miocardio', 7),
('I50', 'Insuficiencia cardíaca', 7),
('J12-J18', 'Neumonía', 8),
('J40-J44, J47', 'Enfermedades crónicas de vías respiratorias inferiores', 8),
('J45-J46', 'Asma', 8),
('K50-K52', 'Enteritis y colitis no infecciosas', 9),
('K55', 'Enfermedad vascular intestinal', 9),
('K70, K73, K74', 'Cirrosis y otras enfermedades crónicas del hígado', 9),
('L00-L99', 'Enfermedades de la piel y del tejido subcutáneo', 10),
('M80-M82', 'Osteoporosis y fractura patológica', 11),
('N40-N51', 'Enfermedades de los órganos genitales masculinos', 12),
('O00-O99', 'Embarazo, parto y puerperio', 13),
('P00-P96', 'Afecciones originadas en el periodo perinatal', 14),
('Q00-Q07', 'Malformaciones congénitas del sistema nervioso', 15),
('Q20-Q28', 'Malformaciones congénitas del sistema circulatorio', 15),
('R00-R74, R76-R99', 'Síntomas y signos anormales no clasificados en otra parte', 16),
('V01-Y89', 'Causas externas de mortalidad', 17);

INSERT INTO causas (codigo, descripcion, categoria_id) VALUES
('A00-B99, U04.9, U07.0', 'Resto de enfermedades infecciosas y parasitarias', 1),
('C45.1, C48', 'Otros tumores malignos digestivos', 2),
('C30-C39, C45.0.2', 'Otros tumores malignos respiratorios e intratorácicos', 2),
('C40, C41', 'Tumores malignos de hueso y cartílagos articulares', 2),
('C43', 'Melanoma maligno de la piel', 2),
('C44-C47, C49', 'Otros tumores malignos de la piel y tejidos blandos', 2),
('C50', 'Tumor maligno de la mama', 2),
('C53', 'Tumor maligno del cuello del útero', 2),
('C54, C55', 'Tumor maligno de otras partes del útero', 2),
('C56', 'Tumor maligno del ovario', 2),
('C51-C58', 'Tumores malignos de otros órganos genitales femeninos', 2),
('C61', 'Tumor maligno de la próstata', 2),
('C60-C63', 'Tumores malignos de otros órganos genitales masculinos', 2),
('C64', 'Tumor maligno del riñón (excepto pelvis renal)', 2),
('C67', 'Tumor maligno de la vejiga', 2),
('C64-C68', 'Otros tumores malignos de las vías urinarias', 2),
('C71', 'Tumor maligno del encéfalo', 2),
('C69-C75', 'Otros tumores malignos neurológicos y endocrinos', 2),
('C76, C80', 'Tumor maligno de sitios mal definidos y secundarios', 2),
('C81-C90, C96', 'Tumores malignos del tejido linfático y órganos hematopoyéticos (excepto leucemia)', 2),
('C91-C95', 'Leucemia', 2),
('D00-D09', 'Tumores in situ', 2),
('D10-D36', 'Tumores benignos', 2),
('D46', 'Síndrome mielodisplásico', 2),
('D37-D45, D47, D48', 'Otros tumores de comportamiento incierto o desconocido', 2),
('D50-D77', 'Enfermedades hematopoyéticas y ciertos trastornos de inmunidad', 3),
('E10-E14', 'Diabetes mellitus', 4),
('E00-E90', 'Otras enfermedades endocrinas, nutricionales y metabólicas', 4),
('F00-F09', 'Trastornos mentales orgánicos, senil y presenil', 5),
('F47', 'Trastornos mentales debidos al uso de alcohol', 5),
('F11-F19', 'Trastornos mentales debidos al uso de drogas', 5),
('F00-F99', 'Otros trastornos mentales y del comportamiento', 5),
('G00-G03', 'Meningitis', 6),
('G30', 'Enfermedad de Alzheimer', 6),
('G00-H95', 'Otras enfermedades del sistema nervioso y órganos de los sentidos', 6),
('I00-I02, I26-I49, I51', 'Otras enfermedades del corazón', 7),
('I60-I69', 'Enfermedades cerebrovasculares', 7),
('I70', 'Aterosclerosis', 7),
('I71-I99', 'Otras enfermedades de los vasos sanguíneos', 7),
('J12-J18', 'Neumonía', 8),
('J40-J44, J47', 'Enfermedades crónicas de las vías respiratorias inferiores (excepto asma)', 8),
('J45, J46', 'Asma', 8),
('J96', 'Insuficiencia respiratoria', 8),
('K00-K93', 'Otras enfermedades del sistema digestivo', 9),
('K25-K28', 'Úlcera de estómago, duodeno y yeyuno', 9),
('K50-K52', 'Enteritis y colitis no infecciosas', 9),
('K55', 'Enfermedad vascular intestinal', 9),
('K70, K72.1, K73, K74', 'Cirrosis y otras enfermedades crónicas del hígado', 9),
('K00-K93', 'Otras enfermedades del sistema digestivo', 9)
,
('K00-K93', 'Agresiones (homicidio)',17 );


create database memorialdb;
use memorialdb;


 -- Tabla Usuario
CREATE TABLE usuario(
    id_usuario INT PRIMARY KEY AUTO_INCREMENT,
    nombre_usuario VARCHAR (45) NOT NULL,
    clave VARCHAR (255) NOT NULL,
    rol VARCHAR (255) NOT NULL
)ENGINE=InnoDB;
 
 -- Tabla departamento
 create table departamento(
 id_departamento int auto_increment primary key,
 nombre_departamento varchar(50) NOT NULL
 )engine=InnoDB;


 -- Tabla municipio
 create table municipio(
 id_municipio int auto_increment primary key,
 nombre_municipio varchar(70) NOT NULL,
 departamento_id_departamento int,
 foreign key(departamento_id_departamento)references departamento(id_departamento) on delete set null on update cascade
 )engine=InnoDB;

 -- Tabla categorias
 CREATE TABLE  categorias (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre_categoria VARCHAR(255) NOT NULL
)engine=InnoDB;

 -- Tabla causas
CREATE TABLE causas (
    id_causa INT AUTO_INCREMENT PRIMARY KEY,
    codigo VARCHAR(25) NOT NULL,    -- Código CIE-10
    descripcion TEXT NOT NULL,      -- Descripción de la enfermedad
    categoria_id INT,               -- Llave foránea a la tabla de categorías
    FOREIGN KEY (categoria_id) REFERENCES categorias(id) ON DELETE CASCADE,
    INDEX (codigo)
)engine=InnoDB;

 -- Tabla cementerio
create table cementerio(
 id_cementerio int auto_increment primary key,
 nombre varchar(50)  NOT NULL,
 latitud double NOT NULL,
 longitud double NOT NULL,
 capacidad varchar(30),
 tipo varchar(50),
 hora_apertura time,
 hora_cierre time,
 municipio_id_municipio int NOT NULL,
 foreign key (municipio_id_municipio) references municipio(id_municipio)
 )engine=InnoDB;


 -- Tabla defunciones
CREATE TABLE defunciones (
  id_defuncion INT AUTO_INCREMENT PRIMARY KEY,
  
  -- A. DATOS DEL FALLECIDO
  primer_nombre VARCHAR(255) NOT NULL,
  segundo_nombre VARCHAR(255),
  primer_apellido VARCHAR(255) NOT NULL,
  segundo_apellido VARCHAR(255),
  cedula VARCHAR(14) UNIQUE ,
  etnia VARCHAR(255),
  
  -- RESIDENCIA HABITUAL
  municipio INT,
  fecha_nacimiento DATE,
  edad_cumplida INT,
  sexo ENUM('Masculino', 'Femenino'),
  nacionalidad ENUM('Nicaraguense', 'Extranjero'),
  estado_civil ENUM('Union Libre', 'Casado', 'Soltero', 'Otro'),
  nombre_conyugue VARCHAR(200),
  ocupacion VARCHAR(255),
  
  -- B. DATOS DE LA DEFUNCIÓN
  fecha_ocurrencia DATE,
  municipio_ocurrencia INT,
  hora_defuncion TIME,
  
  -- C. CAUSAS DE LA DEFUNCIÓN
  causa_muerte INT,
  
  FOREIGN KEY (municipio) REFERENCES municipio(id_municipio),
  FOREIGN KEY (municipio_ocurrencia) REFERENCES municipio(id_municipio),
  FOREIGN KEY (causa_muerte) REFERENCES causas(id_causa)
)engine=InnoDB;

 -- Tabla familiar
 create table familiar(
   -- DATOS DEL Familiar
	id_familiar int primary key auto_increment,
  nombre_completo VARCHAR(255),
  sexo ENUM('Masculino', 'Femenino'),
  correo varchar(50),
  usuario VARCHAR(255),
  familiar_difunto int,
    FOREIGN KEY (familiar_difunto) REFERENCES defunciones(id_defuncion)
 )engine=InnoDB;



 -- Tabla ubicacion descando
create table ubicacion_descanso (
id_ubicacion int auto_increment primary key, 
latitud double,
longitud double,
descripcion_lugar varchar(150),
defuncion_id_defuncion int not null,
cementerio_id_cementerio int not null,
imagen_descanso varchar(30),
 foreign key(defuncion_id_defuncion)references defunciones(id_defuncion) on delete cascade on update restrict,
 foreign key(cementerio_id_cementerio)references cementerio(id_cementerio) on delete cascade on update restrict
 )engine=InnoDB;
 
 select * from defunciones inner join ubicacion_descanso on id_defuncion=defuncion_id_defuncion  where id_defuncion=1;

SELECT *FROM ubicacion_descanso;

SELECT 
    d.*
    FROM 
    defunciones d
   
    LEFT JOIN 
    ubicacion_descanso u ON d.id_defuncion = u.defuncion_id_defuncion
    WHERE 
    u.defuncion_id_defuncion IS NULL;
    
    SELECT 
        d.*,u.*
        FROM 
        ubicacion_descanso u
        Inner JOIN 
        defunciones d ON d.id_defuncion = u.defuncion_id_defuncion;

  -- Tabla ubicacion galeria
 create table galeria(
 id_recuerdo int auto_increment primary key,
 recurso varchar(200),
 descripcion_recuerdo text,
 defuncion_id_defuncion int,
  foreign key(defuncion_id_defuncion)references defunciones(id_defuncion) on delete cascade
 )engine=InnoDB;

CREATE TABLE servicio (
    id_servicio INT AUTO_INCREMENT PRIMARY KEY,
    tipo_servicio varchar(100) NOT NULL,
    descripcion TEXT,
    precio float not null,
    imagen varchar(50)
) ENGINE=InnoDB;


CREATE TABLE operarios (
    id_operario INT AUTO_INCREMENT PRIMARY KEY,
    nombre_completo VARCHAR(255) NOT NULL,
    telefono VARCHAR(20) NOT NULL,
    direccion VARCHAR(255) NOT NULL,
    estado ENUM('Activo', 'Inactivo') DEFAULT 'Activo',
    especialidad VARCHAR(255), -- EJM Limpieza, Reparación, etc.
    imagenOperario varchar(50), -- Foto de el operario,
    cementerio_id_cementerio int, -- llave foranea de relacion del cementerio con el operario
    FOREIGN KEY (cementerio_id_cementerio) REFERENCES cementerio(id_cementerio) ON DELETE SET NULL
) ENGINE=InnoDB;

select *from operarios;

-- proveedor servicios PENDIENTE
CREATE TABLE proveedor_servicio (
    id_proveedor INT AUTO_INCREMENT PRIMARY KEY,
    operario_id_operario int,
    servicio_id_servicio int,
    FOREIGN KEY (operario_id_operario) REFERENCES operarios(id_operario),
    FOREIGN KEY (servicio_id_servicio) REFERENCES servicio(id_servicio)
) ENGINE=InnoDB;

select *from proveedor_servicio inner join operarios on operario_id_operario=id_operario inner join servicio on servicio_id_servicio=id_servicio;

CREATE TABLE servicio_mantenimiento (
    id_mantenimiento INT AUTO_INCREMENT PRIMARY KEY,
    ubicacion_descanso_id INT NOT NULL, -- Llave foránea a la tabla ubicacion_descanso
    servicio_id_servicio INT NOT NULL,           -- Llave foránea a la tabla proveedor_servicio
    fecha_servicio DATE NOT NULL,
    estado ENUM('Completado', 'Pendiente', 'Cancelado') NOT NULL,
    observaciones TEXT,
    FOREIGN KEY (ubicacion_descanso_id) REFERENCES ubicacion_descanso(id_ubicacion) ,
    FOREIGN KEY (servicio_id_servicio) REFERENCES servicio(id_servicio)
) ENGINE=InnoDB;

select *from servicio_mantenimiento inner join ubicacion_descanso on id_ubicacion=ubicacion_descanso_id inner join servicio on id_servicio=servicio_id_servicio;

select *from servicio_mantenimiento inner join ubicacion_descanso on id_ubicacion=ubicacion_descanso_id ;


INSERT INTO servicio (tipo_servicio, descripcion, precio) VALUES 
('Limpieza', 'Limpieza profunda de la tumba, eliminando suciedad y maleza.', 50.00),
('Reparación', 'Reparación de lápidas y estructuras de la tumba.', 150.00),
('Pintura', 'Pintura de lápidas y ornamentaciones.', 100.00),
('Mantenimiento General', 'Mantenimiento regular, incluyendo limpieza y revisión de estructuras.', 75.00),
('Otro', 'Servicio personalizado según las necesidades del cliente.', 200.00);

INSERT INTO servicio (tipo_servicio, descripcion, precio) VALUES 
('Monumento Personalizado', 'Diseño y creación de monumentos personalizados.', 300.00),
('Floristería', 'Entrega de flores frescas o artificiales para adornar tumbas.', 40.00),
('Servicios de Grabado', 'Grabado de nombres y fechas en lápidas.', 100.00),
('Mantenimiento de Jardines', 'Cuidado de áreas verdes alrededor de tumbas.', 60.00);


 




-- ######### CONSULTAS ###############
-- Consulta para agregar todos los DEPARTAMENTOS
 INSERT INTO departamento (nombre_departamento) VALUES ("Madriz"), ("Nueva Segovia"), ("Estelí"), ("Jinotega"), ("Matagalpa"), ("Managua"), 
 ("León"), ("Chinandega"), ("Masaya"), ("Carazo"), ("Granada"), ("Rivas"), ("Boaco"), ("Chontales"), ("Río San Juan"), ("Costa Caribe Norte"), ("Costa Caribe Sur");
 
 -- Procedimiento de Almacenado para agregar MUNICIPIO a los DEPARTAMENTOS
 DELIMITER //
CREATE PROCEDURE ingresarMunicipios(
    IN municipio VARCHAR(50),
    IN deptoNombre VARCHAR(255)
)
BEGIN
    DECLARE deptoId INT;

    -- Obtener el id del departamento basado en su nombre
    SELECT id_departamento INTO deptoId
    FROM departamento
    WHERE nombre_departamento = deptoNombre;
    
    -- Inserta los municipios, si el departamento existe
    IF deptoId IS NOT NULL THEN
        INSERT INTO municipio (nombre_municipio, departamento_id_departamento) VALUES (municipio, deptoId);
    ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Departamento no encontrado';
    END IF;
END //
DELIMITER ;

-- Agregando los municipios de MADRIZ
CALL ingresarMunicipios ('Somoto', 'Madriz');
CALL ingresarMunicipios ('San Juan del Río Coco', 'Madriz');
CALL ingresarMunicipios ('San José de Cusmapa', 'Madriz');
CALL ingresarMunicipios ('Las Sabanas', 'Madriz');
CALL ingresarMunicipios ('San Lucas', 'Madriz');
CALL ingresarMunicipios ('Yalagüina', 'Madriz');
CALL ingresarMunicipios ('Palacagüina', 'Madriz');
CALL ingresarMunicipios ('Totogalpa', 'Madriz');
CALL ingresarMunicipios ('Telpaneca', 'Madriz');

-- Agregando los municipios de NUEVA SEGOVIA
CALL ingresarMunicipios ('Ciudad Antigua', 'Nueva Segovia');
CALL ingresarMunicipios ('Dipilto', 'Nueva Segovia');
CALL ingresarMunicipios ('El Jícaro', 'Nueva Segovia');
CALL ingresarMunicipios ('Jalapa', 'Nueva Segovia');
CALL ingresarMunicipios ('Macuelizo', 'Nueva Segovia');
CALL ingresarMunicipios ('Mozonte', 'Nueva Segovia');
CALL ingresarMunicipios ('Murra', 'Nueva Segovia');
CALL ingresarMunicipios ('Ocotal', 'Nueva Segovia');
CALL ingresarMunicipios ('Quilalí', 'Nueva Segovia');
CALL ingresarMunicipios ('San Fernando', 'Nueva Segovia');
CALL ingresarMunicipios ('Santa María', 'Nueva Segovia');
CALL ingresarMunicipios ('Wiwilí', 'Nueva Segovia');

-- Agregando los municipios de ESTELÍ
CALL ingresarMunicipios ('Condega', 'Estelí');
CALL ingresarMunicipios ('Estelí', 'Estelí');
CALL ingresarMunicipios ('La Trinidad', 'Estelí');
CALL ingresarMunicipios ('Pueblo Nuevo', 'Estelí');
CALL ingresarMunicipios ('San Juan de Limay', 'Estelí');
CALL ingresarMunicipios ('San Nicolás', 'Estelí');

-- Agregando los municipios de JINOTEGA
CALL ingresarMunicipios ('El Cuá', 'Jinotega');
CALL ingresarMunicipios ('Jinotega', 'Jinotega');
CALL ingresarMunicipios ('La Concordia', 'Jinotega');
CALL ingresarMunicipios ('San José de Bocay', 'Jinotega');
CALL ingresarMunicipios ('San Rafael del Norte', 'Jinotega');
CALL ingresarMunicipios ('San Sebastián de Yalí', 'Jinotega');
CALL ingresarMunicipios ('Santa María de Pantasma', 'Jinotega');
CALL ingresarMunicipios ('Wiwilí de Jinotega', 'Jinotega');

-- Agregando los municipios de MATAGALPA
CALL ingresarMunicipios ('Ciudad Darío', 'Matagalpa');
CALL ingresarMunicipios ('El Tuma La Dalia', 'Matagalpa');
CALL ingresarMunicipios ('Esquipulas', 'Matagalpa');
CALL ingresarMunicipios ('Matagalpa', 'Matagalpa');
CALL ingresarMunicipios ('Matiguás', 'Matagalpa');
CALL ingresarMunicipios ('Muy Muy', 'Matagalpa');
CALL ingresarMunicipios ('Rancho Grande', 'Matagalpa');
CALL ingresarMunicipios ('Río Blanco', 'Matagalpa');
CALL ingresarMunicipios ('San Dionisio', 'Matagalpa');
CALL ingresarMunicipios ('San Isidro', 'Matagalpa');
CALL ingresarMunicipios ('San Ramón', 'Matagalpa');
CALL ingresarMunicipios ('Sébaco', 'Matagalpa');
CALL ingresarMunicipios ('Terrabona', 'Matagalpa');

-- Agregando los municipios de MANAGUA
CALL ingresarMunicipios ('Ciudad Sandino', 'Managua');
CALL ingresarMunicipios ('El Crucero', 'Managua');
CALL ingresarMunicipios ('Managua', 'Managua');
CALL ingresarMunicipios ('Mateare', 'Managua');
CALL ingresarMunicipios ('San Francisco Libre', 'Managua');
CALL ingresarMunicipios ('San Rafael del Sur', 'Managua');
CALL ingresarMunicipios ('Ticuantepe', 'Managua');
CALL ingresarMunicipios ('Tipitapa', 'Managua');
CALL ingresarMunicipios ('Villa Carlos Fonseca', 'Managua');

-- Agregando los municipios de LEÓN
CALL ingresarMunicipios ('Achuapa', 'León');
CALL ingresarMunicipios ('El Jicaral', 'León');
CALL ingresarMunicipios ('El Sauce', 'León');
CALL ingresarMunicipios ('La Paz Centro', 'León');
CALL ingresarMunicipios ('Larreynaga', 'León');
CALL ingresarMunicipios ('León', 'León');
CALL ingresarMunicipios ('Nagarote', 'León');
CALL ingresarMunicipios ('Quezalguaque', 'León');
CALL ingresarMunicipios ('Santa Rosa del Peñón', 'León');
CALL ingresarMunicipios ('Telica', 'León');

-- Agregando los municipios de CHINANDEGA
CALL ingresarMunicipios ('Chichigalpa', 'Chinandega');
CALL ingresarMunicipios ('Chinandega', 'Chinandega');
CALL ingresarMunicipios ('Cinco Pinos', 'Chinandega');
CALL ingresarMunicipios ('Corinto', 'Chinandega');
CALL ingresarMunicipios ('El Realejo', 'Chinandega');
CALL ingresarMunicipios ('El Viejo', 'Chinandega');
CALL ingresarMunicipios ('Posoltega', 'Chinandega');
CALL ingresarMunicipios ('Puerto Morazán', 'Chinandega');
CALL ingresarMunicipios ('San Francisco del Norte', 'Chinandega');
CALL ingresarMunicipios ('San Pedro del Norte', 'Chinandega');
CALL ingresarMunicipios ('Santo Tomás del Norte', 'Chinandega');
CALL ingresarMunicipios ('Somotillo', 'Chinandega');
CALL ingresarMunicipios ('Villa Nueva', 'Chinandega');

-- Agregando los municipios de MASAYA
CALL ingresarMunicipios ('Catarina', 'Masaya');
CALL ingresarMunicipios ('La Concepción', 'Masaya');
CALL ingresarMunicipios ('Masatepe', 'Masaya');
CALL ingresarMunicipios ('Masaya', 'Masaya');
CALL ingresarMunicipios ('Nandasmo', 'Masaya');
CALL ingresarMunicipios ('Nindirí', 'Masaya');
CALL ingresarMunicipios ('Niquinohomo', 'Masaya');
CALL ingresarMunicipios ('San Juan de Oriente', 'Masaya');
CALL ingresarMunicipios ('Tisma', 'Masaya');

-- Agregando los municipios de CARAZO
CALL ingresarMunicipios ('Diriamba', 'Carazo');
CALL ingresarMunicipios ('Dolores', 'Carazo');
CALL ingresarMunicipios ('El Rosario', 'Carazo');
CALL ingresarMunicipios ('Jinotepe', 'Carazo');
CALL ingresarMunicipios ('La Conquista', 'Carazo');
CALL ingresarMunicipios ('La Paz de Oriente', 'Carazo');
CALL ingresarMunicipios ('San Marcos', 'Carazo');
CALL ingresarMunicipios ('Santa Teresa', 'Carazo');

-- Agregando los municipios de GRANADA
CALL ingresarMunicipios ('Diriá', 'Granada');
CALL ingresarMunicipios ('Diriomo', 'Granada');
CALL ingresarMunicipios ('Granada', 'Granada');
CALL ingresarMunicipios ('Nandaime', 'Granada');

-- Agregando los municipios de RIVAS
CALL ingresarMunicipios ('Altagracia', 'Rivas');
CALL ingresarMunicipios ('Belén', 'Rivas');
CALL ingresarMunicipios ('Buenos Aires', 'Rivas');
CALL ingresarMunicipios ('Cárdenas', 'Rivas');
CALL ingresarMunicipios ('Moyogalpa', 'Rivas');
CALL ingresarMunicipios ('Potosí', 'Rivas');
CALL ingresarMunicipios ('Rivas', 'Rivas');
CALL ingresarMunicipios ('San Jorge', 'Rivas');
CALL ingresarMunicipios ('San Juan del Sur', 'Rivas');
CALL ingresarMunicipios ('Tola', 'Rivas');

-- Agregando los municipios de BOACO
CALL ingresarMunicipios ('Boaco', 'Boaco');
CALL ingresarMunicipios ('Camoapa', 'Boaco');
CALL ingresarMunicipios ('San José de los Remates', 'Boaco');
CALL ingresarMunicipios ('San Lorenzo', 'Boaco');
CALL ingresarMunicipios ('Santa Lucía', 'Boaco');
CALL ingresarMunicipios ('Teustepe', 'Boaco');

-- Agregando los municipios de CHONTALES
CALL ingresarMunicipios ('Acoyapa', 'Chontales');
CALL ingresarMunicipios ('Comalapa', 'Chontales');
CALL ingresarMunicipios ('Cuapa', 'Chontales');
CALL ingresarMunicipios ('El Coral', 'Chontales');
CALL ingresarMunicipios ('Juigalpa', 'Chontales');
CALL ingresarMunicipios ('La Libertad', 'Chontales');
CALL ingresarMunicipios ('San Pedro de Lóvago', 'Chontales');
CALL ingresarMunicipios ('Santo Domingo', 'Chontales');
CALL ingresarMunicipios ('Santo Tomás', 'Chontales');
CALL ingresarMunicipios ('Villa Sandino', 'Chontales');

-- Agregando los municipios de RÍO SAN JUAN
CALL ingresarMunicipios ('El Almendro', 'Río San Juan');
CALL ingresarMunicipios ('El Castillo', 'Río San Juan');
CALL ingresarMunicipios ('Morrito', 'Río San Juan');
CALL ingresarMunicipios ('San Carlos', 'Río San Juan');
CALL ingresarMunicipios ('San Juan del Norte', 'Río San Juan');
CALL ingresarMunicipios ('San Miguelito', 'Río San Juan');

-- Agregando los municipios de COSTA CARIBE NORTE
CALL ingresarMunicipios ('Bonanza', 'Costa Caribe Norte');
CALL ingresarMunicipios ('Mulukukú', 'Costa Caribe Norte');
CALL ingresarMunicipios ('Prinzapolka', 'Costa Caribe Norte');
CALL ingresarMunicipios ('Puerto Cabezas', 'Costa Caribe Norte');
CALL ingresarMunicipios ('Rosita', 'Costa Caribe Norte');
CALL ingresarMunicipios ('Siuna', 'Costa Caribe Norte');
CALL ingresarMunicipios ('Waslala', 'Costa Caribe Norte');
CALL ingresarMunicipios ('Waspán', 'Costa Caribe Norte');

-- Agregando los municipios de COSTA CARIBE SUR
CALL ingresarMunicipios ('Bluefields', 'Costa Caribe Sur');
CALL ingresarMunicipios ('Corn Island', 'Costa Caribe Sur');
CALL ingresarMunicipios ('Desembocadura del Río Grande', 'Costa Caribe Sur');
CALL ingresarMunicipios ('El Ayote', 'Costa Caribe Sur');
CALL ingresarMunicipios ('El Rama', 'Costa Caribe Sur');
CALL ingresarMunicipios ('El Tortuguero', 'Costa Caribe Sur');
CALL ingresarMunicipios ('Kukra Hill', 'Costa Caribe Sur');
CALL ingresarMunicipios ('La Cruz Río Grande', 'Costa Caribe Sur');
CALL ingresarMunicipios ('Laguna de Perlas', 'Costa Caribe Sur');
CALL ingresarMunicipios ('Muelle de los Bueyes', 'Costa Caribe Sur');
CALL ingresarMunicipios ('Nueva Guinea', 'Costa Caribe Sur');
CALL ingresarMunicipios ('Paiwas', 'Costa Caribe Sur');

INSERT INTO categorias (nombre_categoria) VALUES 
('Enfermedades infecciosas y parasitarias'),
('Tumores'),
('Enfermedades de la sangre y de los órganos hematopoyéticos'),
('Enfermedades endocrinas, nutricionales y metabólicas'),
('Trastornos mentales y del comportamiento'),
('Enfermedades del sistema nervioso y órganos de los sentidos'),
('Enfermedades del sistema circulatorio'),
('Enfermedades del sistema respiratorio'),
('Enfermedades del sistema digestivo'),
('Enfermedades de la piel y tejido subcutáneo'),
('Enfermedades del sistema osteomuscular y tejido conjuntivo'),
('Enfermedades del sistema genitourinario'),
('Embarazo, parto y puerperio'),
('Afecciones originadas en el periodo perinatal'),
('Malformaciones congénitas, deformidades y anomalías cromosómicas'),
('Síntomas, signos y hallazgos anormales no clasificados en otra parte'),
('Causas externas de mortalidad');

INSERT INTO causas (codigo, descripcion, categoria_id) VALUES
('A00-A09', 'Enfermedades infecciosas intestinales', 1),
('A15-A19', 'Tuberculosis y sus efectos tardíos', 1),
('A39', 'Enfermedad meningocócica', 1),
('C00-C14', 'Tumor maligno del labio, cavidad bucal y faringe', 2),
('C15', 'Tumor maligno del esófago', 2),
('D50-D77', 'Enfermedades de la sangre y órganos hematopoyéticos', 3),
('E10-E14', 'Diabetes mellitus', 4),
('F10', 'Trastornos mentales debidos al uso de alcohol', 5),
('G00-G03', 'Meningitis', 6),
('I10-I15', 'Enfermedades hipertensivas', 7),
('J09-J11', 'Influenza', 8),
('K25-K28', 'Úlcera de estómago, duodeno y yeyuno', 9),
('L00-L99', 'Enfermedades de la piel y tejido subcutáneo', 10),
('M05, M06', 'Artritis reumatoide', 11),
('N00-N29', 'Enfermedades del riñón y uréter', 12);

INSERT INTO causas (codigo, descripcion, categoria_id) VALUES
('A40-A41', 'Septicemia', 1),
('B15-B19', 'Hepatitis vírica', 1),
('B20-B24', 'SIDA', 1),
('R75', 'VIH+ (portador)', 1),
('C16', 'Tumor maligno del estómago', 2),
('C18', 'Tumor maligno del colon', 2),
('C19-C21', 'Tumor maligno del recto, porción rectosigmoide y ano', 2),
('C22', 'Tumor maligno del hígado y vías biliares intrahepáticas', 2),
('C25', 'Tumor maligno del páncreas', 2),
('C32', 'Tumor maligno de la laringe', 2),
('C33-C34', 'Tumor maligno de la tráquea, bronquios y pulmón', 2),
('D80-D89', 'Ciertos trastornos del sistema inmunológico', 3),
('E00-E90', 'Otras enfermedades endocrinas, nutricionales y metabólicas', 4),
('F11-F16', 'Trastornos mentales por drogas', 5),
('F18-F19', 'Trastornos mentales por otras sustancias psicoactivas', 5),
('G30', 'Enfermedad de Alzheimer', 6),
('I21', 'Infarto agudo de miocardio', 7),
('I50', 'Insuficiencia cardíaca', 7),
('J12-J18', 'Neumonía', 8),
('J40-J44, J47', 'Enfermedades crónicas de vías respiratorias inferiores', 8),
('J45-J46', 'Asma', 8),
('K50-K52', 'Enteritis y colitis no infecciosas', 9),
('K55', 'Enfermedad vascular intestinal', 9),
('K70, K73, K74', 'Cirrosis y otras enfermedades crónicas del hígado', 9),
('L00-L99', 'Enfermedades de la piel y del tejido subcutáneo', 10),
('M80-M82', 'Osteoporosis y fractura patológica', 11),
('N40-N51', 'Enfermedades de los órganos genitales masculinos', 12),
('O00-O99', 'Embarazo, parto y puerperio', 13),
('P00-P96', 'Afecciones originadas en el periodo perinatal', 14),
('Q00-Q07', 'Malformaciones congénitas del sistema nervioso', 15),
('Q20-Q28', 'Malformaciones congénitas del sistema circulatorio', 15),
('R00-R74, R76-R99', 'Síntomas y signos anormales no clasificados en otra parte', 16),
('V01-Y89', 'Causas externas de mortalidad', 17);

INSERT INTO causas (codigo, descripcion, categoria_id) VALUES
('A00-B99, U04.9, U07.0', 'Resto de enfermedades infecciosas y parasitarias', 1),
('C45.1, C48', 'Otros tumores malignos digestivos', 2),
('C30-C39, C45.0.2', 'Otros tumores malignos respiratorios e intratorácicos', 2),
('C40, C41', 'Tumores malignos de hueso y cartílagos articulares', 2),
('C43', 'Melanoma maligno de la piel', 2),
('C44-C47, C49', 'Otros tumores malignos de la piel y tejidos blandos', 2),
('C50', 'Tumor maligno de la mama', 2),
('C53', 'Tumor maligno del cuello del útero', 2),
('C54, C55', 'Tumor maligno de otras partes del útero', 2),
('C56', 'Tumor maligno del ovario', 2),
('C51-C58', 'Tumores malignos de otros órganos genitales femeninos', 2),
('C61', 'Tumor maligno de la próstata', 2),
('C60-C63', 'Tumores malignos de otros órganos genitales masculinos', 2),
('C64', 'Tumor maligno del riñón (excepto pelvis renal)', 2),
('C67', 'Tumor maligno de la vejiga', 2),
('C64-C68', 'Otros tumores malignos de las vías urinarias', 2),
('C71', 'Tumor maligno del encéfalo', 2),
('C69-C75', 'Otros tumores malignos neurológicos y endocrinos', 2),
('C76, C80', 'Tumor maligno de sitios mal definidos y secundarios', 2),
('C81-C90, C96', 'Tumores malignos del tejido linfático y órganos hematopoyéticos (excepto leucemia)', 2),
('C91-C95', 'Leucemia', 2),
('D00-D09', 'Tumores in situ', 2),
('D10-D36', 'Tumores benignos', 2),
('D46', 'Síndrome mielodisplásico', 2),
('D37-D45, D47, D48', 'Otros tumores de comportamiento incierto o desconocido', 2),
('D50-D77', 'Enfermedades hematopoyéticas y ciertos trastornos de inmunidad', 3),
('E10-E14', 'Diabetes mellitus', 4),
('E00-E90', 'Otras enfermedades endocrinas, nutricionales y metabólicas', 4),
('F00-F09', 'Trastornos mentales orgánicos, senil y presenil', 5),
('F47', 'Trastornos mentales debidos al uso de alcohol', 5),
('F11-F19', 'Trastornos mentales debidos al uso de drogas', 5),
('F00-F99', 'Otros trastornos mentales y del comportamiento', 5),
('G00-G03', 'Meningitis', 6),
('G30', 'Enfermedad de Alzheimer', 6),
('G00-H95', 'Otras enfermedades del sistema nervioso y órganos de los sentidos', 6),
('I00-I02, I26-I49, I51', 'Otras enfermedades del corazón', 7),
('I60-I69', 'Enfermedades cerebrovasculares', 7),
('I70', 'Aterosclerosis', 7),
('I71-I99', 'Otras enfermedades de los vasos sanguíneos', 7),
('J12-J18', 'Neumonía', 8),
('J40-J44, J47', 'Enfermedades crónicas de las vías respiratorias inferiores (excepto asma)', 8),
('J45, J46', 'Asma', 8),
('J96', 'Insuficiencia respiratoria', 8),
('K00-K93', 'Otras enfermedades del sistema digestivo', 9),
('K25-K28', 'Úlcera de estómago, duodeno y yeyuno', 9),
('K50-K52', 'Enteritis y colitis no infecciosas', 9),
('K55', 'Enfermedad vascular intestinal', 9),
('K70, K72.1, K73, K74', 'Cirrosis y otras enfermedades crónicas del hígado', 9),
('K00-K93', 'Otras enfermedades del sistema digestivo', 9)
,
('K00-K93', 'Agresiones (homicidio)',17 );
