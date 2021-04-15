delimiter $$
create procedure guardarPrimos (a int, b int) deterministic
begin
    drop table if exists primos;
    create table if not exists primos(primos int);

    if (a>b) then 
        call intercambiar(a,b);
    end if;

    while (a<=b) do
        if (primo(a)=1) then
            insert into primos values (a);
        end if;
        set a = a + 1;
    end while;    
end $$

delimiter ;