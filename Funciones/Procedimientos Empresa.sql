#En la Base de Datos Empresa:

#1. Realizar un procedimiento que permita borrar un empleado conocido su nº
#de empleado. Una vez eliminado debe indicarnos, “Empleado borrado con
#éxito” .
DELIMITER $$
create procedure borrarempreado (v_empleado int(6))
begin
delete from emple where emp_no = v_empleado;
END $$
call borrarempreado(7369);

#2. Realizar una función que nos devuelva el nº de trabajadores que trabajan
#en un determinado departamento del que conocemos su número.
DELIMITER $$
create function contarempleados (v_departamento int(2)) 
returns int(2)
begin
declare salida int(2);
select count(emp_no) into salida from emple where dept_no = v_departamento;
return salida;
END $$
select contarempleados(30) from emple;


#3. Función que nos da el nombre del departamento donde trabaja el
#empleado mejor pagado. (Suponemos que es único).
DELIMITER &&
create function mejorpagado()
returns varchar(30)
begin
declare salida varchar(30);
select apellido into salida from emple where salario = (select max(salario) from emple);
return salida;
END &&
select mejorpagado() from emple; 

#4. Procedimiento que visualiza el nº de trabajadores en un determinado oficio,
#de un determinado departamento. Formatear la salida de datos.
#“En el departamento XXX hay XXXX trabajadores de oficio XXXXX”
DELIMITER $$
create procedure contar_trabajadores_por_oficio (v_oficio varchar(30), v_dept_no int(6))
begin
declare suma_empleados int(2);
select count(emp_no) into suma_empleados from emple where oficio = v_oficio and dept_no = v_dept_no;
select concat ('En el departamento', v_dept_no, 'hay', suma_empleados, 'trabajadores de oficio', v_oficio);
END $$
call contar_trabajadores_por_oficio ('VENDEDOR', 30);

#5. Realizar un procedimiento que actualice la comisión, en una cantidad
#dada, de los empleados de un determinado departamento (conocemos su
#dept_no).

DELIMITER $$
create procedure aztualizar_comision (v_cantidad float, v_dept_no int (6))
begin
update emple set comision= v_cantidad  where dept_no = v_dept_no;
END $$
call aztualizar_comision (100,30); $$
select * from emple where comision >= 100;
