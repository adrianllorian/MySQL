create database Empresa_2;
use Empresa_2;


create table depart(
dept_no int(2) NOT NULL primary key,
dnombre char(15),
loc char(8)) Engine=Innodb;

create table emple(
emp_no int(5) NOT NULL, 
apellido char(10),
oficio char(10),
dir int(4) ,
fecha_alt date not null,
salario int(4),
comision int(4),
dept_no int(2),
key(emp_no, dept_no),
foreign key (dept_no) references depart(dept_no) 	) Engine=Innodb;

insert into depart (dept_no, dnombre, loc)
values  ('10','CONTABILIDAD','OVIEDO'),
		('20','INVESTIGACIÓN','LLANERA'),
		('30','VENTAS','OVIEDO'),
		('40','PRODUCCIÓN','MIERES');
        
insert into emple (emp_no, apellido, oficio, dir, fecha_alt, salario, comision, dept_no)
values  ('7369','SÁNCHEZ','EMPLEADO','7698','1989-12-17','1000',null,'20'),
		('7499','ARROYO','VENDEDOR','7698','1986-02-20','1500','1200','30'),
		('7521','SALA','VENDEDOR','7566','1992-01-22','1200','900','30'),
		('7566','JIMÉNEZ','DIRECTOR','7566','1992-12-05','2100',null,'20'),
		('7654','MARTÍN','VENDEDOR','7698','1992-09-29','1600','1500','30'),
		('7644','ARIAS','EMPLEADO','7566','1905-05-19','900','500','40'),
		('7698','PÉREZ','DIRECTOR','7566','1906-01-02','1900',null,'30');
        
        
        #PDF 1
        
        ALTER TABLE depart ADD UNIQUE (dnombre);
        delete max from emple where fecha_alt; #ESTA MAL
        update emple set comision  = '200' where dept_no = '30';
        update emple set dir = '7516' where oficio = 'VENDEDOR';
        delete  from emple  where dept_no = '20'  and comision = 'null';
        update emple set salario = round (salario - 50) where oficio ='Vendedor';
        insert into depart set dept_no = '50', dnombre ='personal', loc ='oviedo';
        insert into emple (emp_no, apellido, oficio, dir, fecha_alt, salario, comision, dept_no)
