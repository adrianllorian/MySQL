create database ONG;
use ONG;
create table Asociaciones(
Codigo_asociacion int primary key,
CIF varchar(50) unique,
Denominacion varchar(50),
Direccion varchar(50),
Provincia varchar(50),
Tipo varchar(50),
Declarada enum('Si','No')
)

Engine=InnoDB;


create table Socios (
Codigo_socios int primary key,
DNI varchar(50) unique,
Nombre varchar(50),
Direccion varchar(50),
Provincia varchar(50),
Cuota_mes float,
Codigo_asociacion int,
foreign key (Codigo_asociacion) references Asociaciones (Codigo_asociacion)
)
Engine = innoDB;

create table Proyectos(
Codigo_proyecto int primary key,
Pais varchar(50),
Zona varchar(50),
Objetivo varchar(50),
N_Beneficiarios varchar(50),
Codigo_asociacion int,
foreign key (Codigo_asociacion) references Asociaciones (Codigo_asociacion)
)
Engine innoDB;

create table Trabajadores (
Codigo_trabajador int primary key,
DNI varchar(50),
Nombre varchar(50),
Tipo varchar(50),
Fecha_alt date,
Codigo_asociacion int,
Jefe int,
foreign key (Codigo_asociacion) references Asociaciones (Codigo_asociacion)
)
Engine = InnoDB;


create table Trabaja(
Codigo_trabajador int,
Codigo_proyecto int,
Fecha_alt date,
foreign key (Codigo_trabajador) references Trabajadores(Codigo_trabajador),
foreign key (Codigo_proyecto) references Proyectos(Codigo_proyecto),
primary key(Codigo_trabajador, Codigo_proyecto)
)
engine=innoDB;

create table Patrocinadores(
Codigo_patrocinador int primary key,
Nombre varchar(50),
Direccion varchar(50),
Pais varchar(50),
Telefono int,
Codigo_proyecto int,
foreign key (Codigo_proyecto) references Proyectos(Codigo_proyecto)
)
Engine=innoDB;


create table Voluntario(
Codigo_trabajador int,
Fecha_nac date,
Profesion varchar(50),
Horas_trabajadas int,
foreign key (Codigo_trabajador) references Trabajadores (Codigo_trabajador),
primary key (Codigo_trabajador)
)
Engine=InnoDB;


create table Asalariado(
Codigo_trabajador int,
Sueldo float,
Cargo varchar(50),
Pago_SS float,
Desc_IRPF float,
foreign key (Codigo_trabajador) references Trabajadores (Codigo_trabajador),
primary key (Codigo_trabajador)
)
Engine=InnoDB;
#drop database ONG;

#SET GLOBAL log_bin_trust_function_creators = 1;

insert into asociaciones values (0001, 'P72464378', 'Asuntos Sociales', 'C/Uria Oviedo', 'Asturias','Ecologista','SI'),
                                (0002, 'Q92566935', 'Animalistas', 'C/ Alcalá Madrid', 'Madrid','Funcionario','NO'),
                                (0003, 'R54689001', 'Cambio Climatico', 'C/Estafeta Pamplona', 'Navarra','Desarrollo','SI'),
                                (0004, 'H23860395', 'Desnutricion infantil', 'C/Ramblas Barcelona', 'Cataluña','Integracion','SI'),
                                (0005, 'G34596045', 'Anti-taurinos', 'C/Ave. Angel Nieto Jerez', 'Andalucia','PerroFaluta','NO');




