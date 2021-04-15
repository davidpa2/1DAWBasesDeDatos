drop database if exists fiesta;
create database if not exists fiesta;
use fiesta;
create table plaza(
nombre varchar(20) primary key,
localidad varchar(20),
direccion varchar(20),
aforo int);

create table corrida(
feria varchar(20),
anno int(4),
orden tinyint unsigned,

plaza varchar(20),
constraint pk1 primary key (feria, anno, orden),
constraint fk4 foreign key (plaza) references plaza(nombre));

create table torero(
dni varchar(9) primary key,
nombre varchar(30),
apodo varchar(20) unique,
f_al date,
padrino varchar(9),
apoderado varchar(9),
constraint fk1 foreign key (padrino) references torero(dni) on update cascade on delete restrict);

create table actua(
dni varchar(9),
feria varchar(20),
anno int(4),
orden tinyint unsigned,
orejas tinyint unsigned default 0,
puerta enum ('si','no') default 'no',
primary key(dni, feria, anno, orden),
constraint fk2 foreign key (dni) references torero(dni) on update cascade on delete restrict,
constraint fk3 foreign key (feria,anno,orden) references corrida(feria, anno, orden)on update cascade on delete restrict);

create table ganaderia(
codigo int primary key,
nombre varchar(20),
localidad varchar(20),
f_fundacion int(4) unsigned);

create table toro(
codigo_g int,
numero int(4) unsigned,
primary key(codigo_g, numero),

nombre varchar(20),
fecha_n date,
color varchar(20),

feria varchar(20),
anno int(4),
orden tinyint unsigned);

alter table toro add constraint fk5 foreign key (codigo_g) references ganaderia(codigo) on update cascade on delete restrict;
alter table toro add constraint fk7 foreign key (feria, anno, orden) references corrida(feria, anno, orden) on update cascade on delete restrict;

