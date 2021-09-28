create database tienda;
use tienda;

#Tabla Fabricantes
create table fabricantes(
Cod_Fabricante   int 		not null   primary key,
Nombre           varchar(15)					  ,
Pais             varchar(15)
)Engine=Innodb;

#Tabla Articulos
create table articulos(
Articulo		 varchar(20) not null,
Cod_fabricante   int 		not null,
Peso			 int 		not null,
Categoria        varchar(10) not null,
Precio_venta     float				,
Precio_costo 	 float				,
Existencias 	 int					,
key(Articulo, Cod_fabricante, Peso, Categoria),
foreign key(Cod_fabricante) references fabricantes(Cod_Fabricante)
)Engine=InnoDB;

#Tabla Tiendas
create table tiendas(
Nif 			 varchar(10) not null  primary key,
Nombre    		 varchar(20)					  ,
Direccion  		 varchar(20) not null			  ,
Poblacion        varchar(20)					  ,
Provincia        varchar(20)					  ,
Codpostal        int
)Engine=InnoDB;


#Tabla Pedidos
create table pedidos(
NIF 			 varchar(10) not null			  ,
Articulo 		 varchar(20) not null			  ,
Cod_fabricante   int not null					  ,
Peso			 int not null					  ,
categoria 		 varchar(19) not null			  ,
fecha_pedido 	 date not null					  ,
Unidades_pedidas int							  ,
key(NIF ,Articulo, Cod_fabricante ,Peso , Categoria, fecha_pedido),
foreign key(Cod_fabricante) references fabricantes(Cod_Fabricante) on update cascade,
FOREIGN KEY (Articulo,Cod_fabricante,Peso,categoria) REFERENCES articulos(Articulo,Cod_fabricante,Peso,Categoria) ON DELETE CASCADE,
foreign key(NIF) references tiendas(Nif) on update cascade
)Engine=Innodb;




#Tabla Ventas
CREATE TABLE ventas (
NIF VARCHAR(10) NOT NULL,
Articulo VARCHAR(20) NOT NULL,
Cod_fabricante INT NOT NULL,
Peso INT NOT NULL,
Categoria VARCHAR(19) NOT NULL,
fecha_venta DATE NOT NULL,
unidades_vendidas INT,
KEY (NIF,Articulo,Cod_fabricante,Peso,Categoria,fecha_venta),
foreign key(Cod_fabricante) references fabricantes(Cod_Fabricante) on update cascade,
FOREIGN KEY (Articulo,Cod_fabricante,Peso,Categoria) REFERENCES articulos(Articulo,Cod_fabricante,Peso,Categoria) ON DELETE CASCADE,
FOREIGN KEY (NIF) REFERENCES tiendas(Nif) ON UPDATE CASCADE
)  ENGINE=INNODB;



#Insert Fabricantes (Cod_Fabricante, Nombre, Pais)
INSERT INTO FABRICANTES VALUES(10,'CALVO', 'ESPAÑA'), 
							  (15,'LU', 'BELGICA'),
							  (20,'BARILLA', 'ITALIA'), 
							  (25,'GALLO', 'ESPAÑA'),
							  (30,'PRESIDENT', 'FRANCIA');

