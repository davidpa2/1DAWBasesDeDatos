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
delimiter;



create function encriptardes(c char(1), d int) returns char(1)
return char(ascii(c)+d);

create function desencriptardes(c char(1), d int) returns char(1)
return char(ascii(c)-d);

delimiter $$
create function encriptarcad( cad varchar(30), d int) returns varchar(30)
begin
declare cont int default 1;
declare salida varchar(30) default "";
while (cont <=length(cad)) do
set salida=concat(salida,encriptardes( substring(cad,cont,1) ,d));
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

delimiter $$
create function binario(n int) returns varchar(30)
begin
declare salida varchar(30) default "";
while (n>=2) do
set salida=concat(n%2,salida);
set n=truncate(n/2,0);
end while;
set salida=concat(n,salida);
return salida;
end $$
delimiter ;

delimiter $$
create function hexadecimal(n int) returns varchar(30)
begin
declare salida varchar(30) default "";
while (n>=16) do
if(n%16<10) then
set salida=concat(n%16,salida);
else
set salida=concat(pasarhex(n%16),salida);
end if;
set n=truncate(n/16,0);
end while;

if(n%16<10) then
set salida=concat(n,salida);
else
set salida=concat(pasarhex(n),salida);

end if;
set salida=concat(salida,'H');
return salida;
end $$
delimiter ;









delimiter $$
drop procedure if exist tablabinario;
create procedure tablabinario( a int, b int)
begin
if(a>b) then
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

delimiter $$
create procedure altausuario(u varchar(30), p1 varchar(30), p2 varchar(30))
begin
declare numero int;
create table if not exists usuarios (usuario varchar(30), pass varchar(30));
select count(*) into numero from usuarios where usuario=u;
if(numero=0) then
if(p1=p2) then insert into usuarios values(u, encriptarcad(p1,3));
else 
select "Contraseñas distintas" Error;
end if;
else
select "usuario ya existe" Error;
end if;
end $$
delimiter ;

delimiter $$
drop function if exists autenticar;
create function autenticar( u varchar(30), p varchar(30)) returns boolean
begin
declare salida boolean default true;
declare existe int default 0;
declare encriptada varchar(30) default "";
select count(*) into existe from usuarios where usuario=u;
if (existe=1 ) then
select pass into encriptada from usuarios where usuario=u;
if (encriptada=encriptarcad(p,3)) then
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

delimiter $$
drop function if exists palindromo;
create function palindromo(cadena varchar(40)) returns boolean
begin
declare salida boolean default true;
declare cont int default 1;
set cadena=quitarespacios(cadena);
while(salida=true and cont<=length(cadena)/2) do
if (substring(cadena, cont, 1)<>substring(cadena,-cont, 1)) then
set salida=false;
end if;
set cont=cont+1;
end while;
return salida;
end $$
delimiter ;

delimiter $$
drop function if exists quitarespacios;
create function quitarespacios(cadena varchar(40)) returns varchar(40)
begin
declare salida varchar(40) default "";
declare cont int default 1;
while (cont<=length(cadena)) do
if(substring(cadena,cont,1)<>" ")
then
set salida=concat(salida,substring(cadena,cont,1));
end if;
set cont=cont+1;
end while;
return salida;
end $$
delimiter ;

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


--Distancia entre dos puntos


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





