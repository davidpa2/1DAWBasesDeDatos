drop database if exists dpadilla;
create database if not exists dpadilla;
use dpadilla;

create table juego(
    titulo varchar(30) primary key,
    edadRec int(2),
    tipo varchar(20),
    precio float(4,2),
    ejemplaresVendidos int(100)
);

create table ejemplar(
    numEjemplar int(4),
    titulo varchar(30),
    estado varchar(20),
    primary key (numEjemplar, titulo),
    constraint fk1 foreign key (titulo) references juego(titulo)
    on update cascade on delete restrict
);

create table socio(
    numSocio int(4) primary key,
    nombre varchar(10),
    apellido varchar(15),
    telefono int(9)
);

create table compra(
    numSocio int(4),
    titulo varchar(30),
    cantEjemplares int(2),
    fechaCompra date,
    primary key (numSocio,titulo),
    constraint fk2 foreign key (numSocio) references socio(numSocio)
    on update cascade on delete restrict,
    constraint fk3 foreign key (titulo) references juego(titulo)
    on update cascade on delete restrict
);

create table consola(
    nombre varchar(20) primary key,
    fechaPres date
);

create table desarrollado(
    titulo varchar(30),
    nombre varchar(20),
    primary key (titulo, nombre),
    constraint fk4 foreign key (titulo) references juego(titulo)
    on update cascade on delete restrict,
    constraint fk5 foreign key (nombre) references consola(nombre)
    on update cascade on delete restrict
);

/*TRIGGERS*/

delimiter $$

create trigger ai_ejempVend after insert on compra
    for each row begin
    update juego set juego.ejemplaresVendidos = juego.ejemplaresVendidos + new.cantEjemplares
    where new.titulo = juego.titulo;
    end $$


create trigger ad_ejempVend after delete on compra
    for each row begin
    update juego set juego.ejemplaresVendidos = juego.ejemplaresVendidos - old.cantEjemplares
    where old.titulo = juego.titulo;
    end $$


create trigger au_ejempVend after update on compra
    for each row begin
    update juego set juego.ejemplaresVendidos = juego.ejemplaresVendidos - old.cantEjemplares
    where old.titulo = juego.titulo;
    update juego set juego.ejemplaresVendidos = juego.ejemplaresVendidos + new.cantEjemplares
    where new.titulo = juego.titulo;
    end $$

delimiter ;

/*INSERTS*/

insert into juego values ('TheLastOfUs', 18, 'accion', 20.32, 0),
                         ('GodOfWar', 12, 'aventura', 15.74, 0),
                         ('HorizonZeroDown', 16, 'accion', 46.99, 0),
                         ('RocketLeague', 8, 'deportes', 19.99, 0),
                         ('Minecraft', 12, 'plataformas', 25.50, 0),
                         ('SuperMarioMaker2', 8, 'plataformas', 60.40, 0),
                         ('SuperMario3DLand', 8, 'plataformas', 39.49, 0);

insert into ejemplar values (1,'TheLastOfUs', 'bueno'),
                            (2,'TheLastOfUs', 'deteriorado'),
                            (3,'TheLastOfUs', 'nuevo'),
                            (4,'TheLastOfUs', 'bueno'),
                            (1,'GodOfWar', 'deteriorado'),
                            (2,'GodOfWar', 'malo'),
                            (1,'HorizonZeroDown', 'deteriorado'), 
                            (2,'HorizonZeroDown', 'bueno'),
                            (3,'HorizonZeroDown', 'nuevo'),
                            (1,'RocketLeague', 'malo'),
                            (1,'SuperMarioMaker2', 'nuevo'),
                            (2,'SuperMarioMaker2', 'deteriorado'),
                            (1,'SuperMario3DLand', 'bueno');

insert into socio values (1, 'Paco', 'Jones', 681531923),
                         (2, 'Lali', 'Cuadora', 648274842),
                         (3, 'Lola', 'Mento', 615985835),
                         (4, 'Elsa', 'Pito', 663246147),
                         (5, 'Jorge', 'Nitales', 687143724);                       

insert into compra values (1,'TheLastOfUs', 2, '2021-03-04'),
                          (3,'RocketLeague', 1, '2021-01-25'), 
                          (5,'GodOfWar', 1, '2021-02-14'),
                          (1,'HorizonZeroDown', 1, '2020-12-12'),
                          (2,'HorizonZeroDown', 3, '2020-12-25'),
                          (4,'TheLastOfUs', 2, '2021-01-05'),
                          (3,'SuperMarioMaker2', 1, '2021-03-04'),
                          (1,'SuperMarioMaker2', 1, '2021-01-25'),
                          (4,'SuperMario3DLand', 1, '2020-06-06');                            
                                                  
insert into consola values ('PlayStation4', '2013-11-15'),
                           ('XBoxOne', '2013-11-22'),
                           ('NintendoSwitch' ,'2017-03-03'),
                           ('PlayStation5', '2020-11-19'),
                           ('Nintendo3DS', '2011-02-26');

insert into desarrollado values ('TheLastOfUs','PlayStation4'),
                                ('GodOfWar', 'PlayStation4'),
                                ('RocketLeague', 'XBoxOne'),
                                ('RocketLeague', 'PlayStation4'),
                                ('RocketLeague', 'NintendoSwitch'),
                                ('HorizonZeroDown', 'PlayStation4'), 
                                ('HorizonZeroDown', 'XBoxOne'),
                                ('Minecraft', 'NintendoSwitch'),
                                ('Minecraft', 'PlayStation4'),
                                ('SuperMarioMaker2', 'NintendoSwitch'),
                                ('SuperMario3DLand', 'Nintendo3DS');


/*Realizar una función que devuelva la suma de los precios de todos los juegos cuyo tipo
sea el que se le diga. Por ejemplo: plataformas, aventura, deportes...*/

delimiter $$

drop function if exists precioTotalPlataforma;
create function precioTotalPlataforma(tipoJuego varchar(30)) returns float(5,2) deterministic
begin 
    declare precioTotal float(5,2) default 0;
    declare precio float(4,2);
    declare fin int default 0;
    declare cur1 cursor for select j.precio from juego j where j.tipo = tipoJuego;
    declare continue handler for SQLSTATE '02000' set fin=1;

    open cur1;
    fetch cur1 into precio;

    while(fin=0) do
        set precioTotal = precioTotal + precio;
        fetch cur1 into precio;
    end while;

    close cur1;

    return precioTotal;
    end $$

    delimiter ;

select precioTotalPlataforma('plataformas');