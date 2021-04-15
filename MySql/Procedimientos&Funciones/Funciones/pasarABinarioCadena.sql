--Pasar número a binario--
--select concat ('0111','0');--

delimiter $$

drop function if exists binario;
create function binario(n int) returns varchar(30) deterministic
begin 

    declare cadena varchar(30) default "";

    while (n>=2) do
        set cadena = concat(n%2, cadena);
        set n = truncate(n / 2, 0);
    end while;

    set cadena = concat(n, cadena);

    return cadena;
end $$

delimiter ;