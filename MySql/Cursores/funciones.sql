-----------------------------------Intercambia--------------------------------------
delimiter $$

drop procedure if exists intercambiar $$
create procedure intercambiar ( inout x int , inout y int)
begin
declare aux int;
set aux=x;
set x=y;
set y=aux;
end $$
delimiter ;

-------------------------------------Crea dos tablas una de pares y otra de impares-----------------------------------
delimiter $$

drop procedure if exists p1 $$
create procedure p1 (a int, b int)
begin
drop table if exists pares; 
drop table if exists impares;
create table if not exists pares (n int);
create table if not exists impares (n int);


if(a>b) then
call intercambiar(a,b);

end if;

while (a<=b) do


if (a%2=0) then
insert into pares values(a);
else 
insert into impares values(a);
end if;
set a=a+1;

end while;

end $$

delimiter ;

----------------------------------------Factoriales------------------------------------
delimiter $$

create function factorial(n int) returns int deterministic
begin
declare salida int default 1;
while (n>=1) do
set salida=salida*n;
set n=n-1;
end while;
return salida;
end $$
delimiter ;

-----------------------------------------Busca Primos-----------------------------------
delimiter $$
create procedure buscarprimos (a int,b int)
begin
drop table if exists primos;
create table primos (n int);
if(a>b) then 
call intercambiar(a,b);
end if;
while(a<=b) do
if (primo(a)=1) then insert into primos values(a);
end if;
set a=a+1;
end while;
end $$
delimiter ;

------------------------------Pasar a Hexadecimal----------------------------------------

delimiter $$
create function pasarhex( n int) returns char(1)
begin
declare c char(1);
case n
when 10 then set c='A';
when 11 then set c='B';
when 12 then set c='C';
when 13 then set c='D';
when 14 then set c='E';
when 15 then set c='F';
else set c='X';
end case;
return c;
end $$
delimiter ;

-----------------------Ejercicio 2--------------------------------------------

create function encriptardes(c char(1), d int) returns char(1)
return char(ascii(c)+d);


create function desencriptardes(c char(1), d int) returns char(1)
return char(ascii(c)-d);




----------------------Ejercicio 3-----------------------------------

delimiter $$
create function encriptarcad( cad varchar (30), d int) return varchar(30)
begin
declare cont int default 1;
declare salida varchar(30) default "";
while (cont <=length(cad))do
set salida=concat(salida,encriptardes(substring(cad, cont, 1), d));

set cont=cont+1;
end while;
return salida;
end $$
delimiter ;



delimiter $$
create function desencriptarcad( cad varchar(30), d int) returns varchar(30)
begin
declare cont int default 1;
declare salida varchar(30) default "";
while (cont <=length(cad)) do
set salida=concat(salida,desencriptardes( substring(cad,cont,1) ,d));
set cont=cont+1;
end while;
return salida;
end $$
delimiter ;

-----------------------------------------Binario---------------------------------

delimiter $$
create function binario (n int) returns varchar(30)
begin
declare salida varchar(30) default "";
while (n >=2) do
set salida = concat(n%2, salida);
set n = truncate(n/2, 0)
end while;
set salida = concat(n, salida);
return salida
end $$
delimiter ;


----------------------------------Tabla decimal, binario-----------------

delimiter $$
create procedure tablabinario(a int, b int)
beginif(a>b)  then
call intercambiar(a,b);
end if;
drop table if exists tb;
create table tb(decim int, binario varchar(30));
while (a<=b) do
insert into tb values (a,binario(a));
set a=a+1;
end while;
end $$
delimiter ;



------------------------------------Hexadecimal----------------------------------
delimiter $$
create function hexadecimal (n int) returns varchar(30)
begin
declare salida varchar(30) default "";
while (n >=16) do
if(n%16<10) then
set salida = concat(n%16, salida);
else
set salida=concat(pasarhex(n%16),salida);
end if;
set n = truncate(n/16, 0)
end while;
if(n%>16<10) then
set salida = concat(n, salida);
elseset salida=concat(pasarhex(n),salida);
end if;
set salida=concat(salida,'H');
return salida
end $$
delimiter ;








---Inversa binario
------------------------------------Encriptar usuario y contraseña--------------------------------------
delimiter $$
create procedure altausuario(u varchar(30), p) varchar(30), p2 varchar(30);
begin 
declare numero m1;
create table if not exists usuarios(usuario varchar(30) primary key, pass varchar(30));
select count(*) into umero from usuarios where usuario=u;
if(numero=0) then
if(p1=p20) then insert into usuarios values(u, encriptarcad(p1,3));
else
select "contraseñas distintas" Error;
end if;
else
select "usuario ya existe" Error;
end if
end $$
delimiter;

