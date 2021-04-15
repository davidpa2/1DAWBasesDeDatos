--Crear una función que pasado una cadena de  caracteres, la retorne encriptada usando las funciones anteriores. 
--Lo mismo para desencriptar.

delimiter $$
drop function if exists desencriptarCadena;
create function desencriptarCadena(palabra char(30), despl int) returns char(30) deterministic
begin 
    declare i int default 1;
    declare cadena char(30) default "";
    while(i<=length(palabra)) do 
        set cadena = concat(cadena,encriptar2(substring(palabra, i, 1), -despl));
        set i = i + 1;
    end while;
    return cadena;
end $$

delimiter ;