drop database if exists ciclismo;
create database if not exists ciclismo;
use ciclismo;
create table edicion ( anno int(4) primary key, fecha_ini date, fecha_fin date, n_etapas int default 0);
create table etapa (anno int(4), local_sa varchar(20), local_lle varchar(20),
primary key (anno, local_sa, local_lle),
constraint fk1 foreign key (anno) references edicion(anno) on update cascade on delete restrict,
km float(7,2),
tipo enum ('llana','montaña', 'cr') default 'llana',
fecha date);
create table tramo(anno int(4), local_sa varchar(20), local_lle varchar(20), numero int(2),
primary key( anno, local_sa, local_lle,numero),
constraint fk2 foreign key (anno, local_sa, local_lle) references etapa(anno, local_sa, local_lle) on update cascade on delete restrict,
km_ini int,
km_fin int,
carretera varchar(10));
create table equipo (nombre_eq varchar(20) primary key, director varchar(20), pais varchar(20));
create table ciclista (dni varchar(9) primary key, nombre varchar(20), fec_nac date);

create table pertenece(dni varchar(9), nombre_eq varchar(20), fecha_ini date, fecha_fin date default null,
primary key (dni, nombre_eq, fecha_ini),
constraint fk3 foreign key (dni) references ciclista(dni) on update cascade on delete restrict,
constraint fk4 foreign key (nombre_eq) references equipo(nombre_eq) on update cascade on delete restrict);

create table corre( dni varchar(9),anno int(4), local_sa varchar(20), local_lle varchar(20),
primary key(dni, anno, local_sa, local_lle),
tiempo int);

alter table corre add constraint fk5 foreign key (dni) references ciclista(dni) on update cascade on delete restrict;
alter table corre add constraint fk6 foreign key (anno,local_sa, local_lle) references etapa(anno,local_sa, local_lle) on update cascade on delete restrict;

create table participa(dni varchar(9), anno int(4), tiempo_ac int, puntos int,
primary key(dni, anno),
constraint fk7  foreign key (dni) references ciclista(dni) on update cascade on delete restrict,
constraint fk8  foreign key (anno) references edicion(anno) on update cascade on delete restrict);

create table participa_equipo(nombre_eq varchar(20), anno int(4), poscion int,
primary key(nombre_eq, anno),
constraint fk9  foreign key (nombre_eq) references equipo(nombre_eq) on update cascade on delete restrict,
constraint fk10  foreign key (anno) references edicion(anno) on update cascade on delete restrict);

create table puerto (nombre_pu varchar(20) primary key,
categoria int check ( categoria >0 and categoria <=3));

create table pasa (dni varchar(9),anno int(4), local_sa varchar(20), local_lle varchar(20), nombre_pu varchar(20),
primary key(dni,anno, local_sa, local_lle, nombre_pu),
posicion int(2),

constraint fk11 foreign key (anno,local_sa, local_lle) references etapa(anno,local_sa, local_lle) on update cascade on delete restrict,
constraint fk12 foreign key (dni) references ciclista(dni) on update cascade on delete restrict,
constraint fk13 foreign key (nombre_pu) references puerto(nombre_pu) on update cascade on delete restrict
);

insert into edicion values (2020,'2020-10-10','2020-10-30',10);
insert into etapa values (2020,'Lucena','Baena',50,'montaña','2020-10-17');
insert into ciclista values('77H','pepe','2000-1-1');

delimiter $$

            /*Triggers on PASA*/

create trigger ai_pasa after insert on pasa
    for each row begin

        /*Crear un nuevo ciclista en la tabla participa si es la primera vez que se introduce un campo de él*/
        declare existe int default 1;

        select count(*) into existe from participa p where p.dni=new.dni and p.anno = new.anno;
        if (existe=0) then 
            insert into participa values (new.dni,0,0,0); 
        end if;

        /*Modificar los campos de participa*/

        if (new.posicion = 1) then
            update participa set participa.puntos = participa.puntos + 5
            where participa.dni = new.dni and participa.anno = new.anno;
        end if;
        if (new.posicion = 2) then
            update participa set participa.puntos = participa.puntos + 3
            where participa.dni = new.dni and participa.anno = new.anno;
        end if;
        if (new.posicion = 3) then
            update participa set participa.puntos = participa.puntos + 1
            where participa.dni = new.dni and participa.anno = new.anno;
        end if;

    end $$

create trigger ad_pasa after delete on pasa
    for each row
        if (old.posicion = 1) then
            update participa set participa.puntos = participa.puntos - 5
            where participa.dni = old.dni and participa.anno = old.anno;
        end if;
        if (old.posicion = 2) then
            update participa set participa.puntos = participa.puntos - 3
            where participa.dni = old.dni and participa.anno = old.anno;
        end if;
        if (old.posicion = 3) then
            update participa set participa.puntos = participa.puntos - 1
            where participa.dni = old.dni and participa.anno = old.anno;
        end if;

    end $$

create trigger au_pasa after update on pasa
    for each row
        
        if (new.posicion = 1) then
            update participa set participa.puntos = participa.puntos - 5
            where participa.dni = old.dni and participa.anno = old.anno;
        end if;
        if (new.posicion = 2) then
            update participa set participa.puntos = participa.puntos - 3
            where participa.dni = old.dni and participa.anno = old.anno;
        end if;
        if (new.posicion = 3) then
            update participa set participa.puntos = participa.puntos - 1
            where participa.dni = old.dni and participa.anno = old.anno;
        end if;


        if (new.posicion = 1) then
            update participa set participa.puntos = participa.puntos + 5
            where participa.dni = new.dni and participa.anno = new.anno;
        end if;
        if (new.posicion = 2) then
            update participa set participa.puntos = participa.puntos + 3
            where participa.dni = new.dni and participa.anno = new.anno;
        end if;
        if (new.posicion = 3) then
            update participa set participa.puntos = participa.puntos + 1
            where participa.dni = new.dni and participa.anno = new.anno;
        end if;
    end $$

        /*Triggers on CORRE*/

delimiter $$
create trigger ai_corre after insert on corre
    for each row begin
         /*Crear un nuevo ciclista en la tabla participa si es la primera vez que se introduce un campo de él*/
        declare existe int default 1;

        select count(*) into existe from participa p where p.dni=new.dni and new.anno=p.anno;
        if (existe=0) then 
            insert into participa values (new.dni,new.anno,0,0); 
        end if;

        update participa set tiempo_ac = tiempo_ac + new.tiempo where new.dni = participa.dni and new.anno=participa.anno;

    end $$

delimiter ;

create trigger ad_corre after delete on corre
    for each row begin
        update participa set old.tiempo_ac = old.tiempo_ac - old.tiempo where old.dni = participa.dni and old.anno=participa.anno;
    end $$

create trigger au_corre after update on corre
    for each row begin
        update participa set old.tiempo_ac = corre.tiempo_ac - old.tiempo where old.dni = participa.dni and old.anno=participa.anno;

        update participa set corre.tiempo_ac = corre.tiempo_ac + new.tiempo;
    end $$    

delimiter ;

insert into corre values ('77H',2020,'Lucena','Baena',3600);