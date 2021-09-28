DELIMITER $$
create procedure ejercicio3 (cadena varchar (30))
begin
declare v_cadena varchar(30);
declare fin boolean default 0;
declare v_apellido varchar(30);
declare v_emp_no varchar(30);
declare nombre cursor for select apellido, emp_no from emple where apellido like v_cadena;
declare continue handler for not found set fin =1;

set v_cadena= contat('%',cadena,'%');
open cursor1;
repeat
 fetch nombre into v_apellido, v_emp_no;
	if not fin then
    select v_apellido, v_emp_no ;
END IF; 
until fin
select concat('numero de empleados', cursor1.ROWCOUNT);
close cursor1;
END $$
call ejercicio3 ('nandez');
/*Realiza un procedimento que almacene el Apellido y salario del perosnal con antiguedad mayor a 5 años de la siguiente manera
	si el oficio es Director se almacena en una tabla llamada Salrio_Director
    si el oficio es Administrador se alamacena en una tabla llamada Salario_Admiunistrador
    si el oficio es Vendedeor se almacena en una tabla llamamda Salario_Venderdor
    
Las tres tablas deben de existir previamente y tendran un campo autonumerico como clave primaria
*/