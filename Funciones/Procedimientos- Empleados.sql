/* 1.- Añadir un campo nuevo a la tabla empleados:
Categoria VARCHAR2(15) DEFAULT 'Empleado' */

use Empresa_2;
alter table emple add categoria varchar(15) default 'empleado';
select * from emple;
select * from depart;
/*A todas se le añade una nueva columna llamda Categoria*/

/*Si no cambias nada sera empleado, por el default declarado anteriormente*/

DELIMITER $$
create procedure actualizar_categoria()
begin
declare v_salario_ref float default 1000;
declare v_oficio varchar(30);
declare v_salario float;
declare v_categoria varchar(15);
declare v_comision float;
declare fin boolean default 0;
declare cursor_oficio cursor for select oficio, salario, categoria, comision  from emple;


declare continue handler for not found set fin=1;

	open cursor_oficio;
	repeat 
	fetch cursor_oficio into v_oficio, v_salario, v_categoria, v_comision;

if fin then
if v_oficio = 'DIRECTOR' then
 update emple set categoria = 'Director';
elseif v_salario <= v_salario_ref then
	update emple set categoria = 'Precario';
elseif v_oficio != 'DIRECTOR' and v_salario > v_salario_ref then 
	update emple set categoria = 'Empleado';
elseif (v_salario + v_comision) <= v_salario_ref + v_salario_ref * 0.10 then
	select concat (oficio, '!');
elseif loc = 'MADRID' then
	select concat (v_oficio ,'>');
elseif (select dep_no from emple where count(emp_no) > 4) then
	select concat (v_oficio , '+');


end if;
else 
select concat ('Teminado')as 'Mensaje';
end if;

	until fin end repeat;
  close cursor_oficio;

END $$
call actualizar_categoria()$$
drop procedure actualizar_categoria$$
select * from emple$$
select e.*, d.* from emple e inner join depart d$$

/* 2.- Utilizando la función que nos da el nº de años entre dos fechas, hacer un
procedimiento PL/SQL que ayude a seleccionar un empleado como director de departamento
para aquellos departamentos que no tienen director .

Para cada departamento sin director se visualizará el número y nombre de ese
departamento y todos los candidatos a director.
Para cada departamento sin director, los candidatos serán aquellos empleados que
estén adscritos a ese departamento, lleven más de 5 años trabajando para la empresa y tengan
el símbolo de “mayor que” en el atributo Categoría tratado anteriormente (adscritos a
MADRID).
Además, si un departamento con un director en funciones no tiene ningún candidato
se indicará tal eventualidad y se mostrarán los datos de antigüedad y si están o no adscritos a
MADRID para todos los empleados de dicho departamento.*/

DELIMITER $$
create procedure contar_emple()
begin
declare fin boolean default 0;
declare v_dept_no int(4);
declare v_nombre varchar(30);
declare v_num_emple int(4);
declare c_categoria varchar(30);
declare v_dept_no int(3);
declare v_dept_no2 int(3);
declare cursor1 cursor for select  dept_no, emp_no from emple where categoria like '% > %' and TIMESTAMPDIFF(Year,fecha_alt, curdate())>5;
declare cursor2 cursor for select  d.dept_no, d.nombre from depart d inner join emple e on d.dept_no = e.dept_no group by d.dept_no having d.dept_no not in (select dept_no from emple where oficio in 'Director');
declare continue handler for not found set fin = 1;

open cursor2; 
repeat 
fetch cursor2 into v_dept_no, v_nombre;



	if not fin then
	open cursor1;
    set v_num_emple =0;
    repeat 
	fetch cursor1 into v_dept_no, v_emp_no;
    if not fin then
		if v_dept_no = v_dept_no2 then
        set v_num_emple;
        select v_dept_no1, v_emp_no;
        end if;
    set v_num_emple = v_num_emple +1;
    select v_dept_no2, v_emp_no;
    end if;
    until fin end repeat;
    close cursor1;
    set fin =0;
    if v_num_emple = 0 then
    select 'No hay departamentos para ' dept_no from emple;
    end if;
    end if;
    until fin end repeat;
    close cursor2;
    
    
	until fin end repeat;
	close cursor_oficio;

    else 
    select concat('No tiene candidato');


