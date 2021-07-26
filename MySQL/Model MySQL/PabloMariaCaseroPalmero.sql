DROP DATABASE IF EXISTS  FACULTAD;
CREATE DATABASE FACULTAD;
USE FACULTAD;
-- Nos aseguramos que se borre y se cree de nuevo la tabla en caso de que exista
DROP TABLE IF EXISTS CURSOS;
DROP TABLE IF EXISTS ASIGNATURAS;
DROP TABLE IF EXISTS TELEFONO;
DROP TABLE IF EXISTS PROFESORES;
DROP TABLE IF EXISTS ALUMNOS;
DROP TABLE IF EXISTS MATRICULA;
DROP TABLE IF EXISTS IMPARTE;

-- Creamos las tablas 
CREATE TABLE CURSOS(
            CodCurso SMALLINT PRIMARY KEY,
            NomCurso VARCHAR(20) NOT NULL,
            NumAsigCurso SMALLINT NULL
);
CREATE TABLE PROFESORES(
            CodProfe SMALLINT,
            NIFProfe CHAR(9),
            NomProfe VARCHAR(15) NOT NULL,
            ApeProfe VARCHAR(20) NOT NULL,
            DirPostProfe NUMERIC(6,0),
            DirCorrProfe VARCHAR(45),
            CategProfe VARCHAR(50),
            PRIMARY KEY(CodProfe)
		
);
CREATE TABLE ASIGNATURAS(
			CodAsig NUMERIC(5,0) PRIMARY KEY,
            NomAsig VARCHAR(50) NOT NULL,
            CaractAsig VARCHAR(15) NOT NULL,
            NumCredAsig SMALLINT NOT NULL,
            CuatriAsig NUMERIC(1,0) NOT NULL,
            CursoAsig SMALLINT,
            CoordinProfe SMALLINT,
            FOREIGN KEY (CoordinProfe)REFERENCES PROFESORES(CodProfe)
			ON DELETE CASCADE
            ON UPDATE CASCADE,
            FOREIGN KEY (CursoAsig)REFERENCES CURSOS(CodCurso)
            ON DELETE CASCADE
            ON UPDATE CASCADE
);
CREATE TABLE TELEFONO(
            TelefProfe NUMERIC(10,0),
            idProfe SMALLINT,
            PRIMARY KEY(TelefProfe, idProfe),
            FOREIGN KEY(idProfe) REFERENCES PROFESORES(CodProfe)
			ON DELETE CASCADE
            ON UPDATE CASCADE
);
CREATE TABLE ALUMNOS(
            CodAlum SMALLINT,
            NIFAlum CHAR(9),
            NomAlum VARCHAR(15) NOT NULL,
            ApeAlum VARCHAR(20) NOT NULL,
            DirPostAlum NUMERIC(6,0),
            DirCorrAlum VARCHAR(45),
            BecaAlum BINARY,
            PRIMARY KEY(CodAlum)
);
CREATE TABLE MATRICULA(
            idAsign NUMERIC(5,0),
            idAlum SMALLINT,
            Nota numeric(3,2),
            PRIMARY KEY(idAsign, idAlum),
            FOREIGN KEY(idAsign) REFERENCES ASIGNATURAS(CodAsig)
            ON DELETE CASCADE
            ON UPDATE CASCADE,
            FOREIGN KEY(idAlum) REFERENCES ALUMNOS(CodAlum)
			ON DELETE CASCADE
            ON UPDATE CASCADE
);
CREATE TABLE IMPARTE(
			idAsig NUMERIC(5,0),
            idProfe SMALLINT,
            PRIMARY KEY(idAsig, idProfe),
            FOREIGN KEY(idAsig) REFERENCES ASIGNATURAS(CodAsig)
			ON DELETE CASCADE
            ON UPDATE CASCADE,
            FOREIGN KEY(idProfe) REFERENCES PROFESORES(CodProfe)
			ON DELETE CASCADE
            ON UPDATE CASCADE
);
-- Insertamos datos a las tablas
-- Insertamos Cursos
INSERT INTO CURSOS VALUES (401, 'Primero', 6);
INSERT INTO CURSOS VALUES (402, 'Segundo',6);
INSERT INTO CURSOS VALUES (403, 'Tercero', 5);
INSERT INTO CURSOS VALUES (404, 'Cuarto', 4);
INSERT INTO CURSOS VALUES (405, 'Master', 3);
INSERT INTO CURSOS VALUES (406, 'Doctorado',1);
-- Insertamos Alumnos
INSERT INTO ALUMNOS VALUES (5647, '75486312', 'Carlos', 'Cuesta',47315,'carlos@alumnosucm.es', 1);
INSERT INTO ALUMNOS VALUES (5305, '78786305', 'Luis Angel', 'Palomo',43323,'luis.angel@alumnosucm.es', 1);
INSERT INTO ALUMNOS VALUES (8458, '72386982', 'Angela', 'Canzas',47822,'angela@alumnosucm.es', 1);
INSERT INTO ALUMNOS VALUES (9124, '78716617', 'Jose María', 'Martí',28024,'jose.maria@alumnosucm.es', 0);
INSERT INTO ALUMNOS VALUES (8142, '75486312', 'Carla ', 'Rodríguez',47315,'carla@alumnosucm.es', 1);
INSERT INTO ALUMNOS VALUES (5047, '75006312', 'Carlos', 'Cuesta',47315,'carlos@alumnosucm.es', 1);
INSERT INTO ALUMNOS VALUES (9856, '72147368', 'Luisa María', 'Dolores',27014,'luisa.maria@alumnosucm.es', 0);
INSERT INTO ALUMNOS VALUES (6844, '75486312', 'Carlos', 'Gómez',47315,'carlos@alumnosucm.es', 1);
INSERT INTO ALUMNOS VALUES (2948, '71399547', 'Maria Isabel', 'Puentes',28023,'maria.isabel@alumnosucm.es', 1);
INSERT INTO ALUMNOS VALUES (8785, '72249371', 'Abel', 'Ramos',30012,'abel@alumnosucm.es', 0);
INSERT INTO ALUMNOS VALUES (7455, '73151526', 'Miriam', 'Reyes',27450,'miriam@alumnosucm.es', 1);
INSERT INTO ALUMNOS VALUES (6941, '75486312', 'Julio', 'Carranza',47315,'carlos@alumnosucm.es', 1);
INSERT INTO ALUMNOS VALUES (9013, '76645620', 'Gerardo', 'Trecet',47315,'gerardo@alumnosucm.es', 0);
INSERT INTO ALUMNOS VALUES (5941, '72301508', 'Carolina', 'Martin',31069,'carolina@alumnosucm.es', 1);
INSERT INTO ALUMNOS VALUES (6467, '70064517', 'Pedro', 'Martos',26150,'pedro@alumnosucm.es', 1);
INSERT INTO ALUMNOS VALUES (3244, '75442810', 'Carlota', 'Méndez',47263,'carlota@alumnosucm.es', 1);
INSERT INTO ALUMNOS VALUES (8374, '72324864', 'Antonio', 'Lastres',27450,'antonio@alumnosucm.es', 0);
INSERT INTO ALUMNOS VALUES (5018, '79581584', 'Marcos', 'Costas',28023,'marcos@alumnosucm.es', 1);
INSERT INTO ALUMNOS VALUES (4862, '76493851', 'Lidia', 'Garzón',28024,'lidia@alumnosucm.es', 1);
INSERT INTO ALUMNOS VALUES (5459, '73132640', 'Lorena', 'Sastre',27014,'lorena@alumnosucm.es', 0);
INSERT INTO ALUMNOS VALUES (6233, '73205476', 'Carlos Maria', 'Bailen',47360,'carlos.maria@alumnosucm.es', 0);
INSERT INTO ALUMNOS VALUES (5439, 'E7862640', 'Fiona', 'Lezama',28024,'fiona@alumnosucm.es', 0);
-- Insertamos Profesores
INSERT INTO PROFESORES VALUES (0266, '76115896', 'Mariana', 'López',26351,'mariana@docentesucm.es', 'Catedrática de Universidad');
INSERT INTO PROFESORES VALUES (1662, '73151544', 'Alejandro', 'Karsten',30124,'alejandro@docentesucm.es', 'Catedrático de Escuela');
INSERT INTO PROFESORES VALUES (0317, '72648952', 'Conrado', 'Aguilar',27039,'conrado@docentesucm.es', 'Emérito');
INSERT INTO PROFESORES VALUES (2471, '71263043', 'Fernando', 'Arroita',33210,'fernando@docentesucm.es', 'Asociado');
INSERT INTO PROFESORES VALUES (3100, '71624146', 'Jaime', 'Arconada',33210,'jaime@docentesucm.es', 'Asociado Interino');
INSERT INTO PROFESORES VALUES (1354, '72325601', 'Ariadna', 'Malzas',36520,'ariadnae@docentesucm.es', 'Titulares de Escuela Universitaria');
INSERT INTO PROFESORES VALUES (0164, '71364200', 'Ricardo', 'Jauregui',36520,'ricardo@docentesucm.es', 'Catedrático de Universidad');
INSERT INTO PROFESORES VALUES (2634, '71642161', 'Hilario', 'González',29510,'hilario@docentesucm.es', 'Contratado Doctor');
INSERT INTO PROFESORES VALUES (3178, '71548263', 'Maria Cristina', 'Parton',33210,'maria.cristina@docentesucm.es', 'Ayudante Doctor');
INSERT INTO PROFESORES VALUES (1309, '72610278', 'Cristóbal', 'Domínguez',33210,'cristobal@docentesucm.es', 'Titulares de Escuela Universitaria');
INSERT INTO PROFESORES VALUES (3264, '71246125', 'Susana', 'Naín',26351,'susana@docentesucm.es', 'Asociada Interina');
INSERT INTO PROFESORES VALUES (2418, '75126421', 'Damian', 'Garces',33162,'damian@docentesucm.es', 'Asociado');
INSERT INTO PROFESORES VALUES (3216, '72012674', 'Rosa Mateo', 'García',33210,'rosa.mateo@docentesucm.es', 'Ayudante Doctor');
INSERT INTO PROFESORES VALUES (3614, '76431625', 'Laureano', 'Lima',29871,'laureano@docentesucm.es', 'PDI');
INSERT INTO PROFESORES VALUES (3268, '72518618', 'Paula', 'Masala',33210,'paula@docentesucm.es', 'Otro Investigador');
-- Insertamos Asignaturas
INSERT INTO ASIGNATURAS VALUES (45201, 'Fluido Mecánica', 'oblig', 6.0,2,402,1662);
INSERT INTO ASIGNATURAS VALUES (45202, 'Estructuras', 'oblig',6.0,2,402,0266);
INSERT INTO ASIGNATURAS VALUES (45211, 'Termodinámica', 'oblig',6.0,2,402,0317);
INSERT INTO ASIGNATURAS VALUES (45232, 'Mecánica', 'oblig',6.0,1,402,0317);
INSERT INTO ASIGNATURAS VALUES (45160, 'Ingeniería de Org industrial', 'oblig',4.5,1,401,0266);
INSERT INTO ASIGNATURAS VALUES (45248, 'Matemáticas II', 'oblig', 6.0,2,402,0266);
INSERT INTO ASIGNATURAS VALUES (45273, 'Electrotecnia', 'oblig', 4.5,2,402,1354);
INSERT INTO ASIGNATURAS VALUES (45131, 'Matemáticas I', 'oblig', 6.0,1,401,0164);
INSERT INTO ASIGNATURAS VALUES (45122, 'Dibujo Industrial', 'oblig', 6.0,1,401,2634);
INSERT INTO ASIGNATURAS VALUES (45154, 'Matemáticas I', 'oblig',6,1,401,0266);
INSERT INTO ASIGNATURAS VALUES (45187, 'Física I', 'oblig',6.0,2,401,1309);
INSERT INTO ASIGNATURAS VALUES (45100, 'Estadística', 'oblig',4.5,2,401,1354);
INSERT INTO ASIGNATURAS VALUES (45371, 'Ingeniería Económica', 'oblig',6.0,1,403,0164);
INSERT INTO ASIGNATURAS VALUES (45303, 'Sistemas de Gestión de la Empresa', 'opt',6.0,1,403,1354);
INSERT INTO ASIGNATURAS VALUES (45301, 'Dirección Empresa', 'oblig',6, 1,403,0317);
INSERT INTO ASIGNATURAS VALUES (45319, 'Practicas de empresa', 'oblig',6,2,403,0164);
INSERT INTO ASIGNATURAS VALUES (45348, 'Dirección Estratégica', 'opt',4.5,2,403,1309);
INSERT INTO ASIGNATURAS VALUES (45448, 'Ampliación de prácticas', 'opt',4.5,1,404,1309);
INSERT INTO ASIGNATURAS VALUES (45434, 'Competencias transversales', 'opt',4.5,2,404,0317);
INSERT INTO ASIGNATURAS VALUES (45408, 'Ampliación II practicas', 'opt',9,1,404,2418);
INSERT INTO ASIGNATURAS VALUES (45418, 'Trabajo de Fin de Grado', 'opt',12.5,2,404,0266);
INSERT INTO ASIGNATURAS VALUES (45534, 'Elasticidad I', 'oblig',6,1,405,3100);
INSERT INTO ASIGNATURAS VALUES (45588, 'Ingeniería del Transporte', 'opt',4.5,2,405,1309);
INSERT INTO ASIGNATURAS VALUES (45542, 'Trabajo de fin Master', 'oblig',16.5,2,405,0317);
INSERT INTO ASIGNATURAS VALUES (45680, 'Tesis doctorado', 'oblig',20,1,406,0164);
-- Insertamos Matricula
INSERT INTO MATRICULA VALUES (45201, 5305,5.30);
INSERT INTO MATRICULA VALUES (45201, 5647,3.21);
INSERT INTO MATRICULA VALUES (45202, 9856,7.75);
INSERT INTO MATRICULA VALUES (45303, 2948,3.75);
INSERT INTO MATRICULA VALUES (45202, 5439,5.05);
INSERT INTO MATRICULA VALUES (45211, 8785,5.00);
INSERT INTO MATRICULA VALUES (45160, 6844,9.75);
INSERT INTO MATRICULA VALUES (45131, 9013,7.55);
INSERT INTO MATRICULA VALUES (45201, 9856,4.95);
INSERT INTO MATRICULA VALUES (45273, 9013,6.7);
INSERT INTO MATRICULA VALUES (45273, 7455,5);
INSERT INTO MATRICULA VALUES (45187, 5647,6);
INSERT INTO MATRICULA VALUES (45122, 2948,5.30);
INSERT INTO MATRICULA VALUES (45122, 5018,2.75);
INSERT INTO MATRICULA VALUES (45371, 3244,8.75);
INSERT INTO MATRICULA VALUES (45202, 9013,5.2);
INSERT INTO MATRICULA VALUES (45301, 2948,7.7);
INSERT INTO MATRICULA VALUES (45232, 8785,4.2);
INSERT INTO MATRICULA VALUES (45232, 8142,5);
INSERT INTO MATRICULA VALUES (45232, 5305,6.4);
INSERT INTO MATRICULA VALUES (45187, 6844,5.05);
INSERT INTO MATRICULA VALUES (45187, 4862,5);
INSERT INTO MATRICULA VALUES (45187, 5459,6.25);
INSERT INTO MATRICULA VALUES (45187, 9124,7.6);
INSERT INTO MATRICULA VALUES (45100, 7455,9);
INSERT INTO MATRICULA VALUES (45100, 5018,5);
INSERT INTO MATRICULA VALUES (45100, 6467,3.2);
INSERT INTO MATRICULA VALUES (45348, 5047,5.4);
INSERT INTO MATRICULA VALUES (45348, 2948,6.5);
INSERT INTO MATRICULA VALUES (45348, 3244,6.5);
INSERT INTO MATRICULA VALUES (45303, 9013,7);
INSERT INTO MATRICULA VALUES (45303, 6844,8.9);
INSERT INTO MATRICULA VALUES (45303, 9856,6.85);
INSERT INTO MATRICULA VALUES (45248, 8142,4.5);
INSERT INTO MATRICULA VALUES (45248, 5647,5.5);
INSERT INTO MATRICULA VALUES (45248, 5018,8.7);
INSERT INTO MATRICULA VALUES (45319, 3244,9.3);
INSERT INTO MATRICULA VALUES (45319, 9124,7.8);
INSERT INTO MATRICULA VALUES (45319, 6467,8);
INSERT INTO MATRICULA VALUES (45319, 5459,7);
INSERT INTO MATRICULA VALUES (45434, 8142,7.9);
INSERT INTO MATRICULA VALUES (45434, 5439,6.6);
INSERT INTO MATRICULA VALUES (45371, 5647,6.45);
INSERT INTO MATRICULA VALUES (45371, 5439,9.9);
INSERT INTO MATRICULA VALUES (45202, 6233,3.3);
INSERT INTO MATRICULA VALUES (45434, 6233,9.3);
INSERT INTO MATRICULA VALUES (45534, 8142,9.2);
INSERT INTO MATRICULA VALUES (45434, 5047,8.8);
INSERT INTO MATRICULA VALUES (45201, 8785,3.8);
INSERT INTO MATRICULA VALUES (45202, 5047,4.8);
INSERT INTO MATRICULA VALUES (45211, 4862,4);
INSERT INTO MATRICULA VALUES (45211, 5305,5.9);
INSERT INTO MATRICULA VALUES (45408, 2948,7.25);
INSERT INTO MATRICULA VALUES (45534, 5647,5);
INSERT INTO MATRICULA VALUES (45418, 2948,8.6);
INSERT INTO MATRICULA VALUES (45418, 5439,7.5);
INSERT INTO MATRICULA VALUES (45418, 4862,7);
-- Insertamos Telefonos
INSERT INTO TELEFONO VALUES (633241870, 0266);
INSERT INTO TELEFONO VALUES (633241870, 1662);
INSERT INTO TELEFONO VALUES (654236892, 0317);
INSERT INTO TELEFONO VALUES (677496581, 2471);
INSERT INTO TELEFONO VALUES (698754124, 3100);
INSERT INTO TELEFONO VALUES (698754124, 1354);
INSERT INTO TELEFONO VALUES (633241870, 0164);
INSERT INTO TELEFONO VALUES (684150224, 2634);
INSERT INTO TELEFONO VALUES (684150224, 3178);
INSERT INTO TELEFONO VALUES (612345849, 1309);
INSERT INTO TELEFONO VALUES (612345849, 3264);
INSERT INTO TELEFONO VALUES (612345849, 2418);
INSERT INTO TELEFONO VALUES (612345849, 3216);
-- Insertamos Imparte
INSERT INTO IMPARTE VALUES (45534, 3614);
INSERT INTO IMPARTE VALUES (45434, 3268);

