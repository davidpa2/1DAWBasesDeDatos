delimiter $$

drop procedure if exists introducirPuntos;
create procedure introducirPuntos(a float(5,2), b float(5,2)) deterministic
begin

    create table if not exists puntos (x float(5,2), y float(5,2), fecha datetime);
    insert into puntos values (a,b, now());

end $$

delimiter ;

call introducirPuntos(4,4);
select * from puntos;