#Insert Articulos (Articulo,Cod_fabricante,Peso,Categoria,Precio_venta,Precio_costo,Existencias)
INSERT INTO ARTICULOS VALUES ('Macarrones',20, 1, 'Primera',100,98,120),
							 ('Tallarines',20, 2, 'Primera',120,100,100),
							 ('Tallarines',20, 1, 'Segunda',99,50,100),
							 ('Macarrones',20, 1, 'Tercera',80,50,100),
							 ('Atún',10, 3, 'Primera',200,150,220),
							 ('Atún',10, 3, 'Segunda',150,100,220),
							 ('Atún',10, 3, 'Tercera',100,50,220),
							 ('Sardinillas',10, 1, 'Primera',250,200,200),
							 ('Sardinillas',10, 1, 'Segunda',200,160,200),
							 ('Sardinillas',10, 1, 'Tercera',100,150,220),
							 ('Mejillones',10, 1, 'Tercera',90,50,200),
							 ('Mejillones',10, 1, 'Primera',200,150,300),
							 ('Macarrones',25, 1, 'Primera',90,68,150),
							 ('Tallarines',25, 1, 'Primera',100,90,100),
							 ('Fideos',25, 1, 'Segunda',75,50,100),
							 ('Fideos',25, 1, 'Primera',100,80,100),
							 ('Galletas Cuadradas',15, 1, 'Primera',100,80,100),
							 ('Galletas Cuadradas',15, 1, 'Segunda',70,50,100),
							 ('Galletas Cuadradas',15, 1, 'Tercera',50,40,100),
							 ('Barquillos',15, 1, 'Primera',100,80,100),
							 ('Barquillos',15, 1, 'Segunda',100,80,100),
							 ('Canutillos',15, 2, 'Primera',170,150,110),
							 ('Canutillos',15, 2, 'Segunda',120,150,110),
							 ('Leche entera',30, 1, 'Primera',110,100,300),
							 ('Leche desnat.',30, 1, 'Primera',120,100,300),
							 ('Leche semi.',30, 1, 'Primera',130,110,300),
							 ('Leche entera',30, 2, 'Primera',210,200,300),
							 ('Leche desnat.',30, 2, 'Primera',220,200,300),
							 ('Leche semi.',30, 2, 'Primera',230,210,300),
							 ('Mantequilla',30, 1, 'Primera',510,400,200),
							 ('Mantequilla',30, 1, 'Segunda',450,340,200);

                              
#Insert Tiendas (Nif,Nombre,Direccion,Poblacion,Provincia,Codpostal)
INSERT INTO TIENDAS VALUES('1111-A','Almacenes Pérez', 'C/Toledo, 20','Siguenza','GUADALAJARA',19104),
						  ('5555-B','La gacela', 'C/Santander Rios, 45','Azuqueca','GUADALAJARA', 19209),
						  ('2222-A','Comestibles Rodolfo','C/ del Val s/n', 'Alcalá de Henares','MADRID',28804),
						  ('4444-A','La Pasta Gansa', 'C/Alcalá, 2','Ajalvir','MADRID', 28765), 
						  ('3333-N','Ultramarinos Montse','Avda. Pio 10', 'Toledo','TOLEDO',45100),
						  ('4141-B','Todo Toledo', 'C/Avila 24', 'Talavera','TOLEDO',45199);
                          
#Insert Pedidos (Nif,Articulo,Cod_fabricante,Peso,categoria,fecha_pedido,Unidades_pedidas)
INSERT INTO PEDIDOS VALUES ('5555-B','Macarrones',20, 1, 'Primera', '13/02/13', 30),
						   ('5555-B','Atún',10, 3, 'Primera','13/02/20', 10),
						   ('5555-B','Atún',10, 3, 'Segunda','13/03/13', 4),
						   ('5555-B','Sardinillas',10, 1, 'Segunda','13/03/23', 10),
						   ('5555-B','Macarrones',25, 1, 'Primera','14/01/13', 12),
						   ('5555-B','Fideos',25, 1, 'Segunda','13/05/03', 24),
						   ('5555-B','Fideos',25, 1, 'Segunda', '14/01/01', 20),
						   ('5555-B','Galletas Cuadradas',15, 1, 'Segunda', '13/06/02', 15),
						   ('1111-A','Barquillos',15, 1, 'Primera','13/02/20', 10),
						   ('1111-A','Canutillos',15, 2, 'Segunda','13/04/03', 12),
						   ('1111-A','Leche semi.',30, 1, 'Primera','12/06/13', 5),
						   ('1111-A','Leche semi.',30, 2, 'Primera','12/07/23', 11),
						   ('1111-A','Mantequilla',30, 1, 'Primera','13/07/23', 10),
						   ('4141-B','Macarrones',20, 1, 'Primera', '13/04/02', 30),
						   ('4141-B','Atún',10, 3, 'Primera', '12/06/02', 10),
						   ('4141-B','Atún',10, 3, 'Segunda', '12/08/02', 9),
						   ('2222-A','Sardinillas',10, 1, 'Segunda', '12/08/02',20),
						   ('2222-A','Sardinillas',10, 1, 'Tercera', '12/08/02',22),
						   ('2222-A','Mejillones',10,1, 'Primera',current_date(),1000),
						   ('3333-N','Macarrones',25, 1, 'Primera', '13/11/02',8),
						   ('3333-N','Tallarines',25, 1, 'Primera', '12/11/02',9),
						   ('3333-N','Fideos',25, 1, 'Primera', '13/11/02',11),
						   ('3333-N','Galletas Cuadradas',15, 1, 'Primera', '13/11/02',6),
						   ('3333-N','Barquillos',15, 1, 'Segunda', '14/01/02',40),
						   ('3333-N','Canutillos',15, 2, 'Segunda', '14/01/02',10);

