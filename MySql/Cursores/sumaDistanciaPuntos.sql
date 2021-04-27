drop table if exists puntos;
create table if not exists puntos (x float, y float);
insert into puntos values(1.2, 5.1), (5.1, 8.3), (2.7, 3.8);

delimiter $$

drop procedure if exists sumaDistanciaPuntos;
create procedure sumaDistanciaPuntos() deterministic
begin
    declare px1 float;
    declare py1 float;
    declare px2 float;
    declare py2 float;
    declare sumaDistancias float default 0.0;
    declare fin int default 0;
    declare cur1 cursor for select x, y from puntos;
    declare cur2 cursor for select x, y from puntos ;
    declare continue handler for SQLSTATE '02000' set fin=1;

    open cur1;
    fetch cur1 into px1, px2;

    while (fin = 0) do
        set sumaDistancias = sumaDistancias + distancia(p1,p2);