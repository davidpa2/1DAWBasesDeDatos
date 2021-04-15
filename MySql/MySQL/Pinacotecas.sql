drop database if exists pinacotecas;

create database if not exists pinacotecas;

use pinacotecas;

create table pinacoteca (
nombre varchar(30) primary key,
cuidad varchar(30) not null,
direccion varchar(50),
mm float(7,2),
fecha date );

create table pintor (
nombre varchar(20) primary key,
maestro varchar(20),
escuela varchar(20),
pais varchar(20),
fechaNac date,
fechaDec date,
constraint fk1 foreign key (maestro) references pintor(nombre));

create table escuela (nombre varchar(20) primary key,
pais varchar(20),
fechaCre date);

alter table pintor add constraint fk2 foreign key (escuela) references pintor(nombre);

create table mecenas (
nombre varchar(20) primary key,
pais varchar(20));

create table mecenazgo(nombreP varchar(20),
nombreM varchar(20),
fechaIn date,
fechaFin date,
primary key (nombreP, nombreM, fechaIni),
foreign key (nombreP) references pintor(nombre),
foreign key (nombreM) references mecenas(nombre));

insert into pinacoteca values('El Prado', 'Madrid', 'PaseoRecoletos', 2000, '1820-10-01');
insert into cuadro values(12, 'Las Meninas', 20, 1650, 'El Prado');