----------Crear una función que autentifique retornando un booleano si el usuario y contraseña introducido como argumento es usuario del sistema o no-------
delimiter $$
drop function if exists autenticar;
create function autenticar( u varchar(30), p varchar(30)) returns boolean
begin
declare salida boolean default true;
declare existe int default 0;
declare encriptada varchar(30) default "";
select count(*) into existe from usuarios where usuario=u;
if (existe=1) then 
select pass into encriptada where usuario=u;
if(encriptada=encriptarcad(p, 3)) then 
set salida=true;
else
set salida=false;
end if;
else
set salida=false;
end if;
return salida;
end$$
delimiter ;


-------------------Crear una función que retorno una cadena de caracteres sin espacios en blanco (no se permite la función replace()).----------------------
delimiter $$
drop function if exists quitarespacios;
create function quitarespacios varchar(30) returns varchar(30)
begin
declare salida varchar(30) default "";
declare cont int default 1;
while (cont<=length(cadena)) do
if (substring(cadena, cont, 1)<>" ") 
then
set salida=concat(salida, substring(cadena, cont, 1));
end inf;
set cont=cont+1;
end while;
return salida;
end$$
delimiter ;



------------Crear una función que te indique si un cadena de caracteres es un palíndromo o no.----------------------
create function palindromo varchar(30) returns boolean
begin
declare salida boolean default true;
declare cont int default 1;
while (salida=true and cont<=length(cadena)/2) do 
if(substring(cadena, cont, 1) <> substring(cadena, -count, 1)) then   --<>significa distinto --
set salida=false;
end if;
set cont=cont+1;
end while;
return salida;
end $$
delimiter ;


----------------------------------------------------------------------------------------

create procedure mensaje() 
select "Mensaje desde handler";


set @y=0;
delimiter $$
drop procedure if exists excepcion;
create procedure excepcion( x int) 
begin
declare continue handler FOR SQLSTATE '23000'  call mensaje();



create table if not exists numeros ( n int primary key);
insert into numeros values(x);
select "Procedimiento terminado" Mensaje;
end $$
delimiter ;



--------------------------------------------------------------------------------------------



---------------------------------------------Folio de ejercicios------------------------------------------------------


--Crea un procedimiento que introduzca en una tabla las soluciones de una ecuación de
--segundo grado (a,b,c s1, s2). Si las soluciones no son reales los campos s1(solución 1) y
--s2(solución 2) deben introdcir NULL. Evitar con un handler que los datos de la ecuación 
--ya están introducidos en la tabla. Crear la tabla si no está ya creada(create if not exists).


----------------------------------------------------------------------------------------------------------------------

/* CURSORES */
delimiter $$
create function puntosPiloto (n int) returns int deterministic
begin
declare salida int default 0;
declare fin int default 0; --mientras esta variable sea 0 el cursor va a seguir, para terminar el bucle tenemos que cambiarlo a 1
declare p int default 0;
declare pf int default 0;
declare nomCursor cursor for select piloto, puntos from carrera where piloto=1;
declare continue handler for sqlstate '02000' set fin=1;
open nomCursor; --crea un puntero al primer registro del cursor
fetch nomCursor into p, pf; --lee la tupla
while (fin = 0) do
if (pf = 1) then set  salida= salida + 20;
elseif (pf = 2) then set salida = salida + 15;
elseif (pf = 3) then set salida = salida + 10;
end if;
fetch nomCursor into p, pf; --cargamos los nuevos datos. El cursor avanza solo
end while;
close nomCursor; --cerramos cursor
return salida;
end $$
delimiter ;

02000 - Fin cursor
23000 - Clave repetida
/*
** ORDEN *
variables, condiciones, cursores, handler
Hoy Alejandro ha explicado cursores
*/



------------------------------------------------------------Distancia entre dos puntos------------------------------------------------



drop function distancia;
create function distancia(x1 float(5,2) ,y1 float(5,2) , x2 float(5,2), y2 float(5,2)) returns float(5,2)
return sqrt( pow(x1-x2,2) +pow(y1-y2,2));

delimiter $$
drop function if exists matricula;
create function matricula() returns varchar(8)
begin
declare salida varchar(8) default "";
declare cont int default 0;
declare letra char(1);
while (cont<3) do
set letra=char(truncate(26*rand(),0)+65);
while(letra='A' or letra='E' or letra='I' or letra='O' or letra='U') do
set letra=char(truncate(26*rand(),0)+65);
end while;
set salida= concat(salida, letra);

set cont=cont+1;
end while;
return salida;

end $$
delimiter ;


----Cursor
---------------------------------------------------Introducir el nombre del piloto y calculo de sus puntos-----------------------------------

create table clasifcacion(nombre varchar(25) primary key, puntos int);
delimiter $$
create procedure puntospiloto(n varchar(25))
begin
declare salida int default 0;
declare nombrep varchar(25);
declare pf int;

