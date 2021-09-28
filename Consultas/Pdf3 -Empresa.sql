#Ejercicios-3 BD
#1. Calcular cuántos artículos hay de categoría Primera.
select count(articulo)'Numero de articulos por categoria', categoria from articulos group by categoria;

#2. Calcular cuantos artículos hay de categoría segunda y con un no de existencias mayor de 200 unidades.
select count(existencias), categoria, if ( count(existencias)> 200, 'no','yes' ) from articulos group by categoria having categoria = 'Segunda' ;

#3. Queremos saber cuántas unidades hay en stock, de media, de cada uno los Artículos. Se trata de calcular la media del campo Existencia.
select avg(existencias), articulo from articulos group by articulo;

#4. Queremos hacer un descuento del 25% a los artículos de categoría primera.
select precio_venta - (precio_venta * 0.25), articulo, categoria from articulos where categoria = 'Primera';

#5. Deseamos saber el nombre, categoría y existencias de los 8 artículos mas caros.


#6. Se desea ver todos los datos de las tiendas de código1111-A, 5555-B, 3333-N.
select * from tiendas where nif in ('1111-A', '5555-B', '3333-N');

#7. Obtener los datos del artículo/s que corresponda al pedido/s, con menor numero de unidades pedidas.
select distinct a.* from articulos a inner join pedidos p on a.cod_fabricante = p.cod_fabricante where p.unidades_pedidas = (select min(unidades_pedidas) from pedidos); #no funciona

#8. Se desea ver todos los datos de aquellos pedidos de la primera mitad del mes de marzo de 2013. Los resultados deben mostrarse en orden descendente por tienda.
select p.* from pedidos p where p.fecha_pedido between 2013-03-1  and 2013-03-15;

#9. Información de aquellos pedidos de agosto del 2012 de categoría primera o segunda.
select p.* from pedidos p where p.fecha_pedido between 2013-08-1 and 2013-03-31 and categoria in('Primera', 'Segunda');

#10. Indicar el total de unidades vendida del artículo macarrones de categoría primera.
Select count(unidades_pedidas)' Numero de unidades', categoria from pedidos where categoria = 'Primera';

#11. Indicar el total de existencias de barquillos de cualquier categoría.
select count(existencias)'Numero de barquillos' from articulos where articulo = 'barquillos';

#12. ¿Con cuantos fabricantes trabajamos.?
Select count(*)'Numero de fabricantes' from fabricantes;

#13. ¿Cuantas tiendas tenemos en la provincia de Toledo.?
select count(*)'Numero de tiendas' from tiendas where poblacion = 'Toledo';


#14. Obtener los datos del artículo que corresponda al pedido con mayor numero de unidades pedidas.
select a.* from articulos a inner join pedidos p on a.cod_fabricante= p.cod_fabricante  where p.unidades_pedidas = (select max(p.unidades_pedidas) from articulos);


#15. Datos del artículo/s con mayor no de unidades vendidas.
Select a.* from articulos a inner join ventas v on a.cod_fabricante= v.cod_fabricante where v.unidades_vendidas =(select max(unidades_vendidas) from ventas) ; 

#16. ¿Cuantas tiendas hay en la provincia de Madrid?
select count(*)'Numero de tiendas' from tiendas where provincia ='Madrid'; 

#17. Pedidos realizados en el primer trimestre del 2013.
select * from pedidos  where (fecha_pedido between '2013-03-01' and '2013-03-31');

#18 Ventas realizadas el 2 de abril de 2013, el 2 de julio de 2013 o el 2 de agosto de 2013.
select * from ventas where fecha_venta in ('2013-04-02', '2013-07-02', '2013-08-2');

#19 Información de los artículos pedidos por las tiendas con sufijo B.
select articulo from pedidos where nif like '%b';

#20 NIF de las tiendas que han hecho algún pedido de 10, 20 o 22 unidades.
Select t.nombre from tiendas t inner join pedidos p on t.nif = p.nif where p.unidades_pedidas in (10,20,22);

#21 Pedidos realizados a los fabricantes de España.
select p.*, f.pais from pedidos p inner join fabricantes f on p.cod_fabricante = f.cod_fabricante where f.pais ='España';

#22 Información completa de la tienda que ha realizado mas pedidos.
select * from tiendas where nif = (select nif from ventas where unidades_vendidas = (select max(unidades_vendidas) from ventas));

#23 Nombre y dirección completa de la tienda que ha hecho el pedido de mayor no de unidades.
select t.nombre, t.direccion, t.poblacion, t.provincia, p.unidades_pedidas from tiendas t  inner join pedidos p on t.nif = p.nif where p.unidades_pedidas = (select max(unidades_pedidas) from pedidos);

#24 Tiendas que han hecho algún pedido al fabricante de NIF 11111. ¿Qué artículos tienen mayor no de existencias?
select distinct t.nombre, a.existencias  from tiendas t inner join pedidos p on t.nif= p.nif inner join articulos a  on p.cod_fabricante= a.cod_fabricante where existencias =(select max(existencias) from articulos) and a.cod_fabricante = '1111-A'; # hay que separar

#25 ¿Qué tienda ha realizado mas pedidos?
select t.nombre from tiendas t inner join pedidos p on t.nif=p.nif where p.unidades_pedidas =(select max(unidades_pedidas) from pedidos);


#26 ¿De qué fabricante se han vendido mas unidades de un producto?
select f.nombre from fabricantes f inner join ventas v on f.cod_fabricante= v.cod_fabricante where v.unidades_vendidas = (select max(unidades_vendidas) from ventas);


# ¿Cuál es el artículo mas caro?
select * from articulos where Precio_costo=(select max(precio_costo) from articulos);

#27 NIF de las tiendas que han pedido el artículo mas caro.
select distinct t.nif from tiendas t inner join pedidos p on t.nif=p.nif where Articulo=(select articulo from articulos where precio_venta in(select max(precio_venta) from articulos));

#28 Información del fabricante que fabrica el artículo mas barato.
select * from fabricantes f inner join articulos a on f.cod_fabricante=a.cod_fabricante where a.Articulo=(select articulo from articulos where precio_costo in(select min(precio_costo) from articulos));

#29 ¿De qué fabricante/s tenemos mas pedidos?
select distinct * from fabricantes f inner join pedidos p on f.cod_Fabricante=p.cod_fabricante where Unidades_pedidas=(select max(Unidades_pedidas) from pedidos);

#30 Para cada pedido obtener el artículo, nombre y país del fabricante, fecha de pedido y unidades pedidas.
select distinct a.articulo, f.nombre, f.pais, p.fecha_pedido, p.Unidades_pedidas from pedidos p inner join fabricantes f on p.cod_fabricante=f.cod_fabricante inner join articulos a on p.Articulo=a.Articulo;

#31 Para cada venta obtener nombre y dirección completa de la tienda, fecha de la venta y unidades vendidas.
select t.nombre, t.direccion, v.fecha_venta,  v.Unidades_vendidas, v.articulo from ventas v inner join tiendas t on v.nif=t.nif group by articulo;
