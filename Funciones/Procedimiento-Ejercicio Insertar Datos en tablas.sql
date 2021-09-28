/*Realiza un procedimento que almacene el Apellido y salario del
 perosnal con antiguedad mayor a 5 años de la siguiente manera

	si el oficio es Director se almacena en una tabla llamada Salrio_Director
    si el oficio es Administrador se alamacena en una tabla llamada Salario_Admiunistrador
    si el oficio es Vendedeor se almacena en una tabla llamamda Salario_Venderdor
    
Las tres tablas deben de existir previamente y tendran un campo autonumerico como clave primaria


DELIMITER $$
create procedure borrarempreado (v_empleado int(6))
begin
delete from emple where emp_no = v_empleado;
END $$
call borrarempreado(7369);
$$

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

*/

DELIMITER $$
create procedure almacena()
begin
insert into Salario_Director values  (null, (select apellido from emple where oficio='DIRECTOR' and TIMESTAMPDIFF(YEAR,fecha_alt,CURDATE())>5),(select salario from emple where oficio='DIRECTOR' and TIMESTAMPDIFF(YEAR,fecha_alt,CURDATE())>5));
insert into Salario_Administrador values  (null, (select apellido from emple where oficio='ADMINISTRATIVO' and TIMESTAMPDIFF(YEAR,fecha_alt,CURDATE())>5),(select salario from emple where oficio='VENDEDOR' and TIMESTAMPDIFF(YEAR,fecha_alt,CURDATE())>5));
insert into Salario_Venderdor values  (null, (select apellido from emple where oficio='VENDEDOR' and TIMESTAMPDIFF(YEAR,fecha_alt,CURDATE())>5),(select salario from emple where oficio='ADMINISTRATIVO' and TIMESTAMPDIFF(YEAR,fecha_alt,CURDATE())>5));
END $$
call almacena()$$