-- Insertamos datos extrernos a la base de datos
SELECT @@GLOBAL.secure_file_priv; /*establecemos el directorio donde importamos el archivo csv datosImporte*/
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/datosImparte.csv' -- cuidado con los /
INTO TABLE IMPARTE
FIELDS TERMINATED BY ';'
LINES TERMINATED BY '\n'
IGNORE 1 rows;

-- Trabajamos ahora con las consultas propias de las base de datos

-- 1)Asignaturas de Primer curso del primer cuatrimestre
SELECT NomAsig
FROM ASIGNATURAS
WHERE CursoAsig= '401' and CuatriAsig=1;

-- 2) Numero de asignaturas de las Asignaturas obligatorias del primer cuatrimestre
SELECT COUNT(DISTINCT(NomAsig)) AS totalAsignaturasCuatri1
FROM ASIGNATURAS INNER JOIN MATRICULA ON ASIGNATURAS.CodAsig=MATRICULA.idAsign
WHERE CaractAsig='oblig' and CuatriAsig=1;

-- 3) Nota media de los alumnos con nombre y apellidos matriculados en la asignaturas de segundo 
SELECT NomAlum, ApeAlum, ASIGNATURAS.CursoAsig, AVG(MATRICULA.Nota)
FROM ALUMNOS  INNER JOIN MATRICULA INNER JOIN ASIGNATURAS ON ALUMNOS.CodAlum=MATRICULA.idAlum
AND ASIGNATURAS.CodAsig= MATRICULA.idAsign
WHERE ASIGNATURAS.CursoAsig=402
GROUP BY CodAlum;

