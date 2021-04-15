--Crear una función que te indique si un cadena de caracteres es un palíndromo o no.--
delimiter $$

drop function if exists palindromo;
create function palindromo(palabra varchar(30)) returns tinyint deterministic
begin
    declare i int default 1;
    declare pri char(1) default "";
    declare ult char(1) default "";
    declare es tinyint default 0;
    
        if (length(palabra) = 1) then
            return 1;
        end if;

    while(i<=length(palabra)) do
        set pri = substring(palabra,i,1);
        set ult = substring(palabra,-i,1);

        if (pri = ult) then
            set es = 1;
        else 
            return 0;
        end if;
        set i = i + 1;
    end while;
    
    return es;
end $$

delimiter ;

select palindromo();