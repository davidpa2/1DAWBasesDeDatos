delimiter $$

drop function if exists autentificarUsuario;
create function autentificarUsuario (usua varchar(30), pwd varchar(30)) returns boolean deterministic
begin
    declare autentificar boolean default true;
    declare contador int default 0;
    declare encriptada varchar(30) default "";
    
    select count(*) into contador from registroUsuarios where usuario=usua;

    if(contador=1) then
        select contraseña1 into encriptada from registroUsuarios where usuario=usua;

        if(encriptada=encriptarCadena(pwd,2)) then
            set autentificar = true;
        else 
            set autentificar = false;
        end if;

    else 
        set autentificar = false;
    end if;

    return autentificar;
end $$

delimiter ;

select autentificarUsuario();