-- 4) Nombre de los profesores que son coordinadores, asignaturas y el curso sl que pertenece las asignatura 
SELECT NomProfe,  CURSOS.NomCurso, NomAsig 
FROM CURSOS  INNER JOIN ASIGNATURAS INNER JOIN PROFESORES ON CURSOS.CodCurso=ASIGNATURAS.CursoAsig
AND PROFESORES.CodProfe=ASIGNATURAS.CoordinProfe
GROUP BY NomAsig;

-- 5) Nota media de alumnos suspensos a lo largo de la carrera
SELECT NomAlum,  ApeAlum, AVG(MATRICULA.Nota) AS NotaMedia
FROM ALUMNOS  INNER JOIN MATRICULA INNER JOIN ASIGNATURAS  ON ALUMNOS.CodAlum=MATRICULA.idAlum
AND ASIGNATURAS.CodAsig=MATRICULA.idAsign
GROUP BY CodAlum
HAVING NotaMedia<5;

-- 6) Ordenar de manera ascendente las asignaturas  de cada curso 
SELECT DISTINCT(NomCurso) ,COUNT(ASIGNATURAS.NomAsig) AS TotalAsignaturas
FROM CURSOS INNER JOIN ASIGNATURAS  INNER JOIN MATRICULA ON CURSOS.CodCurso=ASIGNATURAS.CursoAsig
AND ASIGNATURAS.CodAsig=MATRICULA.idAsign 
GROUP BY NomCurso
ORDER BY TotalAsignaturas ASC;

