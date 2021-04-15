create table especie (
	nombreCientífico varchar(30) primary key
);

create table animal (
	nombreAl varchar(30) primary key,
	foreign key (nombreAl) references Especie(nombreCientífico),
	numPatas int
);

create table vegetal (
	nombreVe varchar(30) primary key,
	foreign key (nombreVe) references Especie(nombreCientífico),
	tipoHoja enum (caduca, perenne) default caduca
);

create table alimenta(
	nombreAl varchar(30) primary key,
	nombreVe varchar(30) primary key,
	foreign key (nombreVe) references Vegetal(nombreVe),
	foreign key (nombreAl) references Animal(nombreAl)
);