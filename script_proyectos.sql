/**************************************************************************/
/*Este script SQL crea la base de datos proyectosx y todas sus tablas*/
/*************************************************************************/
\c postgres
/*Borramos, si existe, una base de datos anterior */
DROP DATABASE IF EXISTS proyectos;

/*Creamos la base de datos llamada gestionproyectos */
CREATE DATABASE proyectos;

/*Seleccionamos la BD por defecto*/
\c proyectos;

/***********************/
/* TABLA: departamento */
/***********************/
CREATE TABLE IF NOT EXISTS departamento (
  cddep CHAR(2) PRIMARY KEY,
  nombre VARCHAR(30) UNIQUE,
  ciudad VARCHAR(20)
);

/***********************/
/* TABLA: empleado     */
/***********************/
CREATE TABLE empleado (
  cdemp CHAR(3) PRIMARY KEY,
  nombre VARCHAR(30),
  fecha_ingreso DATE,
  salario DECIMAL(6,2),
  cdjefe CHAR(3),
  cddep CHAR(2),
  CONSTRAINT EMP_DEP_FK FOREIGN KEY(cddep) REFERENCES departamento(cddep) ON DELETE RESTRICT ON UPDATE CASCADE ,
  CONSTRAINT EMP_EMP_FK FOREIGN KEY (cdjefe) REFERENCES empleado(cdemp) ON DELETE SET NULL ON UPDATE CASCADE 
);

/***********************/
/* TABLA: proyecto     */
/***********************/
CREATE TABLE proyecto (
  cdpro CHAR(3) PRIMARY KEY,
  nombre VARCHAR(30) UNIQUE,
  cddep CHAR(2),
  CONSTRAINT PRO_DEP_FK FOREIGN KEY(cddep) REFERENCES departamento(cddep) ON DELETE RESTRICT ON UPDATE CASCADE 
);

/***********************/
/* TABLA: trabaja      */
/***********************/
CREATE TABLE trabaja (
  cdemp CHAR(3),
  cdpro CHAR(3),
  nhoras SMALLINT DEFAULT 0,
  CONSTRAINT TRA_PK PRIMARY KEY (cdemp,cdpro),
  CONSTRAINT TRA_EMP_FK FOREIGN KEY (cdemp) REFERENCES empleado(cdemp) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT TRA_PRO_FK FOREIGN KEY (cdpro) REFERENCES proyecto(cdpro) ON DELETE CASCADE ON UPDATE CASCADE 
);

/****************************************************************************************
Estas sentencias SQL insertan en las tablas de proyectosx un conjunto de datos de prueba
****************************************************************************************/

/***********************/
/* TABLA: departamento */
/***********************/
INSERT INTO departamento
(cddep,nombre,ciudad) VALUES ('01','Contabilidad-1','Almería'),
 ('02','Ventas','Sevilla'), ('03','I+D','Málaga'), ('04','Gerencia','Córdoba'),
 ('05','Administración','Córdoba'),('06','Contabilidad-2','Córdoba'), ('07','Marketing','Granada');


/***********************/
/* TABLA: empleado     */
/***********************/
INSERT INTO empleado
(cdemp,nombre,fecha_ingreso,salario,cdjefe,cddep) VALUES ('A11','Esperanza Amarillo','1993-09-23',3000,NULL,'04'),
('A03','Pedro Rojo','1995-03-07',2000,'A11','01'), ('C01','Juan Rojo','1997-02-03',1800,'A03','01'),
('B02','María Azul','1996-01-09',1450,'A03','01'),('A07','Elena Blanco','1994-04-09',2000,'A11','02'),
('B06','Carmen Violeta','1997-02-03',2200,'A07','02'),('C05','Alfonso Amarillo','1998-12-03',2000,'B06','02'),
('B09','Pablo Verde','1998-10-12',1600,'A11','03'),('C04','Ana Verde',NULL,2000,'A07','02'),
('C08','Javier Naranja',NULL,1680,'B09','03'),('A10','Dolores Blanco','1998-11-15',1900,'A11','04'),
('B12','Juan Negro','1997-02-03',1900,'A11','05'),('A13','Jesús Marrón','1999-02-21',2200,'A11','05'),
('A14','Manuel Amarillo','2000-09-01',2000,'A11',NULL);


/***********************/
/* TABLA: proyecto     */
/***********************/
INSERT INTO proyecto
(cdpro,nombre,cddep) VALUES ('GRE','Gestión de residuos','03');
INSERT INTO proyecto
(cdpro,nombre,cddep) VALUES ('DAG','Depuración de aguas','03');
INSERT INTO proyecto
(cdpro,nombre,cddep) VALUES ('AEE','Análisis económico energías','04');
INSERT INTO proyecto
(cdpro,nombre,cddep) VALUES ('MES','Marketing de energía solar','02');


/***********************/
/* TABLA: trabaja      */
/***********************/
INSERT INTO trabaja
(cdemp,cdpro,nhoras) VALUES ('C01','GRE',10);
INSERT INTO trabaja
(cdemp,cdpro,nhoras) VALUES ('C08','GRE',54);
INSERT INTO trabaja
(cdemp,cdpro,nhoras) VALUES ('C01','DAG',5);
INSERT INTO trabaja
(cdemp,cdpro,nhoras) VALUES ('C08','DAG',150);
INSERT INTO trabaja
(cdemp,cdpro,nhoras) VALUES ('B09','DAG',100);
INSERT INTO trabaja
(cdemp,cdpro,nhoras) VALUES ('A14','DAG',10);
INSERT INTO trabaja
(cdemp,cdpro,nhoras) VALUES ('A11','AEE',15);
INSERT INTO trabaja
(cdemp,cdpro,nhoras) VALUES ('C04','AEE',20);
INSERT INTO trabaja
(cdemp,cdpro,nhoras) VALUES ('A11','MES',0);
INSERT INTO trabaja
(cdemp,cdpro,nhoras) VALUES ('A03','MES', 0);
