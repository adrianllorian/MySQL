create database GUARDERIA;
use GUARDERIA;

create table GUARDERIAS(
COD_GUARDERIA int auto_increment,
NOMBRE        varchar(20),
DIRECCION     varchar(100),
LOCALIDAD     varchar(20),
CONSTRAINT PK_GUARDERIAS
  PRIMARY KEY (COD_GUARDERIA)
)engine = innodb;

create table CUIDADORES(
 COD_CUIDADOR int auto_increment,
 NOMBRE       varchar(20),  
 APELLIDOS    varchar(50),
 FECHA_ALTA   date,
 DIRECCION    varchar(100),
 POBLACION    varchar(20),  
 DNI          varchar (9) unique,
 TITULO       varchar(20),  
 CATEGORIA    varchar(20),
 CONSTRAINT PK_CUIDADORES
    PRIMARY KEY (COD_CUIDADOR)
 )engine = innodb;

create table COMEDORES(
COD_COMEDOR   int auto_increment,
CAPACIDAD     int,
RANGO         varchar (20),
COD_GUARDERIA int,
CONSTRAINT FK_COME_GUARD
    FOREIGN KEY(COD_GUARDERIA)
		REFERENCES GUARDERIAS (COD_GUARDERIA),
CONSTRAINT PK_COMEDORES
    PRIMARY KEY(COD_COMEDOR,COD_GUARDERIA)
)engine = innodb;

create table PADRES(
COD_PADRE    	int auto_increment,
DNI           	varchar (9) unique,
NOMBRE_PADRE  	varchar (20),
APELLIDOS_PADRE varchar (50),
DIRECCION     	varchar (100),
TELEFONO      	varchar (9),
CONSTRAINT PK_PADRE
    PRIMARY KEY(COD_PADRE)
)engine = innodb;

create table NIÑOS(
COD_MATRICULA int auto_increment,
NOMBRE_NIÑO   varchar(20),
APELLIDOS     varchar(50),
FECHA_NAC     date,
CUOTA         float (4.2),
NUM_HERMANOS  int,
COD_GUARDERIA int,
COD_PADRE     int,
CONSTRAINT PK_NIÑOS
    PRIMARY KEY (COD_MATRICULA),
CONSTRAINT FK_NIÑO_GUARD
    FOREIGN KEY(COD_GUARDERIA)
		REFERENCES GUARDERIAS (COD_GUARDERIA),
CONSTRAINT FK_NIÑO_PADRE
    FOREIGN KEY(COD_PADRE)
		REFERENCES PADRES (COD_PADRE)
)engine = innodb;

create table ENFERMEDADES(
COD_ENFERMEDAD    int auto_increment,
NOMBRE_ENF        varchar(20) unique,
SINTOMAS          varchar(250),
DURACION_PROBABLE varchar(50),
CONSTRAINT PK_ENFERMEDADES
    PRIMARY KEY (COD_ENFERMEDAD)
)engine = innodb;


create table USA(
MATRICULA_NIÑO  int,
MES      VARCHAR(20),
COD_COMEDOR     int,
CONSTRAINT FK_NIÑO_USA
    FOREIGN KEY(MATRICULA_NIÑO)
		REFERENCES NIÑOS (COD_MATRICULA),
CONSTRAINT FK_COME_USA
    FOREIGN KEY(COD_COMEDOR)
		REFERENCES COMEDORES(COD_COMEDOR),
CONSTRAINT PK_USA
    PRIMARY KEY (MATRICULA_NIÑO)
)engine = innodb;

create table SUFRE(
MATRICULA_NIÑO  int,
COD_ENFERMEDAD  int,
FECHA           date,
CONSTRAINT FK_NIÑO_SUFRE
    FOREIGN KEY(MATRICULA_NIÑO)
		REFERENCES NIÑOS (COD_MATRICULA),
CONSTRAINT FK_ENF_SUFRE
    FOREIGN KEY(COD_ENFERMEDAD)
		REFERENCES ENFERMEDADES (COD_ENFERMEDAD),
CONSTRAINT PK_SUFRE
    PRIMARY KEY (MATRICULA_NIÑO, COD_ENFERMEDAD)
)engine = innodb;

create table TRABAJA(
COD_COMEDOR  int,
COD_CUIDADOR int,
FECHA        date,
CONSTRAINT FK_COME_TRAB
    FOREIGN KEY(COD_COMEDOR)
		REFERENCES COMEDORES (COD_COMEDOR),
CONSTRAINT FK_CUIDA_TRAB
    FOREIGN KEY(COD_CUIDADOR)
		REFERENCES CUIDADORES (COD_CUIDADOR),
CONSTRAINT PK_TRABAJA
  PRIMARY KEY (COD_COMEDOR, COD_CUIDADOR, FECHA)
)engine = innodb;

############################################################################################################################################################

/* EJERCICIO 1 */
DELIMITER $$;
create event NIÑOS_POR_COMEDOR
  on schedule every 1 month
  starts '2019-01-01 00:00:00'
    do
      begin
        select concat( 'Fecha: ', curdate());
        select COD_GUARDERIA 'COD. GUARDERÍA', COD_COMEDOR 'COD. COMEDOR', CONCAT(NOMBRE, APELLIDOS) 'NOMBRE Y APELLIDOS', 
          timestampdiff(year, FECHA_NAC, curdate()) 'EDAD' FROM NIÑOS;
      end;$$



/* EJERCICIO 2 */
DELIMITER $$;
create function EJERCICIO2A(v_edad int, v_enfermedad varchar(20))
  returns integer
  begin
    declare num_niños int;
    select count(COD_MATRICULA) into num_niños
    from NIÑOS INNER JOIN SUFRE S ON N.COD_MATRICULA=S.COD_MATRICULA
    INNER JOIN ENFERMEDADES E ON P.COD_ENFERMEDAD=E.COD_ENFERMEDAD
    where v_enfermedad=E.NOMBRE and v_edad = timestampdiff(year,FECHA_NAC, curdate());
    return num_niños;
  end;$$


create procedure EJERCICIO2B(v_edad int, v_enfermedad varchar(20))
begin
  declare num_niños int;
  SELECT EJERCICIO2A(v_edad, v_enfermedad) INTO num_niños;  
  IF(num_niños=0) THEN
    SELET CONCAT('NO HAY NIÑOS CON ', v_edad,' AÑOS QUE LA HAYAN PADECIDO');
  ELSE THEN
    SELET CONCAT('HAY ',num_niños,' NIÑOS CON ', v_edad,' AÑOS QUE LA HAYAN PADECIDO');
  END IF;
end$$


/* EJERCICIO 3 */
DELIMITER $$;
create procedure Alta_trabajador
  (v_COD_CUIDADOR int, v_NOMBRE varchar(20), v_APELLIDOS varchar(50), v_FECHA_ALTA date, v_DIRECCION varchar(100),
					v_POBLACION varchar(20), v_DNI varchar(9), v_TITULO varchar(20), v_CATEGORIA varchar(20), v_COD_GUARDERIA int)
begin
  declare exit handler for 1602 select concat ('Error, el trabajador con DNI ',v_DNI,' ya existe');
  insert into CUIDADORES values (v_COD_CUIDADOR, v_NOMBRE, v_APELLIDOS, v_FECHA_ALTA, v_DIRECCION , v_POBLACION, v_DNI, v_TITULO, v_CATEGORIA, v_COD_GUARDERIA);
	select concat('El trabajador de DNI ' ,v_DNI, ' se ha dado de alta') as 'CONFIRMACIÓN';
end;$$