-- 7) Nota ordenada de mayor a menor, junto con nombre apellido y dni de cada uno de los alumnos que tienen beca
SELECT NomAlum,NIFAlum, ApeAlum, AVG(Nota) AS NotaMediaBeca
FROM ALUMNOS INNER JOIN  MATRICULA ON ALUMNOS.CodAlum= MATRICULA.idAlum
WHERE MATRICULA.idAlum  IN (select CodAlum
					from ALUMNOS
                    where BecaAlum=0)
GROUP BY NomAlum
ORDER BY NotaMediaBeca DESC;

-- 8) Total de asignaturas que coordinan cada uno de los profesores
SELECT NomProfe, NIFProfe, ApeProfe, COUNT(ASIGNATURAS.CodAsig) AS TotalAsigCoordin
FROM PROFESORES LEFT JOIN ASIGNATURAS ON PROFESORES.CodProfe= ASIGNATURAS.CoordinProfe
GROUP BY CodProfe;

-- 9) Las mejores y peores notas de las asignaturas 
SELECT NomAsig, ALUMNOS.NomAlum,MAX(MATRICULA.Nota)AS MinAsig, MIN(MATRICULA.Nota)AS MaxAsig
FROM ASIGNATURAS INNER JOIN MATRICULA  INNER JOIN ALUMNOS ON ASIGNATURAS.CodAsig= MATRICULA.idAsign 
AND ALUMNOS.CodAlum= MATRICULA.idAlum
GROUP BY NomAsig;