#Insert Pedidos (Nif,Articulo,Cod_fabricante,Peso,categoria,fecha_venta,Unidades_vendidas)
INSERT INTO VENTAS VALUES ('5555-B','Macarrones',20, 1, 'Primera', '13/02/02', 5),
						  ('5555-B','Atún',10, 3, 'Primera', '13/02/02', 6),
						  ('5555-B','Atún',10, 3, 'Segunda', '12/03/02', 15),
						  ('5555-B','Sardinillas',10, 1, 'Segunda', '12/03/02', 8),
						  ('5555-B','Macarrones',25, 1, 'Primera', '12/04/02', 2),
						  ('5555-B','Fideos',25, 1, 'Segunda', '13/05/02', 14),
						  ('5555-B','Leche semi.',30, 1, 'Primera', '13/06/02', 5),
						  ('2222-A','Galletas Cuadradas',15, 1, 'Segunda', '12/06/02', 5),
						  ('2222-A','Barquillos',15, 1, 'Primera', '13/02/02', 6),
						  ('2222-A','Canutillos',15, 2, 'Segunda', '13/06/02', 2),
					      ('2222-A','Sardinillas',10, 1, 'Segunda', '13/08/02',5),
						  ('2222-A','Sardinillas',10, 1, 'Tercera', '13/08/02',5),
						  ('3333-N','Leche semi.',30, 2, 'Primera', '13/07/02', 11),
						  ('3333-N','Mantequilla',30, 1, 'Primera', '13/07/02', 10),
						  ('3333-N','Macarrones',20, 1, 'Primera', '13/04/02', 30),
						  ('3333-N','Atún',10, 3, 'Primera', '13/04/02', 10),
						  ('3333-N','Barquillos',15, 1, 'Segunda', '13/11/02',4),
						  ('3333-N','Canutillos',15, 2, 'Segunda', '13/11/02',4),
						  ('4141-B','Atún',10, 3, 'Segunda', '13/08/02', 2),
						  ('4141-B','Macarrones',25, 1, 'Primera', '10/11/02',2),
						  ('4141-B','Tallarines',25, 1, 'Primera', '11/11/02',3),
						  ('4141-B','Canutillos',15, 2, 'Segunda', '11/11/02',8);




/*1. Crear una rutina almacenada que nos de el total de artículos de un fabricante del
que conocemos su nombre y país.*/
use tienda;

DELIMITER $$
create procedure almacena2_1(v_Nombre varchar(15), v_Pais varchar(15))
 begin
declare numero_art int (4);
declare fin boolean default 0;
declare mi cursor for select count(a.Articulo) from articulos a inner join fabricantes f 
	on a.Cod_Fabricante =  f.Cod_Fabricante where f.Nombre = v_Nombre
	and f.Pais = v_Pais;
declare continue handler for not found set fin=1;
open mi;
repeat
fetch mi into numero_art;
if not fin then
select concat (numero_art)as 'Numero de empleados';
end if;
until fin end repeat;
close mi;
END $$

select * from fabricantes;
$$
call almacena2_1 ('CALVO', 'ESPAÑA') ;$$
$$
drop procedure almacena2_1
$$


/*2. Crear una rutina almacenada que actualice el precio de venta de los artículos de
una determinada categoría en una cantidad determinada, pero solo para aquellos
artículos donde el fabricante no es de España.
Sacar por pantalla, cuando finalice la actualización, “Actualización finalizada”.*/