insert into socios values (0010, '54679403P', 'Pedro', 'C/ Alfonso Madrid', 'Madrid', 10, 0002 ),
							(0011, '38495069S', 'Monica', 'C/ Lavapies Madrid', 'Madrid', 12, 0002 ),
							(0012, '19378563Z', 'Isabel', 'C/ Puerta del sol Madrid', 'Madrid', 5, 0002 ),
							(0020, '46903928Q', 'Maria', 'C/ San Antonio Siero', 'Asturias', 8, 0001 ),
							(0021, '12949583S', 'Jorge', 'C/ Cimadevilla Gijon', 'Asturias', 7, 0001 ),
							(0022, '12948573D', 'Carlos', 'C/ Ronda Aviles', 'Asturias', 3, 0001 ),
							(0030, '45970395A', 'Juan', 'C/ Gaudi Barcelona', 'Cataluña', 8, 0004 ),
							(0031, '36274969C', 'Fran', 'C/ Camp Nou Barcelona', 'Cataluña', 4, 0004 ),
							(0032, '96049834H', 'Carolina', 'C/ Gevara Barcelona', 'Cataluña', 12, 0004 ),
							(0040, '54679403B', 'Pedro', 'C/ Telefonica Pamplona', 'Navarra', 9, 0003 ),
							(0041, '54679404B', 'Galgo', 'C/ Qvebedo Pamplona', 'Navarra', 5, 0003 ),
							(0042, '54679405B', 'Pedro', 'C/ Txurrua Pamplona', 'Navarra', 5, 0003 ),
							(0050, '48569403R', 'Javier', 'C/ Carrero Jerez', 'Andalucia', 3, 0005 ),
							(0051, '68304986U', 'Ana', 'C/ Federico Sevilla', 'Andalucia', 3, 0005 ),
							(0052, '12436487I', 'Lucia', 'C/ Garcia Lorca Cordoba', 'Andalucia', 3, 0005 );





insert into proyectos values(0100, 'España', 'Peninsula iberica', 'Terminar con las corridas de toros', 50, 0005 ),
							(0200, 'Mozanbique', 'Zona Norte', 'Terminar con la desnutricion infantil', 1300, 0004 ),
							(0300, 'Territorio de la OTAN', 'Europa', 'Terminar con la geoingenieria', 500000000, 0003 ),
							(0400, 'Bolivia', 'Peninsula iberica', 'Terminar con las cazerias', 400000, 0002 ),
							(0500, 'España', 'Asturias', 'Dar servicio a las personas con alguna necesidad', 700, 0001 );



