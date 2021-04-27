delimiter $$

drop procedure if exists matriculaCapicua;
create procedure matriculaCapicua()
begin
    declare matricula varchar(9);
    declare fin int default 0;
    declare cur1 cursor for select matricula from VENTAS;
    declare continue handler for sqlstate "02000" set fin = 1;
    create table if not exists capicuas(matricula varchar(9));

    open cur1;
    fetch cur1 into matricula;
    
    while(fin = 0) do
        if (palindromo(substring_index(matricula,' ',1)) = 1) then
            insert into capicuas values (matricula);
        end if;

        fetch cur1 into matricula;
    end while;

    close cur1;
end $$

delimiter ;

call matriculaCapicua();
select * from capicuas;