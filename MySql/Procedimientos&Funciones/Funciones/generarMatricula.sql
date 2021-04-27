delimiter $$

drop function if exists generarMatricula;
create function generarMatricula() returns varchar(10) deterministic
begin 
    declare matricula varchar(10) default "";
    declare i int default 0;
    declare j int default 0;
    declare letra char(1); 

    while (i<4) do
        set matricula = concat(matricula, truncate(rand()*10, 0));
        set i = i + 1;
    end while;

    set matricula = concat(matricula, " ");

    while (j<3) do
        set letra = char(truncate(26*rand(),0)+65);

        while (letra='A' or letra='E' or letra='I' or letra='O' or letra='U') do
            set letra = char(truncate(26*rand(),0)+65);
        end while;

        set matricula = concat(matricula, letra);
        set j = j + 1;
    end while;
    return matricula;
end $$
delimiter ;

select generarMatricula();