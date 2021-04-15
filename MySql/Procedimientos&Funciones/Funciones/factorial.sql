delimiter $$
create function factorial(n int) returns int deterministic
begin 
    declare salida int default 1;
    while (n>=1) do
        set salida = salida * n;
        set n = n - 1;
    end while;
return salida;
end $$

delimiter ;