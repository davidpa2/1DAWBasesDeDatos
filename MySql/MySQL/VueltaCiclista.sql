drop database if exists ciclismo;
create database if not exists ciclismo;
use ciclismo;

create table edicion (
    anio int(4) primary key,
    fechaIni date,
    fechaFin date,
    numEtapas int default 0
);

create table etapa (
    anio int(4),
    localidadSal varchar(20),
    localidadLle varchar(20),
    primary key (anio, localidadLle, localidadSal),
    constraint fk1 foreign key (anio) references edicion(anio) on update cascade on delete restrict,
    km float(7,2),
    tipo enum ('llana','montaña','cr') default 'llana',
    fecha date
);

create table tramo (
    anio int(4),
    localidadSal varchar(20),
    localidadLle varchar(20),
    numero int(2),
    primary key (anio, localidadLle, localidadSal, numero),
    constraint fk2 foreign key (anio, localidadSal, localidadLle) references etapa (anio, localidadLle, localidadSal) on update cascade on delete restrict,
    kmIni int,
    kmFin int,
    carretera varchar(10)
);

create table equipo (
    nombreEq varchar(20) primary key,
    director varchar(20),
    pais varchar(20)
);

create table ciclista (
    dni varchar(9) primary key,
    nombre varchar(20),
    fechaNac date
);

create table pertenece (
    dni varchar(9),
    nombreEq varchar(20),
    fechaIni date,
    fechaFin date default null,
    primary key (dni, nombreEq, fechaIni),
    constraint fk3 foreign key (dni) references ciclista(dni) on update cascade on delete restrict,
    constraint fk4 foreign key (nombreEq) references equipo(nombreEq)  on update cascade on delete restrict
);

create table corre (
    dni varchar(9),
    anio int(4),
    localidadSal varchar(20),
    localidadLle varchar(20),
    primary key (dni, anio, localidadSal, localidadLle),
    tiempo int
);

alter table corre add constraint fk5 foreign key (dni) references ciclista(dni)  on update cascade on delete restrict;
alter table corre add constraint fk6 foreign key (anio, localidadSal, localidadLle) references etapa(anio, localidadSal, localidadLle) on update cascade on delete restrict;

create table participa (
    anio int(4) primary key,
    dni varchar(9) primary key,
    constraint fk7 foreign key (dni) references ciclista(dni) on update cascade on delete restrict,
    constraint fk8 foreign key (anio) references edicion(anio) on update cascade on delete restrict,
    tiempoAcum int,
    puntos int
);

create table participaEq (
    nombreEq varchar(20) primary key,
    anio int(4) primary key,
    constraint fk9 foreign key (nombreEq) references equipo(nombreEq) on update cascade on delete restrict,
    constraint fk10 foreign key (anio) references edicion(anio) on update cascade on delete restrict,
    posicion int
);

create table puerto (
    nombrePu varchar(20) primary key,
    categoria int check (categoria > 0 and categoria <= 3)
);

create table pasa (
    dni varchar(9),
    anio int(4),
    localidadSal varchar(20),
    localidadLle varchar(20),
    nombrePu varchar(20),
    primary key (dni, anio, localidadSal, localidadLle, nombrePu),
    posicion int(2),
    constraint fk11 foreign key (dni) references ciclista(dni) on update cascade on delete restrict,
    constraint fk12 foreign key (anio, localidadLle, localidadSal) references edicion(anio, localidadLle, localidadSal) on update cascade on delete restrict,
    constraint fk13 foreign key (nombrePu) references puerto(nombrePu) on update cascade on delete restrict
);