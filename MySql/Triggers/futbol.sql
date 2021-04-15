drop database if exists futbol;
create database if not exists futbol;
use futbol;
create table equipo (id int primary key, nombre varchar(20));
create table partido ( e1 int , e2 int , primary key (e1,e2), g1 int , g2 int, check (e1!=e2));
create table clasificacion( id int , puntos int, gf int, gc int);
insert into equipo values (1,'Real Madrid'),(2,'FC Barcelona'),(3,'Betis'),(4,'Sevilla FC');
insert into clasificacion values (1,0,0,0),(2,0,0,0),(3,0,0,0),(4,0,0,0);


/***************************************/



delimiter $$

create trigger ai_partido after insert on partido for each row
begin
declare existe int default 1;

select count(*) into existe from clasificacion c where c.id=new.e1;
if (existe=0) then 
insert into clasificacion values (new.e1,0,0,0); 
end if;

select count(*) into existe from clasificacion c where c.id=new.e2;
if (existe=0) then 
insert into clasificacion values (new.e2,0,0,0); 
end if;

if (new.g1>new.g2) then
update clasificacion c set puntos=puntos+3 where c.id=new.e1;
elseif(new.g1=new.g2) then update clasificacion c set puntos=puntos+1 where c.id=new.e1 or c.id=new.e2;
else update clasificacion c set puntos=puntos+3 where c.id=new.e2;
end if;

update clasificacion c set gf=gf+new.g1 where c.id=new.e1; 
update clasificacion c set gc=gc+new.g2 where c.id=new.e1;
update clasificacion c set gf=gf+new.g2 where c.id=new.e2; 
update clasificacion c set gc=gc+new.g1 where c.id=new.e2;


end $$

delimiter $$

create trigger ad_partido after delete on partido for each row
begin
if (old.g1>old.g2) then
update clasificacion c set puntos=puntos-3 where c.id=old.e1;
elseif(old.g1=old.g2) then update clasificacion c set puntos=puntos-1 where c.id=old.e1 or c.id=old.e2;
else update clasificacion c set puntos=puntos-3 where c.id=old.e2;
end if;

update clasificacion c set gf=gf-old.g1 where c.id=old.e1; 
update clasificacion c set gc=gc-old.g2 where c.id=old.e1;
update clasificacion c set gf=gf-old.g2 where c.id=old.e2; 
update clasificacion c set gc=gc-old.g1 where c.id=old.e2;


end $$

delimiter ;

delimiter $$
create trigger au_partido after update on partido for each row
begin

if (old.g1>old.g2) then
update clasificacion c set puntos=puntos-3 where c.id=old.e1;
elseif(old.g1=old.g2) then update clasificacion c set puntos=puntos-1 where c.id=old.e1 or c.id=old.e2;
else update clasificacion c set puntos=puntos-3 where c.id=old.e2;
end if;

update clasificacion c set gf=gf-old.g1 where c.id=old.e1; 
update clasificacion c set gc=gc-old.g2 where c.id=old.e1;
update clasificacion c set gf=gf-old.g2 where c.id=old.e2; 
update clasificacion c set gc=gc-old.g1 where c.id=old.e2;

if (new.g1>new.g2) then
update clasificacion c set puntos=puntos+3 where c.id=new.e1;
elseif(new.g1=new.g2) then update clasificacion c set puntos=puntos+1 where c.id=new.e1 or c.id=new.e2;
else update clasificacion c set puntos=puntos+3 where c.id=new.e2;
end if;

update clasificacion c set gf=gf+new.g1 where c.id=new.e1; 
update clasificacion c set gc=gc+new.g2 where c.id=new.e1;
update clasificacion c set gf=gf+new.g2 where c.id=new.e2; 
update clasificacion c set gc=gc+new.g1 where c.id=new.e2;

end $$
delimiter ;







