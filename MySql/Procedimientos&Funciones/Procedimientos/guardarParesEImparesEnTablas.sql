delimiter $$
create procedure paresImpares (a int, b int) deterministic
begin
    drop table if exists pares;
    drop table if exists impares;
    create table if not exists pares(x int);
    create table if not exists impares(x int);

    if (a>b) then 
        call intercambiar(a,b);
    end if;

    while (a<=b) do
        if (a%2 = 0) then
            insert into pares values(a);
        else 
            insert into impares values(a);
        end if;
        set a = a+1;
    end while;
end $$

delimiter ;

