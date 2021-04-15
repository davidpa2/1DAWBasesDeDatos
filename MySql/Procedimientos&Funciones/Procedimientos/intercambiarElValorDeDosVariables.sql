delimiter $$
create procedure intercambiar (inout x int, inout y int)
begin
    declare aux int;
    set aux = x;
    set x = y;
    set y = aux;
end $$
delimiter ;


set @v1 = 5;
set @v2 = 8;

call intercambiar(@v1, @v2);