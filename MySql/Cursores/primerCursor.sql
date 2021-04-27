delimiter $$
drop function if exists puntosPiloto;
create function puntosPiloto (n int) returns int deterministic
begin	
	declare piloto int;
	declare posFin int;
	declare salida int default 0;
	declare i int default 0;

	declare cur1 cursor for select dorsal, pos_fin from formula2.participa where dorsal=n;
	declare continue handler for sqlstate '02000' set i = 1;

	open cur1;
	fetch cur1 into piloto, posFin;

	while (i=0) do
		if (posFin = 1) then
			set salida = salida + 20;
		elseif (posFin = 2) then
			set salida = salida + 15;
		elseif (posFin = 3) then
			set salida = salida + 10;
		elseif (posFin = 4) then
			set salida = salida + 5;
		elseif (posFin = 5) then
			set salida = salida + 1;
		end if;

		fetch cur1 into piloto, posFin;
	end while;

	close cur1;
return salida;
end $$

delimiter ;