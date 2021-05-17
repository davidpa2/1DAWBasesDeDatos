drop table if exists puntos;
create table if not exists puntos (x float, y float);
insert into puntos values(1.2, 5.1), (5.1, 8.3), (2.7, 3.8);
insert into puntos values(0.0, 0.0), (1.0, 1.0);

delimiter $$

drop function if exists sumaDistanciaPuntos;
create function sumaDistanciaPuntos() returns float deterministic
begin
    declare px1 float;
    declare py1 float;
    declare px2 float;
    declare py2 float;
    declare sumaDistancias float default 0.0;
    declare fin int default 0;
    declare cur1 cursor for select x, y from puntos;
    declare cur2 cursor for select x, y from puntos;
    declare continue handler for SQLSTATE '02000' set fin=1;

    open cur1;
    fetch next from cur1 into px1, py1;

    while (fin = 0) do      
        open cur2;
        fetch cur2 into px2, py2;

        while (fin = 0) do
            set sumaDistancias = sumaDistancias + distancia(px1,py1,px2,py2);
            fetch cur2 into px2, py2;
        end while;
            
        if (fin=1) then
            set fin = 0;
        end if;

        close cur2;
        fetch next from cur1 into px1, py1;

    end while;
    close cur1;

    return sumaDistancias;
end $$

delimiter ;

select sumaDistanciaPuntos();




--Manera correcta

delimiter $$
drop function if exists calculardistancia;
create function calculardistancia() returns float(5,2)
begin
    declare salida float(5,2) default 0;
    declare px1 float(5,2);
    declare py1 float(5,2);
    declare px2 float(5,2);
    declare py2 float(5,2);
    declare fin int default 0;
    declare cur1 cursor for SELECT x,y from puntos;
    declare CONTINUE HANDLER FOR SQLSTATE '02000' SET fin = 1;
    
    open cur1;
    fetch cur1 into px1, py1;
    fetch cur1 into px2, py2;
   
    while (fin=0) do

        set salida=salida+distancia(px1, py1, px2, py2);
        set px1=px2;
        set py1=py2;

        fetch cur1 into px2, py2;
        end while;

    close cur1;
    return salida;
end$$
delimiter ;