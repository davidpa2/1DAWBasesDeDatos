delimiter $$

drop procedure if exists tirarDados;
create procedure tirarDados(inout d1 int, inout d2 int) deterministic
begin
    create table if not exists dados (dado1 int, dado2 int);
    set d1 = truncate((rand()*6)+1,0);
    set d2 = truncate((rand()*6)+1,0);
    insert into dados values (d1,d2);
end $$

delimiter ;

call tirarDados(@dado1, @dado2);
select * from dados;