insert into trabajadores values (1000,'34859694Y', 'Marcelino', 'Asalariado', '2010-2-20', 0001, 1000),
								(1100,'90969392X', 'Paco', 'Asalariado', '2002-10-24', 0002, 1100),
								(1200,'40294858J', 'Pepa', 'Asalariado', '2011-4-4', 0002, 1100),
								(1300,'34675656Q', 'Jimena', 'Asalariado', '2012-1-2', 0002, 1100),
								(1400,'96837492J', 'Felipe', 'Asalariado', '2005-7-9', 0002, 1100),
								(1500,'96837494J', 'Carla', 'Voluntario', '2007-8-29', 0002, 1100),
								(1600,'30495858V', 'Patricia', 'Voluntario', '2016-7-2', 0002, 1100),
								(1700,'95858393N', 'Covadonga', 'Voluntario', '2006-9-12', 0002, 1100),
								(1800,'23034545F', 'Federica', 'Voluntario', '2016-3-23', 0002, 1100),
								(1900,'34696963R', 'Laura', 'Voluntario', '2012-7-6', 0002, 1100),
                                (2000,'28447589H', 'Gonzalo', 'Asalariado', '2012-6-13', 0001, 2000 ),
								(2100,'93948857N', 'Carmen', 'Asalariado', '2011-3-1', 0003, 2000),
								(2200,'49558584C', 'Dolores', 'Asalariado', '2016-7-13', 0003, 2000),
								(2300,'93848475Z', 'Victor', 'Asalariado', '2015-8-23', 0003, 2000),
								(2400,'10293948M', 'David', 'Asalariado', '2009-11-8', 0003, 2000),
								(2500,'54656565H', 'Eva', 'Voluntario', '2012-4-1', 0003, 2000),
								(2600,'44545653U', 'Fernanda', 'Voluntario', '2013-5-4', 0003, 2000),
								(2700,'64552544C', 'Dolores', 'Voluntario', '2016-7-13', 0003, 2000),
								(2800,'63232384X', 'Dolores', 'Voluntario', '2010-6-1', 0003, 2000),
								(2900,'67484834D', 'Paul', 'Asalariado', '2013-8-11', 0004, 2900),
								(3000,'44555434X', 'Mercedes', 'Asalariado', '2016-7-11', 0004, 2900),
								(3100,'12343467Y', 'Toni', 'Asalariado', '2012-5-11', 0004, 2900),
								(3200,'23233344J', 'Faustino', 'Asalariado', '2009-3-11', 0004, 2900),
								(3300,'79594300V', 'Boris', 'Asalariado', '2003-6-10', 0004, 2900),
								(3400,'58394854U', 'Heidi', 'Voluntario', '2015-7-15', 0004, 2900),	
								(3500,'58394852U', 'Manuel', 'Voluntario', '2012-8-14', 0004, 2900),
								(3600,'34959683N', 'Julia', 'Voluntario', '2011-8-23', 0004, 2900),
								(3700,'58394856U', 'Iñaki', 'Voluntario', '2013-6-12', 0004, 2900),
								(3800,'57393493B', 'Ylenia', 'Voluntario', '2016-2-18', 0004, 2900),
								(3900,'84749394U', 'Pablo', 'Asalariado', '2005-12-30', 0005,3900 ),
								(4000,'48586955V', 'Jesus', 'Voluntario', '2015-7-15', 0005, 3900),
								(4100,'37485859W', 'Lucia', 'Asalariado', '2005-12-30', 0005,3900 ),
								(4200,'75758696P', 'Ana', 'Asalariado', '2005-12-30', 0005,3900 ),
								(4300,'75869694G', 'Maneula', 'Asalariado', '2003-12-12', 0005,3900),
								(4400,'45969603L', 'Steve', 'Voluntario', '2002-2-3', 0005,3900),
								(4500,'96859595R', 'Urbano', 'Voluntario', '2012-1-2', 0005,3900),
								(4600,'75869696G', 'Ulises', 'Voluntario', '2012-1-1', 0005,3900),
								(4700,'76868944Y', 'Federica', 'Voluntario', '2011-8-9', 0005,3900),
								(4800,'56387384Y', 'Fernando', 'Voluntario', '2016-7-7', 0005,3900),
                                (4900,'64552544T', 'Dolores', 'Voluntario', '2017-12-24', 0003, 3900),
                                (5000,'69740402C', 'Lola', 'Voluntario', '2006-9-12', 0002, 1100),
                                (5100,'40394859C', 'Lucia', 'Asalariado', '2006-9-12', 0003, 2000),
                                (5200,'48596940Z', 'Hector', 'Asalariado', '2010-2-24', 0001, 1000 ),
                                (5300,'20496848B', 'Federico', 'Asalariado', '2012-8-13', 0001, 1000 ),
								(5400,'12875969J', 'Ubrique', 'Asalariado', '2010-5-2', 0001, 1000 ),
								(5500,'68939287X', 'Marcelino', 'Voluntario', '2008-3-14', 0001, 1000),
								(5600,'68494986V', 'Cristina', 'Voluntario', '2007-9-4', 0001, 1000),
								(5700,'23343545X', 'Macarena', 'Voluntario', '2008-7-7', 0001, 1000),
								(5800,'74859394W', 'Manolo', 'Voluntario', '2008-3-14', 0001, 1000),
                                (5900,'48586949V', 'Jesus', 'Voluntario', '2015-7-15', 0005, 3900);


