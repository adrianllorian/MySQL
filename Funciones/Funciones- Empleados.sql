# 1. Crear un procedimiento almacenado que visualice de un trabajador conocido su
# Emp_no, el nombre, oficio, nombre del departamento y localidad donde trabaja.
use empresa_2;
DELIMITER $$
create procedure almacenado(v_emp_no int (6) )
begin

declare v_apellido varchar(30);
declare v_oficio varchar(30);
declare v_dnombre varchar(30);
declare v_loc varchar(30);

declare fin boolean default 0;
declare micursor cursor for select e.emp_no, e.apellido, e.oficio, d.dnombre, d.loc from emple e inner join depart d on e.dept_no = d.dept_no where e.emp_no = v_emp_no;
declare continue handler for not found set fin=1;
open micursor;
fetch  micursor into v_emp_no, v_apellido, v_oficio, v_dnombre, v_loc;
if fin then
select concat (' No existe' )as Mensaje;
else
select v_emp_no, v_apellido, v_oficio, v_dnombre, v_loc from emple where v_emp_no = v_emp_no;

end if;
close micursor;
END $$

#7369
call almacenado(7);
$$

select emp_no from emple;
$$

drop procedure almacenado;




# 2. Crear una función almacenada que conocido el nombre del departamento y localidad,
# nos devuelva el nº de empleados que trabajan en él.

$$
DELIMITER $$
create function almacena2 (v_dnombre varchar (30), v_loc varchar(30))
  returns int(3)
  begin
  declare v_numero int (3);
  declare fin boolean default 0;
  declare v_fallo varchar(30) default 'ERROR';
declare micursor cursor for select count(e.emp_no) from emple e inner join depart d on e.dept_no = d.dept_no where d.dnombre = v_dnombre and d.loc = v_loc;
declare continue handler for not found set fin=1;
open micursor;
    
    fetch  micursor into v_numero;
   if fin then
	return v_fallo;
else
    return v_numero;
    end if;
close micursor;
  end $$
  
select almacena2('VENTAS','OVIEDO' )as 'numero de empleados';
$$
select d.*, e.* from emple e inner join depart d on e.dept_no = d.dept_no;
$$

#3. Crear una función almacenada, que conocido un oficio, nos devuelva el total de
#trabajadores con ese oficio.

DELIMITER $$
create function almacena3 (v_oficio varchar (30))
returns int
  begin
  declare v_numero int (3);
  declare fin boolean default 0;
 
declare micursor cursor for select count(*) from emple where oficio = v_oficio;
declare continue handler for not found set fin=1;
open micursor;
    fetch  micursor into v_numero;
   if fin then
	return v_fallo;
else
    return v_numero;
    end if;
close micursor;
   
    return numero;
END$$
select almacena3('VENDEDOR') AS 'Número de trabajadores';
 



/*4. Crear un procedimiento almacenado que nos de un listado de los trabajadores de un
determinado oficio,
Formato de salida de datos:
Trabajadores de OFICIO XXXXXX
APELLIDO DIRECCIÓN FECHA DE ALTA SALARIO NOMBRE DEPARTAMENTO
…… ……. ……………… ……. ……….
TOTAL: XXXXX*/
$$
create view oficios as select e.apellido, e.dir, e.fecha_alt, e.salario, d.dnombre from emple e inner join depart d on e.dept_no = d.dept_no where e.oficio = v_oficio;
$$


DELIMITER $$
create procedure almacena4(v_oficio varchar(30))
begin 
declare v_apellido varchar(30);
declare v_direccion varchar (30);
declare v_fecha_alt date;
declare v_salario float;
declare v_dnombre varchar (30);
declare fin boolean default 0;
declare micursor cursor for select e.apellido, e.dir, e.fecha_alt, e.salario, d.dnombre 
	from emple e inner join depart d on e.dept_no = d.dept_no 
	where oficio =v_oficio;
 declare continue handler for not found set fin=1;

	open micursor;
	repeat 
	fetch micursor into v_apellido, v_direccion, v_fecha_alt, v_salario, v_dnombre;
	if not fin then
select concat ( v_oficio,' ', v_apellido,' ', v_direccion,' ', v_fecha_alt,' ', v_salario,' ', v_dnombre )as 'Tabajadores de oficio';
	else 
    select concat('Error')as Mensaje;
	end if;
	until fin end repeat;
  close micursor;
END $$ 
call almacena4('VENDEDOR');$$

select oficio from emple $$
 
drop procedure almacena4$$



/*5. Crear un procedimiento almacenado que nos devuelva, ordenado de mayor nº a
menor, el número de trabajadores que hay por oficio. Formato de salida de datos:
Total de trabajadores
Oficio Nº de trabajadores*/
DELIMITER $$
create procedure almacena5 ()
begin 
declare numero int (3);
declare v_oficio varchar(30);
declare fin boolean default 0;
declare micursor cursor for select count(emp_no), oficio from emple group by oficio;
declare continue handler for not found set fin=1;

	open micursor;
	repeat 
	fetch micursor into numero, v_oficio;

    if not fin then
     select concat(v_oficio, ' ', numero) as 'Oficio y Numero de Empleados' ;
else 
	 select concat('Fin')as Mensaje;
	end if;
	until fin end repeat;
  close micursor;
    
END $$

drop procedure almacena5 $$
call almacena5 ()$$
