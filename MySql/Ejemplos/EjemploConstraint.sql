drop database if exists ejemplo1;

create database ejemplo1;

use ejemplo1;

create table localidad(
cp int(5) primary key,
nombre varchar(20) unique);

create table usuario (dni varchar(9) primary key,
nombre varchar(20),
apellido varchar(20),
cp int(5),
pass varchar(128),
saldo int default 0 check (saldo>=0),
constraint uq2 unique(nombre, apellido),
constraint fk1 foreign key (cp) references localidad(cp));

insert into localidad values(14900, 'Lucena'),(14940, 'Cabra'),(14850,'Baena');
insert into usuario values('22G', 'Pepe', 'Perez', 14850, md5('aa'),33);