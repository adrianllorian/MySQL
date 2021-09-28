create database ebanco;
use ebanco;
create table bancos(
cod_banco int(4),
identificador int(9),
nombre char(30),
dirección char(40),
población char (20),
primary key (cod_banco))engine=InnoDB;

create table sucursal(
cod_banco int(4),
num_oficina int (4),
nombre char (30),
dirección char(40),
población char(20),
provincia char (20),
primary key (cod_banco, num_oficina), 
foreign key (cod_banco) references bancos(cod_banco))engine=InnoDB;

create table cuenta(
cod_banco int (4),
num_oficina int (4),
num_cta int(4),
fecha_apertura date,
titular char (20),
población char (20),
saldo float (10,3),
primary key (cod_banco, num_oficina, num_cta),
foreign key (cod_banco, num_oficina) references sucursal(cod_banco, num_oficina))engine=InnoDB;

create table movimientos(
num_movimiento int auto_increment,
cod_banco int (4),
num_oficina int(4),
num_cta int (4),
fecha date,
tipo enum ('I','R'),
cantidad float (10,3),
primary key(num_movimiento, cod_banco, num_oficina, num_cta),
foreign key (cod_banco, num_oficina, num_cta) references cuenta (cod_banco, num_oficina, num_cta))engine=innoDB;


/*---------------------------------------*/

INSERT INTO BANCOS VALUES(1111,'122322223','BANCO DE ESPAÑA','GRAN VIA','MADRID');
INSERT INTO BANCOS VALUES(1112,'222322223','BANCO DE GUADALAJARA','MAYOR',
'GUADALAJARA');
INSERT INTO BANCOS VALUES(1113,'322322223','BANCO POPULAR','LA PLAZA','TOLEDO');
INSERT INTO BANCOS VALUES(1114,'422322223','CAJA CM','RIO DULCE','ALBACETE');




/*----------------------------------------*/

INSERT INTO sucursal VALUES(1111, 5000,'* SUCURSAL 1*', 'ANCHA 24','TOLEDO','TOLEDO');
INSERT INTO sucursal VALUES(1111, 5001,'* SUCURSAL 2*', 'PILON 33','PASTRANA','GUADALAJARA');
INSERT INTO sucursal VALUES(1112, 6000,'* SUCURSAL 6000*', 'MAYOR 55', 'ALCALA','ALCALA');
INSERT INTO sucursal VALUES(1113, 4000,'* SUCURSAL 4000*', 'ERAS 77', 'ARANJUEZ','MADRID');

/*---------------------------------*/
SET FOREIGN_KEY_CHECKS = 0;
INSERT INTO CUENTA VALUES(1111, 5000,123456789,CURDATE()-7,'JUAN','TOLEDO',2000);
INSERT INTO CUENTA VALUES(1111, 5000,123456788,CURDATE() -6,'PEDRO','TOLEDO', 15000);
INSERT INTO CUENTA VALUES(1111, 5001,123456787,CURDATE()-1,'ANA','GUADALAJARA',30000);
INSERT INTO CUENTA VALUES(1111, 5001,123456786,CURDATE()-6,'MANUEL','GUADALAJARA',10000);
INSERT INTO CUENTA VALUES(1111, 5001,123456785,CURDATE()-2,'ANDRES','ALCALA',22500);
INSERT INTO CUENTA VALUES(1112, 6000,33334444, CURDATE(),'ISABEL','MADRID',145);
INSERT INTO CUENTA VALUES(1112, 6000,33334440, CURDATE(),'MARIA','MADRID',552623);
SET FOREIGN_KEY_CHECKS = 1;

/*--------------------------------------*/


INSERT INTO MOVIMIENTOS(cod_banco,num_oficina,num_cta,fecha,tipo,cantidad) VALUES(1112, 6000,33334444, CURDATE(),'I',1000);
INSERT INTO MOVIMIENTOS (cod_banco,num_oficina,num_cta,fecha,tipo,cantidad) VALUES(1112, 6000,33334444, CURDATE()-1,'I',2000);
INSERT INTO MOVIMIENTOS (cod_banco,num_oficina,num_cta,fecha,tipo,cantidad) VALUES(1112, 6000,33334444, CURDATE()-2,'R',100);
INSERT INTO MOVIMIENTOS (cod_banco,num_oficina,num_cta,fecha,tipo,cantidad) VALUES(1112, 6000,33334444, CURDATE(),'R',5000);
INSERT INTO MOVIMIENTOS (cod_banco,num_oficina,num_cta,fecha,tipo,cantidad) VALUES(1112, 6000,33334440, CURDATE()-1,'R',200);
INSERT INTO MOVIMIENTOS (cod_banco,num_oficina,num_cta,fecha,tipo,cantidad) VALUES(1112, 6000,33334440, CURDATE(),'I',200);
INSERT INTO MOVIMIENTOS (cod_banco,num_oficina,num_cta,fecha,tipo,cantidad) VALUES(1111, 5000,123456789,CURDATE(),'I',100);
INSERT INTO MOVIMIENTOS (cod_banco,num_oficina,num_cta,fecha,tipo,cantidad) VALUES(1111, 5000,123456789,CURDATE()-2,'R',200);
INSERT INTO MOVIMIENTOS (cod_banco,num_oficina,num_cta,fecha,tipo,cantidad) VALUES(1111, 5000,123456789,CURDATE(),'I',300);
INSERT INTO MOVIMIENTOS (cod_banco,num_oficina,num_cta,fecha,tipo,cantidad) VALUES(1111,5000,123456788,CURDATE()-8,'I',200);
INSERT INTO MOVIMIENTOS (cod_banco,num_oficina,num_cta,fecha,tipo,cantidad) VALUES(1111, 5001,123456787,CURDATE()-5,'R',198);
INSERT INTO MOVIMIENTOS (cod_banco,num_oficina,num_cta,fecha,tipo,cantidad) VALUES(1111, 5001,123456786,CURDATE(),'I',998);
