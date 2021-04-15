drop database if exists ajedrez;

create database if exists ajedrez;

use ajedrez;

create table partida (
    nFedBlancas varchar(20) primary key,
    nFedB varchar(20) primary key,
    nFedNegras varchar(20) primary key,
    nFedN varchar(20) primary key,
    fecha date primary key
);

create table movimiento(
    nFedBlancas varchar(20),
    nFedB varchar(20),
    nFedNegras varchar(20),
    nFedN varchar(20),
    nMov int unsigned,
    casillaOrig varchar(10),
    casillaDest varchar(10)
);

create table federacion(
    nombre varchar(20) primary key,
    pais varchar(20),
    telf int unsigned,
    fechaCre date    
);

create table jugador(
    nomFeder varchar(20),
    nFederado int unsigned,
    nombre varchar(20) primary key,
    apellido varchar(20),
    dirPostal int(5) unsigned,
    dirElect varchar(40)
);

create table hotel(
    
);

create table jornada(

);

create table sala(
    capacidad int unsigned,
    medios enum ('radio', 'television', 'video')
);