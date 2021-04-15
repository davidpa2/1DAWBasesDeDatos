drop database if exists santiago;

create database if not exists santiago;

use santiago;

create table camino(
    nombre varchar(30) primary key,
    nKM int(4),
    tiempo int
);

create table etapa(
    nCamino int(4),
    nombreCamino varchar(30),
    localidadSal varchar(20),
    localidadLle varchar(20),
    km int,
    tiempo int,
    primary key (nombreCamino, nCamino),
    constraint fk1 foreign key (nombreCamino) references camino(nombre),
    on update cascade on delete restrict
);

create table localidad(
    CP varchar(5) primary key,
    nombre varchar(20),
    CA varchar(20)
);

alter table etapa add constraint fk2 foreign key (localidadSal) references localidad(CP);
on update cascade on delete restrict;
alter table etapa add constraint fk3 foreign key (localidadLle) references localidad(CP);
on update cascade on delete restrict;

--Introducir datos:
insert into localidad values('14850','Baena','AN');
insert into camino values('ViaVerdeBaena','20','30000');
--insert into etapa values('1','ViaVerdeBaena','14850','14850','20','30000');

create table pasa(
    nomEt varchar(30),
    numEt int(4),
    CP varchar(5) unsigned,
    primary key (nomEt, numEt, CP),
    constraint fk4 foreign key (nomEt, numEt) references etapa(nombreCamino,nCamino),
    constraint fk5 foreign key (CP) references localidad(CP),
    on update cascade on delete restrict
);

create table albergue(
    nombre varchar(20) primary key,
    capacidad int(5),
    precio float(8,2),
    CP varchar(5),
    constraint fk6 foreign key (CP) references localidad(CP),
    on update cascade on delete restrict
);

create table peregrinos(
    numID int(5) primary key,
    nombre varchar(20),
    direccion varchar(50),
    localidades int(4) unsigned,
    dia date,
);

create table peregrinoPasa(
    ID int(5),
    CP varchar(20) unsigned,
    dia date,
    primary key (ID,CP),
    constraint fk7 foreign key (CP) references localidad(CP),
    on update cascade on delete restrict,
    constraint fk8 foreign key (ID) references peregrinos(numID),
    on update cascade on delete restrict
);