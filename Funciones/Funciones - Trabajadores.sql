create database Trabajadores;
use Trabajadores;
create table Trabajador(
id_t int auto_increment primary key,
DNI varchar(9),
Nombre varchar(8),
Fecha_alta date,
Tarifa float,
Oficio varchar(30),
id_sup int
)
Engine=InnoDB;

create table Edificio(
id_e int primary key,
dir varchar(50),
tipo varchar(50),
nivel_calidad varchar(50),
categoria varchar(50)
)
Engine=InnoDB;

create table Asignacion(
id_t int,
id_e int,
fecha_inicio date,
num_dias int(4),
primary key (id_t, id_e, fecha_inicio),
foreign key (id_t) references Trabajador(id_t),
foreign key (id_e) references Edificio(id_e)
)
Engine=InnoDB;

alter table Trabajador add foreign key (id_sup) references Trabajador(id_t);

#drop database Trabajadores;


insert into Trabajador values (null, '76964377y', 'Pablo', '2002-2-23',1500, 'Fontanero',1),
								(null, '34305949z', 'Juan', '2012-3-12',2000,'Fontanero',1),
								(null, '45684859x', 'Pedro', '2012-5-5', 1230, 'Fontanero', 1),
								(null, '12857576r', 'Matias', '2010-4-8', 1300,'Albañil',2),
								(null, '28586958p', 'Felipe', '2008-8-8', 1220, 'Albañil',2),
								(null, '68436475h', 'Floilan', '2002-7-7', 1400, 'Albañil',2),
								(null, '58693948n', 'Antonio', '2008-10-29', 1800, 'Carpintero',3),
								(null, '58686959j', 'Jesus', '2005-5-12', 800, 'Carpintero', 3),
								(null, '58686959p', 'Mario', '2013-3-12', 980, 'Carpintero', 3);

insert into Edificio values (500, 'C/ Uria Oviedo Asturias', 'Edifico multifamiliar', 'A+++', 'Vivienda'),
							(600, 'C/ Las Ramblas, Barcelona Cataluña', 'Teatro','A ++', 'Comercio'),
							(700, 'C/ Cimadevilla, Gijón Astuias', 'Edificio unifamiliar', 'A+', 'Vivienda');

insert into Asignacion values   (1,500,'2018-1-1', 12),
								(1,600,'2018-2-2',9),
								(1,700,'2018-3-3', 49),
								(2,500,'2018-1-3',50),
								(2,600, '2018-12-4', 20),
								(2, 500, '2019-10-8', 10),
								(3, 600, '2018-7-7', 30),
								(3, 700, '2018-10-20', 40),
								(3, 500, '2018-7-20' ,30),
								(4, 600, '2018-5-12', 23),
								(4, 600, '2018-8-3', 45),
								(4, 700, '2018-7-12', 65),
								(5, 500, '2018-12-23', 34),
								(5, 500, '2018-9-23',69),
								(5, 600, '2018-12-23', 70),
								(6, 700, '2018-10-8', 12),
								(6, 500, '2018-5-5', 34),
								(6, 600, '2018-4-12', 23),
								(7, 500,'2018-6-23', 56),
								(7, 500, '2018-9-12', 78),
								(7, 600, '2018-12-31', 78),
								(8, 500, '2018-3-4', 12),
								(8, 600, '2018-5-12', 34),
								(8, 500, '2018-6-7', 45),
								(9, 600, '2018-5-5', 29),
								(9, 500, '2018-3-4', 56),
								(9, 600, '2018-8-12', 45);

create view Edificios_30dias as select t.dir, t.tipo, t.nivel_calidad, t.categoria from Edificio t inner join Asignacion a on t.id_e = a.id_e where a.num_dias >=30;
select Edificios_30dias;

Delimiter $$
create procedure Alta_trabajador (DNI varchar(9), Nombre varchar(8), Fecha_alta date, Tarifa double, Oficio varchar(50), id_sup int)
begin
declare fin boolean default false;
declare v_DNI int(9);
declare micursor cursor for select v_DNI from Trabajador;
declare exit handler for 1602 select concat('Error, el DNI ', DNI, ' ya existe' );
begin
	insert into Trabajador values (null, DNI,Nombre, Fecha_alta, Tarifa, Oficio, id_sup);
	select concat('El trabajador de DNI ', DNI, ' se ha dado de alta');
end;
select concat('Proceso terminado');
end $$

call Alta_trabajador('54930355y', 'Pedro', '2018-6-7', 1000, 'Carpintero',3)$$
drop procedure Alta_trabajador$$



Delimiter $$
create function Num_trabajdores(v_oficio varchar(30))
returns int
begin
declare salida int;
select count(*)into salida from Trabajador where Oficio = V_Oficio and fecha_alta = MONTH (NOW()) ;
return salida;
end$$

select Num_trabajdores('Carpintero')$$
drop function Num_trabajdores$$


Delimiter $$
create function num_annos()
returns 
begin

call procedure Antiguedad();
return Antiguedad;
end $$


