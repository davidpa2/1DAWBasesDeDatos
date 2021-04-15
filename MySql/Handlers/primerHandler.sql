set @y = 0;

delimiter $$
	
drop procedure if exists exception;    
create procedure exception(x int)
begin
	declare exit handler for sqlstate '23000' set @y = @y + 1;
	create table if not exists numeros(n int primary key);

	insert into numeros values (x);

    select "Procedimiento terminado" Mensaje;
end $$

delimiter ;

call exception(2);