declare cur1 cursor for select nombre, pos_fin from participa pa, piloto p where pa.dorsal=p.dorsal  and pa.dorsal=n; 

declare continue handler for sqlstate '02000' set fin = 1;

open cur1;
fetch cur1 into nombrep, pf;
while(fin=0) do
if (pf = 1) then set  salida= salida + 20;
elseif (pf = 2) then set salida = salida + 15;
elseif (pf = 3) then set salida = salida + 10;
elseif (pf = 4) then set salida = salida + 5;
elseif (pf = 5) then set salida = salida + 1;
end if;
fetch cur1 into nombrep, pf;

end while;
insert into clasificacion (nombrep, salida);
close cur1;

end $$
delimiter ;


/*

Sobre la base de autos
1- Alterar la table VENTAS, para añadir una matricula a cada cochee (8888 - aaa)
2- Dar a cada coche una matricula de forma aleatoria, cursor
3- Crear una tabla donde se almacenará las matriculas de los coches vendidos que sean capicua los números. (Utiliza la funcion palindromo)

*/



----------------------------------Alterar la table VENTAS, para añadir una matricula a cada cochee (8888 - aaa)-----------------------------

delimiter $$
create function matricula;
create function matricula() returns varchar(8)
begin declare matricula varchar()





--Cursor
--------------
delimiter $$
drop function if exists  puntos;
create function puntos(n int) returns int
begin
declare salida int default 0;
declare p int;
declare pf int;
declare fin int default 0;
declare cur1 cursor for SELECT piloto.nombre, pos_fin FROM participa , piloto   where partipa.dorsal=piloto.dorsal and dorsal=n;
declare CONTINUE HANDLER FOR SQLSTATE '02000' SET fin = 1;

open cur1;
fetch cur1 into p, pf;
while(fin=0) do
if (pf=1) then set salida=salida+20;
elseif (pf=2) then set salida=salida+15;
elseif (pf=3) then set salida=salida+10;
elseif (pf=4) then set salida=salida+5;
elseif (pf=5) then set salida=salida+1;
end if;
fetch cur1 into p, pf;
end while;
close cur1;
return salida;
end $$
delimiter ;


--Doble cursor , crear una tabla clasificacion con todos pilotos
---------------------------------------------------------------------------------------------------------------
delimiter $$
drop procedure if exists crearclasificacion;
create procedure  crearclasificacion()
begin
declare fin int default 0;
declare nombrep varchar(25);
declare nombrepiloto varchar(25);
declare dor_c1 int;
declare dor_c2 int;
declare pf int;
declare puntospiloto int default 0;

declare cur1 cursor for SELECT distinct dorsal from piloto;
declare cur2 cursor for SELECT  p.dorsal,nombre, pos_fin from participa pa, piloto p where pa.dorsal=p.dorsal;
declare CONTINUE HANDLER FOR SQLSTATE '02000' SET fin = 1;

drop table if exists clasificacion2;
create table if not exists clasificacion2( dorsal int primary key, nombre varchar(25), puntos int);

open cur1;
fetch cur1 into dor_c1;
while (fin=0) do
open cur2;
fetch cur2 into dor_c2, nombrep, pf;
set nombrepiloto=nombrep;
while(fin=0) do 
if(dor_c1=dor_c2) then
if (pf=1) then set puntospiloto=puntospiloto+20;
elseif (pf=2) then set puntospiloto=puntospiloto+15;
elseif (pf=3) then set puntospiloto=puntospiloto+10;
elseif (pf=4) then set puntospiloto=puntospiloto+5;
elseif (pf=5) then set puntospiloto=puntospiloto+1;

end if;
end if;
fetch cur2 into dor_c2, nombrep, pf;
end while;
insert into clasificacion2 values(dor_c1,nombrepiloto,puntospiloto);
close cur2;
set puntospiloto=0;
set fin=0;
fetch cur1 into dor_c1;
end while;
close cur1;
end $$
delimiter ;



--------------------------------------------------Ejercicio 3 TirarDos Dados------------------------------------------------------------------------------
delimiter $$
create procedure lanzardados(inout d1 int, inout d2 int)
begin
set d1=truncate (rand()* 6 + 1, 0);
set d2=truncate (rand()* 6 + 1, 0);
insert into tablaresultadosdados values (d1, d2);
end $$
delimiter ;



-------------------------------------------------------------Calcular Distancia------------------------------
delimiter $$
drop function if exists calculardistancia;
create function introducirpuntos() returns float(5,2)
begin
declare salida float(5,2) default 0;
declare px1 float(5,2) default 0;
declare px2 float(5,2) default 0;
declare px3 float(5,2) default 0;
declare salida float(5,2) default 0;