END $$
/*3.- Se desea hacer una lista de posibles incidencias que se detecten en la información
de la BD de nuestra empresa.
Para ello vamos a crear un procedimiento PL/SQL llamado BUSCA_INCIDENCIAS que al
ser ejecutado busque diversos tipos de incidencias y las inserte en una tabla llamada
INCIDENCIAS que debe estar creada previamente con los siguientes campos:
● Dpto: Departamento donde se detecta la incidencia.
● Código: Código de incidencia.
● Fecha: Fecha en la que se detectó la incidencia.
● Texto: Breve explicación de la incidencia (con los datos relevantes de la
misma).
No permitiremos que una misma incidencia se inserte dos veces para el mismo
departamento con distinta fecha. En tal caso, en vez de insertar la segunda vez la misma
incidencia, lo que se debe hacer es actualizar la fecha de la incidencia ya existente, de forma
que en la tabla siempre tengamos la última fecha en la que se detectó cada incidencia.
El procedimiento BUSCA_INCIDENCIAS podrá ejecutarse cuando el usuario (o el
administrador) lo desee, y debe controlar las siguientes incidencias:
1. Valores NULL en algunos atributos (como el salario...), solo comisión pude estar a Null.
(Código 0010)
2. Departamentos sin empleados. (Código 0012)
3. Fecha de alta posterior a la fecha del sistema. (Código 0020)*/

create table incidencias (
dept_no int (6),
codigo int (6),
fecha date,
texto char,
primary key (dept_no, codigo),
foreign key (dept_no) references emple (dept_no)
)
Engine = InnoDB$$


create procedure buscar_incidencia()
begin
  declare fin bool default 0;
  declare v_emp_no int(6);
  declare v_fecha_alt date;
  declare v_dept_no int(6);
  declare b_dept_no int(6);
  declare p_dept_no int(6);

  declare cursor1 cursor for
    select dept_no from emple
    where apellido is null or oficio is null or dir is null or fecha_alt is null or salario is null or dept_no is null;

  declare cursor2 cursor for
    #select * from depart where dept_no not in(select dept_no from emple);
    select e.emp_no, d.dept_no from emple e right join depart d on d.dept_no=e.dept_no where d.dept_no is null;

  declare cursor3 cursor for
    select dept_no from emple where fecha_alt>curdate();

  declare continue handler for not found set fin=1;

  open cursor1;
    repeat 
      fetch cursor1 into b_dept_no;
      if not fin then
        insert into incidencias values (b_dept_no, '0010', curdate(), 'Error 0010')
        on duplicate key update fecha=curdate();
      else
        select concat('Terminada comprobacion 1') as 'Mensaje';
      end if;
    until fin end repeat;
  close cursor1;
set fin =0;
  open cursor2;
    repeat 
      fetch cursor2 into v_emp_no, v_dept_no;
      if not fin then
          insert into incidencias values (v_dept_no, '0012', curdate(), 'Error 0012')
          on duplicate key update fecha=curdate();
      else
        select concat('Terminada comprobacion 2') as  'Mensaje';
      end if;
    until fin end repeat;
  close cursor2;
set fin =0;
  open cursor3;
    repeat 
      fetch cursor3 into p_dept_no;
      if not fin then
        insert into incidencias values (p_dept_no, '0020', curdate(), 'Error 0020')
        on duplicate key update fecha=curdate();
      else
        select concat('Terminada comprobacion 3')as 'Mensaje';
      end if;
    until fin end repeat;
  close cursor3;

END;$$
select * from incidencias $$
call  buscar_incidencia() $$
drop procedure buscar_incidencia $$


/*4.-Escribir un procedimiento PL/SQL para subir el sueldo a ciertos empleados.
El procedimiento tendrá dos argumentos numéricos N y M que indican dos porcentajes
expresados en tanto por ciento (%).
● Se le subirá el sueldo en un porcentaje de N, a aquellos empleados que cobren
menos que el salario medio si tras esa subida siguen cobrando menos que ese
salario medio.
● Se le subirá el sueldo en un porcentaje de M, a aquellos empleados que sigan
cobrando menos que el nuevo salario medio, si no se les subió el sueldo en la
primera operación. Observe que tras efectuar la primera operación el salario
medio puede haber sido modificado.*/

$$
Delimiter $$
create procedure subir_sueldo()
begin
declare N float default 0.50;
declare M float default 0.25;
declare salario_medio float;
declare emple_N int(6);
declare emple_M int(6);
declare fin boolean default 0;
declare cur_N cursor for select emp_no from emple where salario < salario_medio;
declare cur_M cursor for select emp_no from emple where salario < salario_medio;
declare continue handler for not found set fin=1;
select avg(salario) into salario_medio from emple;
	open cur_N;
	repeat 
	fetch cur_N into emple_N;
	
	if emple_N and not fin then
		update emple set salario = salario + (salario * N) where emp_no = emple_N;
	else 
		select concat ('Terminado N');
end if;
until fin end repeat;
close cur_N;

select avg(salario) into salario_medio from emple;
	
	open cur_M;
	repeat 
	fetch cur_M into emple_N;
if emple_M and not fin then
		update emple set salario = salario + (salario * M) where emp_no = emple_N;
	else 
		select concat ('Terminado M');
  end if;
until fin end repeat;
close cur_M;

end $$	
call subir_sueldo();	$$
select * from emple; $$
