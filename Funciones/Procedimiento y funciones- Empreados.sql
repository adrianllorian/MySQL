#Adrian Ejercico 1

#Adrian

/*1 Realizar un procedimiento que permita borrar un empleado conocido su nº
de empleado. Una vez eliminado debe indicarnos, “Empleado borrado con
éxito” . */

delimiter $$
create procedure borrado (V_emp_no int)
begin
 delete from emple where emp_no = V_emp_no;
 select 'Empleado borrado con exito';
end $$
call borrado(1234) $$


/* 2. Realizar una función que nos devuelva el nº de trabajadores que trabajan
en un determinado departamento del que conocemos su número. */

delimiter $$
create function num_emple (numero_dept int(2))
returns int (6)
begin 
declare v_num_empleados int (4);
select count(emple) into v_num_empleados from empleados where dept_no = numero_dept;
return v_num_empleados;
end $$

select num_emple(22) as 'Nº empleados de un departamento' $$

/* 3. Función que nos da el nombre del departamento donde trabaja el
empleado mejor pagado. (Suponemos que es único).*/
delimiter $$
create function empleMejorPagado ()
begin
declarate v_nom_dep varchar(20);
select nom_dep into v_nombre from depart d inner join emple e on d.dept_no = e.dept_no
where salario = (select max(salario) from emple),
return v_nombre;
end$$
select empleMejorpagado()'Nombre departamento'$$

/* 4 Procedimiento que visualiza el nº de trabajadores en un determinado oficio,
de un determinado departamento. Formatear la salida de datos.*/

delimiter $$
create procedure trabaja (oficio varchar (30), dept_no int (5))

begin
declare cuenta int (6);

select count(*) into 'cuenta' from emple where  v_dept_no = dept_no and oficio = v_oficio;
select concat('El departamento' dept_no 'hay' cuenta 'empleados de oficio' oficio);

end$$
call traba_oficio(Vendedor, 11)$$


/*5. Realizar un procedimiento que actualice la comisión, en una cantidad
dada, de los empleados de un determinado departamento (conocemos su
dept_no).*/


delimiter$$

create procedure actualizar(cantidad int(6), m_dept int (6))
begin
update empleados set comision = comision + cantidad where m_dept = dept_no;
end $$
call actualizar (80,20) $$
