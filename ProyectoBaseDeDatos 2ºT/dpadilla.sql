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

/*CONSULTAS*/

/* 1.-Una selección simple sobre una tabla con una condición compuesta(usar and, or):
    ¿Qué juegos de acción valen menos de 25€?*/
    select titulo, precio, tipo from juego where tipo = 'acción' and precio < 25;

/* 2.-Una selección simple que muestre un campo calculado con condición compuesta:
    ¿Qué cantidad de ejemplares han comprado los socios con numSocio entre 1 y 4 de cada juego?*/
    select titulo, count(*) cantJuegos from compra where numSocio > 0 and numSocio < 5 group by titulo;

/* 3.-Sobre la selección anterior hacer una condición sobre el campo calculado:
    ¿De qué juegos se han comprado 2 ejemplares los socios con numSocio entre 1 y 4?*/
    select titulo, count(*) cantJuegos from compra where numSocio > 0 and numSocio < 5 group by titulo having cantJuegos = 2;

/* 4.-Una selección compuesta de dos tablas con condición compuesta:
    ¿Qué juegos de tipo "accion" tienen ejemplares en estado "bueno"?*/
    select distinct j.titulo, j.tipo, e.estado from juego j join ejemplar e using (titulo) where j.tipo = 'accion' and e.estado = 'bueno';

/* 5.-Una selección compuesta con tres tablas que requiera agrupamiento , con campo calculado.
    ¿Qué tipo de juegos y cuántas veces ha comprado Paco?*/
    select count(*) vecesComprado, s.nombre, j.tipo from juego j, compra c, socio s where j.titulo = c.titulo and s.numSocio = c.numSocio and s.nombre = 'Paco' group by j.tipo;

/* 6.-Sobre la misma anterior, realizar una condición sobre el campo calculado.
    ¿Qué tipo de juegos ha comprado Paco más de una vez?*/
    select count(*) vecesComprado, s.nombre, j.tipo from juego j, compra c, socio s where j.titulo = c.titulo and s.numSocio = c.numSocio and s.nombre = 'Paco' group by j.tipo having vecesComprado > 1;

/* 7.-Realizar una consulta que compare datos del mismo atributo(por ejemplo “trabajadores que ganen más que Pérez”, habría que comparar el sueldo de Pérez con los demás trabajadores).
    ¿Quiénes han comprado más veces que Jorge?*/
    select count(*) vecesComprado2, s.nombre from juego j, compra c, socio s where j.titulo = c.titulo and s.numSocio = c.numSocio group by c.numSocio having vecesComprado2 > (select count(*) vecesComprado from juego j, compra c, socio s where j.titulo = c.titulo and s.numSocio = c.numSocio and s.nombre = 'Jorge');

/* 8.-Consulta que contemple tres tablas optimizada con join(sin arrastrar datos innecesarios).
    ¿En qué fecha se lanzó la consola para la cual está desarrollado el juego "GodOfWar"?*/
    select c.fechaPres from consola c join desarrollado d using(nombre) where d.titulo in (select j.titulo from juego j join desarrollado using(titulo) where j.titulo = 'GodOfWar');

/* 9.-Consulta con clausula left join o right join sobre una relación N:M(posible uso de unión).
    ¿De qué juego no se ha vendido todavía ningún ejemplar?*/
    select * from juego j left join compra c using(titulo) where ejemplaresVendidos = 0;

/* 10.-Actualización multitabla con condición.
    Rebajar el precio en un 30% los juegos que tengan un ejemplar en estado "malo"*/
    set @@autocommit = 0;
	start transaction;
    
    update ejemplar e, juego j set j.precio = j.precio * 0.70 where e.estado = 'malo';

    rollback;
    
/* 11.-Borrado multitabla con condición.
    Eliminar los juegos desarrollados en "PlayStation4" cuya edad recomendada sea 12 años*/
    set @@autocommit = 0;
	start transaction;
    
    delete d from juego j, desarrollado d where j.titulo = d.titulo and j.edadRec = 12 and d.nombre = 'PlayStation4';
    
    rollback;