insert into voluntario values (4000,'1988-4-12', 'Carpintero',22),
                                (5000,'1985-5-1', 'Carnicero',149),
                                (3300,'1983-9-23', 'Gasolinero',22),
                                (5500,'1981-2-2', 'Camarero',43),
                                (1500,'1979-12-8', 'DJ',90),
                                (1600,'1983-9-11', 'Fontanero',697),
                                (1700,'1982-8-12', 'Torero',242),
                                (1800,'1987-10-22', 'Gandero',234),
                                (1900,'1986-12-9', 'Cantante',45),
                                (2600,'1980-2-2', 'Gasolinero',28),
                                (2700,'1958-9-14', 'En paro',743),
                                (2800,'1969-8-12', 'Jubilado',422),
                                (4900,'1982-8-13', 'Payaso',454),
                                (3400,'1985-10-1', 'Pizzero',232),
                                (3500,'1986-6-13', 'Albañil',344),
                                (3600,'1990-10-22', 'Informática',432),
                                (3700,'1980-12-22', 'Comercial',563),
                                (3800,'1992-9-22', 'En paro',222),
                                (4400,'1992-7-4', 'Ingeniero',12),
                                (4500,'1980-10-13', 'Policia',65),
                                (4600,'1982-8-12', 'Bombero',35),
                                (4700,'1980-12-13', 'Minero',374),
                                (4800,'1991-2-22', 'Piloto',22),
                                (2500,'1993-6-4', 'Camarero', 344),
								(5600,'1985-8-28', 'Camarero', 50),
								(5700,'1990-3-7', 'Pizzero', 100),
								(5800,'1983-9-21', 'Carpintero', 600);
                                


insert into asalariado values (1000,1200, 'Jefe',80,100),
                                (2000,1300, 'Secretario',80,100),
                                (3000,1200, 'Trabajador',80,100),
                                (4000,1200, 'Tesorero',80,100),
								(5100,1500, 'Trabajador',80,100),
                                (5200,900, 'Secretario',80,100),
                                (5300,1000, 'Trabajador',80,100),
								(5400,1200, 'Trabajador',80,100),
                                (2900,950, 'Tesorero',80,100),
								(3100,1200, 'Tesorero',80,100),
								(3200,900, 'Secretario',80,100),
								(3300,900, 'Secretario',80,100),
								(1100,1000, 'Jefe',80,100),
								(1200,900, 'Trabajador',80,100),
								(1300,900, 'Jefe',80,100),
								(1400,1000, 'Trabajador',80,100),
								(2100,1000, 'Trabajador',80,100),
								(2200,1000, 'Trabajador',80,100),
								(2300,1200, 'Jefe',80,100),
								(2400,1000, 'Tesorero',80,100),
								(4100,900, 'Trabajador',80,100),
								(4200,900, 'Trabajador',80,100),
								(4300,1200, 'Trabajador',80,100),
								(3900,1200, 'Jefe',80,100);


insert into patrocinadores values (0088, 'Alimentación Antonio', 'Pol. Ind. Vallecas Madrid', 'España', 937452373, 0200),
									(0077, 'Amigos del Lobo', 'Av. Constitución León','Bolivia', 945345345, 0400),
									(0066, 'Hipermercado SuperSol', 'C/ del Cristo Málaga', 'España', 952054057, 0300);
                                


insert into trabaja values      (1000,0100,  '2010-2-20'),
                                (1100,0100,  '2012-6-13'),
                                (1200,0100,     '2010-2-24'),
                                (1300,0100,  '2012-8-13'),
                                (1400,0100,  '2010-5-2'),
                                (1500,0100,  '2008-3-14'),
                                (1600,0100,  '2007-9-4'),
                                (1700,0100,  '2008-7-7'),
                                (1800,0100,  '2008-3-14'),
                                (1900,0200,  '2002-10-24'),
                                (2000,0200,  '2006-9-12'),
                                (2100,0200,  '2011-4-4'),
                                (2200,0200,  '2012-1-2'),
                                (2300,0200,  '2005-7-9'),
                                (2400,0200,  '2007-8-29'),
                                (2500,0200,  '2016-7-2'),
                                (2600,0200,  '2006-9-12'),
                                (2700,0200,  '2016-3-23'),
                                (2800,0200,  '2012-7-6'),
                                (2900,0300,  '2006-9-12'),
                                (3000,0300,  '2011-3-1'),
                                (3100,0300,  '2016-7-13'),
								(3200,0300,  '2015-8-23'),
                                (3300,0300,  '2009-11-8'),
                                (3400,0300,  '2012-4-1'),
                                (3500,0300,  '2013-5-4'),
                                (3600,0300,  '2016-7-13'),
                                (3700,0300,  '2017-12-24'),
                                (3800,0300,  '2010-6-1'),
                                (3900,0400,  '2013-8-11'),
                                (4000,0400,  '2016-7-11'),
                                (4100,0400,  '2012-5-11'),
                                (4200,0400,  '2009-3-11'),
                                (4300,0400,  '2003-6-10'),
                                (4400,0400,  '2015-7-15'),
                                (4500,0400,  '2012-8-14'),
                                (4600,0400,  '2011-8-23'),
                                (4700,0400,  '2013-6-12'),
                                (4800,0400,  '2016-2-18'),
                                (4900,0500,  '2005-12-30'),
								(5000,0500,  '2015-7-15'),
                                (5100,0500,  '2005-12-30'),
                                (5200,0500,  '2005-12-30'),
                                (5300,0500,  '2003-12-12'),
                                (5400,0500,  '2002-2-3'),
                                (5500,0500,  '2012-1-2'),
                                (5600,0500,  '2012-1-1'),
                                (5700,0500,  '2011-8-9'),
                                (5800,0500,  '2016-7-7'),
                                (5900,0500,  '2015-7-3');

