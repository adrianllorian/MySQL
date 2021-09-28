use Empresa_2;
create table Salario_Director(
id int(4) auto_increment primary key,
apellido varchar(30),
salario float
)Engine=innodb;

create table Salario_Administrador(
id int(4) auto_increment primary key,
apellido varchar(30),
salario float
)Engine=innodb;

create table Salario_Venderdor(
id int(4) auto_increment primary key,
apellido varchar(30),
salario float
)Engine=innodb;

DELIMITER $$
create procedure salario_oficio(v_oficio varchar(30))
begin
declare p_empleado int (20);
declare p_salario int (5);
declare fin bool default 0; # 0 falso 1=verdadero
	declare micursor cursor for
		select emp_no salario, oficio from emple where timestampdiff(year, fecha_alt, curdate())>5 and oficio in( 'Director', 'Vendedor', 'Oficio');
       declare continue handler for not found set fin =1;
       open micursor;
open misursor;
repeat     
fetch micursor into p_emp_no, p_salario, p_oficio, p_oficio;
if not fin then # insertar valores en las tablas
until fin end repeat;
close micursor;
if v_oficio = 'administrativo'
them insert into 

END$$ 