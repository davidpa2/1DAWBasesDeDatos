delimiter $$

create procedure historialCiclista (ciclista varchar(9))
begin
    declare fin int default 0;
    declare anno1 int;
    declare anno2 int;
    declare tiempo int;
    declare tiempoAcumulado int;
    declare c1 cursor for select distinct anno from corre where dni = ciclista;
    declare c2 cursor for select anno, tiempo from corre where dni = ciclista;
    declare continue handler for SQLSTATE '02000' set fin = 1;

    open c1;
    fetch c1 into anno1;

    while(fin = 0) do 
        open c2;
        fetch c2 into anno2, tiempo;
        set tiempoAcumulado = 0;

        while (fin = 0) do
            if (anno1 = anno2) then
                set tiempoAcumulado = tiempoAcumulado + tiempo;
            end if;
        fetch c2 into anno2, tiempo;
        end while;

        select...
        set fin = 0;
        close cur2;
        fetch c1 into anno1;
    end while;
    close cur1;
end;

delimiter ;

call historialCiclista();