DELIMITER $$
create procedure almacena2_2(v_Categoria varchar(10), v_PrecioNuevo float)
	begin
declare v_cod_articulo int (20);
declare fin boolean default 0;


declare mi cursor for select a.Cod_fabricante from  articulos  a inner join fabricantes f	
	on a.Cod_fabricante = f.Cod_fabricante
	where Categoria = v_Categoria and Pais != 'España';


 declare continue handler for not found set fin=1;

	open mi;
	repeat 
	fetch mi into v_cod_articulo;
if not fin then
update articulos set Precio_venta = v_PrecioNuevo where Cod_fabricante = v_cod_articulo;
	else
	select Articulo, Categoria, Precio_venta from Articulos;
	select concat ('Actualizacion terminada') as 'Mensaje';
	end if;
until fin 
end repeat;
close mi;
end $$
select Articulo, Categoria, Precio_venta from Articulos$$
call almacena2_2 ('Primera', '30')$$
drop procedure almacena2_2$$



/*3. Procedimiento que nos de el listado de ventas realizadas de los producto de un
determinado fabricante (conocido su nombre y país) en una determinada fecha.
Ventas del día XXXX, Fabricante XXXXXXX - XXXX
Artículo Peso Categoría Unidades*/
DELIMITER $$
create procedure almacena2_3(v_nombre varchar(20), v_pais varchar(15) )
begin
declare v_cod_fabricante int(11);
declare v_fabricante varchar (15);
declare v_articulo varchar (20);
declare v_peso int(11);
declare v_Categoria varchar(10);
declare v_unidades int(11);
declare v_fecha date;
declare fin boolean  default 0;

declare micursor cursor for 
	select f.Cod_Fabricante, f.Nombre, a.Articulo, a.Peso, a.Categoria, a.Existencias  
	from fabricantes f inner join articulos a
	where f.Nombre = v_nombre and Pais = v_pais;

declare cursor_fecha cursor for 
	select fecha_venta from ventas where Cod_Fabricante = v_cod_fabricante;

declare continue handler for not found set fin=1;

	open micursor;
	
	repeat 
fetch micursor 
	into v_cod_fabricante, v_fabricante, v_articulo, v_peso, v_Categoria, v_unidades;
	open cursor_fecha;
	repeat
fetch cursor_fecha into v_fecha;

if not fin then
select concat ('Ventas del día ', v_fecha,' Fabricante ', v_cod_fabricante, 
		' Articulo ', v_articulo, ' Peso ', v_peso, 'Kilo Categoria ', v_Categoria, ' ' , v_unidades , ' Unidades ' ) as 'Pedidos';
else
select concat ('Terminado') as 'Mensaje';

end if;
	until fin end repeat;
	until fin end repeat;
  close micursor;
close cursor_fecha;

END $$

call almacena2_3('CALVO', 'ESPAÑA')$$
select Nombre, Pais from fabricantes$$
drop procedure almacena2_3$$


/*4. Realizar un procedimiento que actualice el precio de venta de los artículos de una
determinada categoría según lo siguiente:
1. si las existencias son < 100 unidades, descuento del 50%
2. si las existencias están entre >= 100 y <=500 unidades,
descuento del 30%
3. si las existencias son >500 unidades, descuento del 10%
*/
DELIMITER $$
create procedure almacena2_4 (v_categoria varchar (10))
begin
declare v_unidades int(11);
declare fin boolean default 0;
declare mi cursor for select Existencias from articulos where Categoria = v_categoria;

declare continue handler for not found set fin=1;

	open mi;
	repeat 
	fetch mi into v_unidades;
if not fin then

	if v_unidades < 100 then
		update articulos set Precio_venta = Precio_venta + (Precio_venta * 0.50) 
		where Categoria = v_categoria;
	if v_unidades >= 100 and v_unidades<=500 then	
		update articulos set Precio_venta = Precio_venta + (Precio_venta * 0.30) 
		where Categoria = v_categoria;
	else
		update articulos set Precio_venta = Precio_venta + (Precio_venta * 0.10) 
		where Categoria = v_categoria;
	end if;

else  
	select  concat ('Teminado');

end if;
until fin end repeat;
  close mi;
	
END $$