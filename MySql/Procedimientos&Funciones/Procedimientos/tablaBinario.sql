delimiter $$

drop procedure if exists tablaBinario;
create procedure tablaBinario(a int, b int)
begin
    if (a>b) then
        call intercambiar(a,b);
    end if;

    drop table if exists tablaBinario;
    create table tablaBinario(decim int, binario varchar(30));

    while (a<=b) do
        insert into tablaBinario values(a, binario(a));
        set a = a + 1;
    end while;
end $$

delimiter ;