-- 10) Consulta el número de teléfono de profesores que no sean Catedrácticos
SELECT idProfe, TelefProfe
FROM TELEFONO 
WHERE idProfe IN (SELECT CodProfe
				FROM PROFESORES
                WHERE CategProfe NOT LIKE 'Catedratico%');

-- 11) Seleccionar las asignaturas, con id de la asignatura con calificaciones entre 1 y 4.75
SELECT CodAsig, NomAsig, MATRICULA.Nota
FROM ASIGNATURAS INNER JOIN MATRICULA ON ASIGNATURAS.codAsig=MATRICULA.idAsign
WHERE CaractAsig='oblig'and MATRICULA.Nota BETWEEN 1 AND 4.75;

-- 12) Agrupar por cursos el numero total de creditos por cursos 
SELECT CodCurso, NomCurso, SUM(ASIGNATURAS.NumCredAsig)
FROM CURSOS INNER JOIN ASIGNATURAS ON CURSOS.CodCurso=ASIGNATURAS.CursoAsig
GROUP BY NomCurso;

-- 14) Alumnos que se han matriculado al menos de una asignatura de cuarto
SELECT NomAlum, NIFAlum, COUNT(DISTINCT idAsign) AS totAsigAlum
FROM ALUMNOS INNER JOIN MATRICULA ON ALUMNOS.CodAlum=MATRICULA.idAlum
GROUP BY CodAlum
HAVING totAsigAlum = (SELECT COUNT(CodAsig)
					FROM ASIGNATURAS
                    WHERE CursoAsig= 404);
-- 15) Datos principales: código, NIF, correo de los profesores que no sean coordinadores
SELECT CodProfe, NomProfe, NIfProfe, DirPostProfe
FROM PROFESORES 
WHERE NOT EXISTS(SELECT*
				FROM ASIGNATURAS 
                WHERE PROFESORES.CodProfe = ASIGNATURAS.CoordinProfe);

-- 16) Mostrar el total de alumnos matriculados y número de creditos por curso y cuatrimestre cursado
SELECT  DISTINCT(ASIGNATURAS.CursoAsig),SUM(ASIGNATURAS.NumCredAsig) AS totalCredi, COUNT(ALUMNOS.CodAlum) AS totalAlum
FROM ALUMNOS INNER JOIN MATRICULA INNER JOIN ASIGNATURAS ON ALUMNOS.CodAlum= MATRICULA.idAlum
AND ASIGNATURAS.CodAsig = MATRICULA.idAsign
GROUP BY ASIGNATURAS.CursoAsig, ASIGNATURAS.CuatriAsig  ;


