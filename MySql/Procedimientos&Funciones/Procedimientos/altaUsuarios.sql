delimiter $$

drop procedure if exists altaUsuarios;
drop table if exists registroUsuarios;
create procedure altaUsuarios (usua varchar(30), pwd1 varchar(30), pwd2 varchar(30)) deterministic
begin
    declare numero int;
    create table if not exists registroUsuarios(usuario varchar(30) primary key, contraseña1 varchar(30), contraseña2 varchar(30));

    select count(*) into numero from registroUsuarios r where r.usuario = usua;

    if (numero = 0) then
        if (pwd1 = pwd2) then
            set pwd1 = encriptarCadena(pwd1,2);
            set pwd2 = encriptarCadena(pwd2,2);

            insert into registroUsuarios values(usua, pwd1, pwd2);
        else
            select "Contraseñas distintas" Error;
        end if;
    else
        select "Usuario ya existe" Error;
    end if;
end $$

delimiter ;