#drop database ONG;

create view patrocinador_proyecto as select pro.Objetivo, pro.N_Beneficiarios, pra.* from Proyectos pro inner join Patrocinadores pra on pro.Codigo_proyecto = pra.Codigo_proyecto where pro.pais = 'Bolivia';
select * from patrocinador_proyecto;
drop view patrocinador_proyecto;



Delimiter $$
create function num_trabjadores_perfil(Tipos varchar(50))
returns int
begin
declare salida int;
select count(Codigo_trabajador) into salida from Trabajadores where Tipo = Tipos;
return salida;
END $$
select num_trabjadores_perfil('Voluntario')$$
drop function num_trabjadores_perfil$$




delimiter $$
create procedure listado_socios (cod_Asociacion int(5), provincia varchar(50), aportacion_mensual int(5) )
begin 
declare DNI_socio varchar(50);
declare v_Nombre varchar(50);
declare v_Provincia varchar(50);
declare fin boolean default false;
declare cursor1 cursor for select dni, nombre, Provincia from socios where Codigo_asociacion = cod_Asociacion 
and Provincia= provincia and Cuota_mes >= aportacion_mensual;
declare continue handler for not found set fin=1;
open cursor1;
    repeat 
      fetch cursor1 into DNI_socio, v_Nombre, v_Provincia;
		if DNI_socio is null || v_Nombre is null|| v_Provincia is null then
		select concat('No hay nada, haber si te enteras ');
     else if not fin then
		select concat(DNI_socio,' ', v_Nombre,' ', Provincia);
		else
		select concat('Terminado');
end if;
end if;
    until fin end repeat;
  close cursor1;
END $$
call listado_socios(0001,'Aturias',2 );$$
drop procedure listado_socios$$


Delimiter $$
CREATE EVENT actualizacion_salario
ON SCHEDULE AT '2020-1-1:00:00' + interval 1 day
DO
BEGIN
update  Asalariados set Sueldo = Sueldo + (Sueldo * 0.02);
END $$


Delimiter $$
create trigger control_jefes BEFORE delete on trabajadores
FOR EACH ROW begin
select * from Trabajadores  where Codigo_trabajador in (select distinct jefe from trabajadores)INTO OUTFILE '/usr/local/mysql/ONG.txt';
END $$
drop trigger control_jefes;$$
delete from Trabajadores where Codigo_trabajador = 1000;$$

#SHOW VARIABLES LIKE "secure_file_priv"$$



Delimiter $$
create trigger control_jefes
BEFORE delete on trabajadores
FOR EACH ROW
begin
    insert into Control_Jefes values
  (concat('El trabajador ', old.codigo_trab, ' con cargo ', old.tipo, ' se da de baja el día ', curdate()));
    delete from asalariado where codigo_trab = old.codigo_trab;
    delete from trabaja where codigo_trab = old.codigo_trab;
END $$

create event actualizacion_salario
  on schedule every 1 day
    starts '2020-01-01 00:00:00'
    do
      begin
        update asalariados set sueldo = sueldo + (sueldo*0.02);
      end;
$$

