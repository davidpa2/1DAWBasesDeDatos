--EJERCICIO 1:

/*A.- */

alter table sponsor add column puntos int;

create trigger ai_participa after insert on participa
    for each row begin
    select count(new.pos_fin) from participa group by 

/*B.- */
select cod_sponsor, sum(cantidad) cantidad from sponsoriza group by cod_sponsor;

/*C.-*/ 
select distinct p.nombre from piloto p, sponsoriza sp2 where p.dorsal = sp2.num_piloto and sp2.num_piloto not in (select sp.num_piloto from sponsoriza sp, sponsor s where sp.cod_sponsor = s.id and s.nombre = 'Movistar');

/*D.- */
select distinct pl.nombre, p.dorsal from participa p join piloto pl using(dorsal) where p.dorsal not in (select dorsal from participa where pos_fin = 1);

/*E.- */
update sponsoriza sp, sponsor s set sp.cantidad = cantidad * 0.50 where sp.cod_sponsor = s.id and s.nombre = 'Movistar';

/*F.- */
delete from participa pa where pa.dorsal = (select p.dorsal from piloto p, escuderia e where p.dorsal = e.codigo and e.nombre = 'Mercedes');


--EJERCICIO 2:

/*A.-*/
drop database if exists provincias;
create database if not exists provincias;
use provincias;

create table provincia (
    id_provincia int(4) primary key,
    nombre varchar(20),
    poblacion varchar(20),
    n_poblaciones int(2),
    capital varchar(20)
);

create table localidad (
    id_localidad int(4) primary key,
    nombre varchar(20),
    poblacion varchar(20),
    superficie float(6,2),
    id_provincia int(4),
    constraint fk1 foreign key (id_provincia) references provincia(id_provincia)
    on update cascade on delete restrict
);

insert into provincia values(1,'Cordoba','Andalucia',0,'Cordoba'),
                            (2,'Malaga','Andalucia',0,'Malaga'),
                            (3,'Jaen','Andalucia',0,'Jaen');

insert into localidad values(1,'Baena','Cordoba',234.32,1),
                            (2,'Lucena','Cordoba',502.12,1),
                            (3,'Mijas','Malaga',700.12,2),
                            (4,'Marbella','Malaga',500.13,2),
                            (5,'Alcaudete','Jaen',603.13,3),
                            (6,'Valenzuela','Jaen',200.53,3);


/*B.-*/
select p.nombre, sum(l.superficie) superficieTotal from localidad l join provincia p using(id_provincia) group by id_provincia having superficieTotal < 1000;

/*C.-*/
delimiter $$

create trigger ai_localidad after insert on localidad
    for each row begin 
    update provincia set n_poblaciones = n_poblaciones + 1
    where new.id_provincia = provincia.id_provincia;
    end $$

create trigger ad_localidad after delete on localidad
    for each row begin 
    update provincia set n_poblaciones = n_poblaciones - 1
    where old.id_provincia = provincia.id_provincia;
    end $$

create trigger au_localidad after update on localidad
    for each row begin
    update provincia set n_poblaciones = n_poblaciones - 1
    where old.id_provincia = provincia.id_provincia; 
    update provincia set n_poblaciones = n_poblaciones + 1
    where new.id_provincia = provincia.id_provincia;
    end $$

delimiter ;
