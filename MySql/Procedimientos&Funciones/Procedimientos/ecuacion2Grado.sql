delimiter $$

create table if not exists solucionesEcuacion(a float(6,2), b float(6,2), c float(6,2), s1 float(6,2), s2 float(6,2), primary key(a,b,c));

drop procedure if exists ecuacion2g;
create procedure ecuacion2g (a int, b int, c int) deterministic
begin
    declare s1 float(4,2);
    declare s2 float(4,2);
    declare raiz float(6,2);
    declare denominador float(6,2);
    
    if (a <> 0 and b <> 0 and c <> 0) then
        set raiz = sqrt((b*b) - 4*a*c);
        set denominador = 2 * a;
        set s1 = (-b + raiz) / denominador;
        set s2 = (-b - raiz) / denominador;

        insert into solucionesEcuacion values(a, b, c, s1, s2);

    else if (b = 0) then

        if (c <> 0) then
            if ((c * -1)/a > 0) then
                set s1 = sqrt((c * -1) / a);
                set s2 = sqrt((c * -1) / a);
            end if;
        end if;

    else if (c = 0) then
        



end $$

delimiter ;