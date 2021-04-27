--Sobre la base de datos de autos:
--1.-Alterar la tabla VENTAS para añadirle la matrícula a cada coche (9999-AAA)
--2.-Dar a cada coche una matrícula de forma aleatoria
--3.-Crear una tabla donde se almacenará las matrículas capicúa de los coches vendidos; 

use autos;
alter table ventas add column matricula varchar(9) default '9999 BBB' unique;






delimiter $$

drop function if exists generarMatricula;
create function generarMatricula() returns varchar(10) deterministic
begin 
    declare matricula varchar(10) default "";
    declare i int default 0;
    declare j int default 0;
    declare letra char(1); 

    while (i<4) do
        set matricula = concat(matricula, truncate(rand()*10, 0));
        set i = i + 1;
    end while;

    set matricula = concat(matricula, " ");

    while (j<3) do
        set letra = char(truncate(26*rand(),0)+65);

        while (letra='A' or letra='E' or letra='I' or letra='O' or letra='U') do
            set letra = char(truncate(26*rand(),0)+65);
        end while;

        set matricula = concat(matricula, letra);
        set j = j + 1;
    end while;
    return matricula;
end $$
delimiter ;

select generarMatricula();



delimiter &&

drop table matriculas;
create table matriculas(nuevaMatricula char(9), contador int);
drop procedure if exists miMadre;
create procedure miMadre() deterministic
begin

    declare matriculaMiMae char(9) default "2051 DWF";
    declare matriculaNueva char(9) default "";
    declare i int default 0;

    set matriculaNueva = generarMatricula();

    while (matriculaNueva <> matriculaMiMae) do
        set matriculaNueva = generarMatricula();
        insert into matriculas values (matriculaNueva, i);
        select * from matriculas where contador = i;
        set i = i + 1;
    end while;

end &&

delimiter ;

call miMadre();