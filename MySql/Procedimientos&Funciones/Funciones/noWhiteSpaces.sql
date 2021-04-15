delimiter $$

drop function if exists noWhiteSpaces;
create function noWhiteSpaces (palabra varchar(30)) returns varchar(30) deterministic
begin

    declare cadena varchar(30) default "";
    declare i int default 1;
    
    while (i<=length(palabra)) do
        if(substring(palabra,i,1) != " ") then
            set cadena = concat(cadena,substring(palabra,i,1));
        end if;
        set i = i + 1;
    end while;

    return cadena;
end $$

delimiter ;

select noWhiteSpaces('');