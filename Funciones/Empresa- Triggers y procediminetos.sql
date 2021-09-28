create database Empresa_2;
use empresa_2;

create table depart(
dept_no int (6) PRIMARY KEY,
dnombre varchar (30) not null,
loc varchar (30)
) engine=innodb;

create table emple(
emp_no int (6) PRIMARY KEY,
apellido varchar (30),
oficio varchar (30),
dir varchar(30),
fecha_alt date not null,
salario float,
comision float,
dept_no int (6),
foreign key (dept_no) references depart (dept_no)
) engine=innodb;

INSERT INTO depart VALUES("10", "CONTABILIDAD", "OVIEDO");
INSERT INTO depart VALUES("20", "INVESTIGACIÓN", "LLANERA");
INSERT INTO depart VALUES("30", "VENTAS", "OVIEDO");
INSERT INTO depart VALUES("40", "PRODUCCIÓN", "MIERES");

INSERT INTO emple VALUES("7369", "SÁNCHEZ", "EMPLEADO", "7698", "1989-12-17", "1000", null, "20");
INSERT INTO emple VALUES("7499", "ARROYO", "VENDEDOR", "7698", "1986-02-20", "1500", "1200", "30");
INSERT INTO emple VALUES("7521", "SALA", "VENDEDOR", "7566", "1992-01-22", "1200", "900", "30");
INSERT INTO emple VALUES("7566", "JIMÉNEZ", "DIRECTOR", "7566", "1992-12-05", "2100", Null, "20");
INSERT INTO emple VALUES("7654", "MARTÍN", "VENDEDOR", "7698", "1992-09-29", "1600", "1500", "30");
INSERT INTO emple VALUES("7644", "ARIAS", "EMPLEADO", "7566", "2005-05-19", "900", "500", "40");
INSERT INTO emple VALUES("7698", "PÉREZ", "DIRECTOR", "7566", "2006-01-02", "1900", Null, "30");


#Ejercicio 1 
create table columna(
col1 varchar(200)
) Engine=Innodb;

Delimiter $$
create trigger disparador1 before update on emple for each row
begin
	insert into auditar value(concat(date_format(Current_timestamp, '%e-%M-%Y:%H:%i'), 'N empleado: ', 
    old.emp_no, '*', 'Apellido: ', old.apellido, 'Salario anterior: ', old.salario, 'muevo salario', new.salario));
end$$
#no hace nada hasta que se ejecute una sentencia que ejecute el disparador


#Ejercicio 2
create table empleados_baja(
col1 varchar(200)
)Engine=Innodb;


Delimiter $$
create trigger disparador2 before delete on emple for each row
begin
	insert into insertar value(concat(date_format(Current_timestamp, '%e-%M-%Y:%H:%i'), 'N empleado: ', 
    new.emp_no, '*', 'Apellido: ', old.apellido));
end$$
#no hace nada hasta que se ejecute una sentencia que ejecute el disparador

select trigger_name, trigger_schema, action_statement from information_schema.triggers;
show triggers from empresa;

#Ejercicio - Procedimientos/Funciones - nombre_trab

Create function nombre_trab(v_id_t int)
RETURNS varchar(30)
	begin
		Declare v_apellido varchar(30);
		select apellido into v_apellido from trabajador where id_t=v_id_t;
		if v_apellido is null
			then return 'No encontrado';
		#set v_nombre=IFNULL(v_nombre, 'No encontrado');
        return v_nombre;
	end;

Delimiter ;
set @x=nombre_trab(null);
set @x=nombre_trab('ARROYO');

 

create procedure sumaenteros (int_final int)
DELIMITER $$
begin;
	declare suma_total int default 0;
    sumas:loop
		set suma_total=suma_total+num_final;
        set num_final=num_final-1;
			if(num_final=0)
				then leave sumas;
			end if;
		end loop sumas;
        select suma_total;
end$$


#Ejercicios Despues de Procedimientos y bucles 

#Ejercicio 1-Realizar un procedimiento que permita borrar un empleado conocido su nº de empleado. Una vez eliminado debe indicarnos, “Empleado borrado con éxito” .

create procedure borrar (n_emple int(6)) #poner el mismo longitud y tipo, ; dentro pues hacer delimiter
DELIMITER $$
begin;
	delete emp_no from emple where n_emple=emp_no;
    if emp_no is null then return "Empleado borrado con exito";
end$$
#procedimientos no retorna valores, para mostrar algo en pantalla tienes que hacer un select, entonces lo de la variable solo sera para funciones
#Procurar poner tamaños mas o menos decentes, que pones 30 que es una locura
call borrar(123)$$

#Ejercicio 2
create function n_trab(n_dept int(6))
returns int(6)
begin
    declare num_emple int(30);
	select count(emp_no) into num_emple from emple where n_dept=dept_no; 
    return num_emple;
end$$
select n_trab(22) as 'N emple de un departamento'$$ 	#RENOMBRAR por que si no te saldria el resultado tipo un numero, Y CERRAR CON $$ SI NO CAMBIAS EL DELIMITER esto del select que lo se apuntarlo que seguro que me olvido

#Ejercicio 3
create function n_trab()
returns int(30)
begin
	declare dep_max_sal varchar(30);
	select dnombre into dep_max_sal from depart where emp_no=(select emp_no from emple where salario=(select max(salario) from emple) ); 
    return dep_max_sal;
end$$

select n_trab(22) as 'Nombre departamento con empleado mejor pagado'$$ #acuerdate de esto y apunta todos los comentarios que hice!
#Ejercicio 4

create procedure n_trab (ofi varchar(30), dept varchar(6))
DELIMITER $$
begin;
	declare n_emple int(30);
	select count(emp_no) into n_emple from emple where ofi=oficio  and dept=dept_no; # cualquier select se muestra, y los almacenados en una variable?? Vale no, los almacenados en una variable no se meustran, COMPROBADO, NO
    
   select concat('En el departamento',dept,'hay', n_emple,'trabajadores, de oficio',ofi); 
end$$

#Ejercicio 5
create procedure actualizar (dept varchar(6), cantidad int(30))
DELIMITER $$
begin;
	update empleados set comision=comision+cantidad where dept_no=dept;
end$$

call actualizar(80,20)$$

#TODO LO QUE PUSE DE COMENTARIOS APUNTAR
#recordar lo de in y out pero bueno, como se hacen de entrada no es encesario ponerlo


#HANDLER