values ('7653','Arguelles','vendedor','7566','2019-01-12','1000',null,'50'),
('7654','Llorian','vendedor','7566','2019-01-12','1000',null,'50');
		update emple set oficio ='Administratvo' where emp_no = '7654';
        update depart set loc='Gijon' where dnombre ='Administrativo';
        insert into emple (emp_no, apellido, oficio, dir, fecha_alt, salario, comision,dept_no)
        values ('6000','Garcia','administracion','4000','2019-01-12','1000',null,'30'),
        ('6001','sanchez','administracion','4000','2019-01-12','1000',null,'30');
        update emple set salario = round(salario * 0,05) where dept_no = '30' and comision  >='1000';
        
        
        # Pdf 2
        
        select * from emple order by apellido asc;
        select * from depart;
        select * from emple where oficio='vendedor';
        select * from emple where dept_no='20';
        select apellido, oficio from emple where salario > 1200;
        select apellido, salario from emple where comision = 'null'; #no funciona
        select oficio 'OFICIO' from emple;
        select emp_no 'Numero_empleado', apellido 'Nombre', salario 'Sueldo' from emple; # no hace el incremento
        select  min (fecha_alt) from emple; # no funciona
        select dnombre from depart where loc ='Oviedo';
        select * from emple where salario between '1000' and '1500';
        select distint Oficio from emple where dept_no in (20, 40); 
        select apellido from emple where fecha_alt between '1992-01-01' and '1992-12-31';
        select * from emple where dept_no = '20';
        select apellido, salario from emple where salario < 1600;
        select apellido, oficio from emple where comision > 0 order by oficio asc;
        select * from emple where oficio = 'director';
        select salario, dept_no from emple where apellido like 'S%';
        select * from emple where oficio like '%or';
        select comision from emple where dept_no ='30';
        
        
        #pdf3
        use empresa_2;
        select count(*) from emple where salario =(select min (Salario) from emple);
        select avg (salario) from emple where dept_no=20;
		select max(comision) from emple;
        select count (emp_no) from emple where comision is null;
        select count(*) 'Nuemero de trabjadores en el departamento ventas' from emple where dept_no = (select dept_no from depart where dnombre = 'Ventas');
        select * from emple where fecha_alt =(select min(fecha_alt) from emple);
        select count(emp_no) from depart, emple where dept_no = 20 and oficio = 7566; #esta mal
        select * from  emple where comision is null and dep_no in (Select dept_no from depart where loc ='oviedo') ;
        select * from depart, emple where oficio = 'vendedor' and fecha_alt between '1992-01-10' and '1992-10-10';
        select avg(salario) from emple where dept_no = '20' and dir in (select dept_no from emple where oficio ='director' and apellido ='Jimnez'); 
        insert into emple  value ( '1500', 'lopez', 'vendedor', '7698', curdate(), '150', null, (select dept_no from depart where dnombre ='Ventas'));
        select * from emple where salario between '500' and  '1500';
        select sum(salario) from emple where dept_no = 20;
        
        
        #pd4
        
        select apellido, oficio, emp_no, fecha_alt, dnombre from emple, depart order by emp_no asc;
        select distinct oficio 'OFICIO' from emple;  
        select count(emp_no) from emple;
        select apellido 'Nombre', salario 'Salario' from emple;
        select apellido, dept_no from emple order by salario desc;
        select apellido, salario from emple where salario between '1500' and '2850';
        select apellido 'Nombre', oficio 'Oficio', fecha_alt 'fecha de alta' from emple where fecha_alt between '1986-2-20' and '1996-5-1' order by fecha_alt asc;
        select apellido, dept_no from emple where dept_no in (20, 30) order by apellido asc;
        select apellido 'nombre', salario'salario'  from emple where salario > 1500 and dept_no in (20, 30);
        select apellido, fecha_alt from emple where fecha_alt between '1992-01-01' and '1992-12-31';
        select apellido, oficio from emple where dir is null;
        select apellido, salario, comision, dept_no from emple order by salario + comision desc;
        select apellido from emple where apellido like '%a%';
        select apellido from emple where apellido like '%a%' and dept_no ='ventas' and dir in (7698); # dudas con varios parametros de filtor para la busqueda
        select emp_no 'numero d eempleado', apellido 'nombre',salario, salario * 0.08 + salario 'Con incremento', 'sueldo' from emple;
        
        
         
        
      #pdf5
      select * from emple INNER JOIN depart on loc in ('oviedo', 'llanera', 'mieres');
	  select dept_no 'Numero de departamento', count(emp_no) 'Numero de empleados' from emple group by dept_no;
      select * from emple where (apellido like 'a%') and (oficio like '%e%');
      select dept_no 'Numero de departamento', count(oficio)'Numero de Vendedores', oficio'Trabajo' from emple  where oficio = 'Vendedor'  group by dept_no;
	  select dept_no 'Numero de departamento', count(emp_no) 'Numero de empleados' from emple where dept_no in (20,30) group by dept_no;
      insert into emple  select 7999, 'Alvarez', 'Vendedor', null, curdate(), salario, null, dept_no from emple where emp_no = 7644;
      select apellido, oficio from emple where oficio in (select oficio from emple where apellido = 'Sala') and apellido !='Sala'; # pongo in porque puede haber mas de un apellido sala
      select * from emple where comision =(select min(comision) from emple);
      select dept_no 'numero de departamento', sum(Salario) 'Sueldo' from emple group by dept_no;
      select loc  'Localidad', fecha_alt from depart  inner join emple where fecha_alt = (select min(fecha_alt) from emple); 
	  select dept_no 'Departamento' from emple group by dept_no having count(*) > 2;      #No esta fino
      select dept_no 'Numero de departamento', max(salario) 'Sueldo maximo', min (salario) 'Salrio minimo' from emple group by dept_no;
      select dnombre 'Departamento' from depart where depat_no in (select dept_no from emple group by dept_no having count(*)>4);
      select count(*) 'Numero de empleados', oficio, dept_no  from emple group by oficio, dept_no; 
      select * from emple where dir = (select emp_no from emple where apellido = 'jimenez');
      
      
      
      
      #Esplicacion en Clase 21 de Enero 2019
      select * from emple, depart; #La salida es un producto cartesiano
      select * from emple inner join depart on emple.dept_no = depart.dept_no; # esta seria la consulta bien echa
      select apellido, loc from emple inner join depart on emple.dept_no = depart.dept_no;
	  select apellido, loc from emple, depart where emple.dept_no = depart.dept_no; # hace lo mismo de la de arruba pero es mas eficad la de arriba
	  insert into emple (emp_no, apellido, oficio, dir, fecha_alt, salario, comision, dept_no)
	  values  ('7369','Gonzalez','EMPLEADO','7698','1989-12-17','1000',null, null);
	  select * from emple left join depart on emple.dep_no = depart.dept_no;
	  select * from emple inner join depart on emple.dept_no = depart.dept_no;
	  insert into depart (dept_no, dnombre, loc) values ('80', 'Marketing', 'Siero');
	  select * from emple inner join depart on emple.dept_no = depart.dept_no;
	  select * from emple left join depart on emple.dept_no = depart.dept_no;
	  select emple.* from emple INNER JOIN depart on loc in ('oviedo', 'llanera', 'mieres');
	  select loc from depart d inner join emple e on d.dept_no = e.dept_no where e.fecha_alt in (select min (fecha_alt) from emple);
	  select  * from emple e inner join emple d on d.emp_no = e.dir where d.apellido = 'Jimenez';
      
      
      
	
      #pdf 
		use empresa_2;
        select e2.apellido from emple e1 inner join emple e2 on e2.oficio = e1.oficio where e1.apellido = 'Arroyo' and e1.oficio = e2.oficio and e2.apellido !='Arroyo'; #Se une las dos tablas por oficio.
        select e.* from emple e inner join depart  d on e.dept_no = d.dept_no where loc in ('Llanera', 'Mieres');
        select e.apellido, e.oficio, d.dnombre from emple e inner join depart d on e.dept_no = d.dept_no where e.dept_no= 30; # unimos las tablas por dept_no porque est en las dos tablas
        select e.apellido, e.oficio, e.dept_no, d.dnombre, d.loc from emple e inner join depart d;
        select * from emple where apellido like 'A%' and oficio like '%E%';
        select e.apellido, e.oficio, d.loc from emple e inner join depart d  on e.dept_no= d.dept_no where e.oficio = 'Vendedor';
        select e.apellido, e.oficio, e.salario, e.fecha_alt from emple e where oficio in (select oficio from emple where apellido ='sanchez') or salario > (select salario from emple where apellido ='arroyo' );
			
            select distinct e.apellido, e.oficio,e.salario,e.fecha_alt from emple e inner join emple d on e.salario <= d.salario inner join emple a on a.oficio = e.oficio where d.apellido = 'Arroyo' and e.apellido !='Arroyo' or a.apellido = 'Sanchez' and e.apellido !='Sanchez'; # Correcion en clase con dos inner join
            
		insert into emple select '8001', 'Alvarez', 'Vendedor', null, curdate(), salario, null, dept_no from emple where apellido ='Martin'; #Machaca las consultas metiendo los registros
        select e1.apellido, e1.oficio,e1.salario from emple e1 inner join emple e2 on e1.dept_no=e2.dept_no where e1.salario=e2.salario and e2.apellido ='Martin' and e1.apellido !='Martin'; # Corregida en clase ultimo ejercicio corregido
        select e.apellido, e.oficio from emple e inner join emple p on e.oficio = p.oficio where p.apellido = 'Sala';
        select dept_no, count(emp_no)'Numero de empleados' from emple group by dept_no;
        select * from emple where comision is not null and comision =(select min(comision) from emple);
        select sum(e.salario)'Suma de salrio', d.dnombre 'Nombre de departamento' from emple e inner join depart d on  e.dept_no =d.dept_no  group by d.dept_no;
        select apellido, oficio, salario from emple where salario = (select max(salario) from emple);
        select loc from depart where dept_no = (select dept_no from emple where fecha_alt = (select max(fecha_alt) from emple));
        select count(emp_no) 'Total de empleados', dept_no'numero de departamento' from emple group by dept_no;
        select count(emp_no) 'Total de empleados', dept_no'numero de departamento' from emple group by dept_no having count(emp_no) >2;
		select  dept_no'numero de departamento', min(salario)'Salario minimo', max(salario)'Maximo salario' from emple group by dept_no;
        select dnombre from  emple e inner join depart d on e.dept_no = d.dept_no group by e.dept_no having count(emp_no) > 4; # corregido en clase
	    select count(emp_no)'Numero de empleados', oficio, dept_no from emple  group by dept_no, oficio; #Corregido en clase
        select d.dept_no, d.dnombre, count(emp_no) from emple e inner join depart d group by dept_no having count (d.emp_no) = (Select count(*) from emple group by dept_no order by count(*) desc limit 1); # El esplicado en clase
        select d.dept_no, d.dnombre,e.emp_no from emple e inner join depart d where d.dept group by d.dept_no;
        select depart.dept_no, dnombre, count(emp_no) from depart inner join emple where depart.dept_no = (select dept_no from emple where emp_no = (select max(emp_no) from emple));#error de programa
        select apellido from emple where oficio =(select oficio from emple where apellido = 'arroyo') and salario > (select salario from emple where apellido = 'Arroyo');



	#pdf fecha
    
     SELECT NOW();
     select DATE_ADD(fecha_alt ,INTERVAL 2 month)'Fecha' from emple ; #Date add es la suma y necesita dos formatos. Primero pasamos la fecha y el segundo dos meses. interval coje el primer apartado y suma
     select DATE_ADD(fecha_alt ,INTERVAL -2 month)'Fecah mas dos meses' from emple ;
     select (DAYOFMONTH(fecha_alt )), MONTH(fecha_alt) from emple; 
     select DAY(LAST_DAY(fecha_alt)) 'ultimo dia' ,MONTH(fecha_alt) 'mes' from emple;
     SELECT TIMESTAMPDIFF (YEAR,'1988-08-27',CURDATE())'Años';
     SELECT from_days(to_days(now())+(dayofweek(now())+7-2));# lunes corregida por carmen.
     select DATE_FORMAT(fecha_alt,'%W %M %Y') from emple;
     select DATE_FORMAT(fecha_alt,'%b %j ') from emple; # Me falla los ultims 2 y 3 digitos
     SELECT  STR_TO_DATE('12/31/2011', '%m/%d/%Y')'Fecha String';
     select month (str_to_date('01012007', '%d %m %y'));
     #11
     select * from emple where fecha_alt = (Select min(fecha_alt) from emple);
     select * from emple group by dept_no and fecha_alt desc;
     select e.* , d.dnombre, d.loc from emple e inner join depart d on e.dept_no =d.dept_no where datediff (curdate(), fecha_alt) >15;
	 #15
     select concat(apellido, " de ", dept_no," ", fecha_alt) from emple;
     select DATE_FORMAT(now(), "Hoy es: " '%W, %e' " de " '%m' " de " '%Y')'Fecha';
     
     
     
     #Funciones 
	 select chr(75), chr(65);
	 select concat("El apellido es: ", apellido) from emple;
	 select concat(apellido, " es ", oficio) from emple;
     select lower(apellido) from emple;
     select rpad(apellido, 30, '.') from emple;
     select rpad(apellido, 11, '*') from emple;
     select apellido, SUBSTR(apellido,1,1) from emple;
     select apellido, lower(substring(apellido,1,1)) from emple;
     select lenght(apellido) from emple;
     select apellido, instr(apellido,'A') from emple;
     select apellido, instr(apellido,'E',1,2) from emple;
     select sysdate();
     select date_add(fecha_alt, INTERVAL +2 MONTH) from emple;
     select date_sub(fecha_alt, INTERVAL +2 MONTH) from emple;
     select last_day(fecha_alt) from emple;
     select timestampdiff(year, '1986-06-28', curdate());
     SELECT from_days(to_days(now())+(dayofweek(now())+7-2));
     select date_format(fecha_alt, '%M %d %y')from emple;
     select DATE_FORMAT(fecha_alt,'%b %j '), to_char (fecha_alt, 'yyy'), to_char(fecha_alt 'yy') from emple; #falta corregir
     select  STR_TO_DATE('12/31/2011', '%m/%d/%Y')'Fecha String';
     select month (str_to_date('01012007', '%d %m %y'));
     select dayname(str_to_date('12122007', '%d %m %y')), monthname(str_to_date('12122007', '%d %m %y')),day(str_to_date('12122007', '%d %m %y')), year(str_to_date('12122007', '%d %m %Y'));
     select DATE_FORMAT(now(), "Hoy es: " '%W, %e' " de " '%m' " de " '%Y')'Fecha';
     
     #pdf 01/02/19
     #1
     #2
     #3
     #4
     select count(e.emp_no)'Numero de empleados', e.oficio 'Oficio', dept_no from emple e where oficio = 'empleado' group by dept_no;
     select dnombre 'nombre de departamento' from depart d inner join emple e on d.dept_no = e.dept_no where e.oficio = 'empleado' group by dept_no having count(*) = (select max(num.emple) from (select dept_no , count(*)'Num' from emple where oficio = 'empleado' group by dept_no));
     