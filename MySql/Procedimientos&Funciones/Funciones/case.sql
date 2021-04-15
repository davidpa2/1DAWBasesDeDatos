delimiter $$
create function ejemploCase(n int) returns char(1) deterministic
begin
    declare c char(1);
    
    case n
        when  10 then
            set c = 'A';
        when  11 then
            set c = 'B';
        when  12 then
            set c = 'C';
        when  13 then
            set c = 'D';
        when  14 then
            set c = 'E';
        when  15 then
            set c = 'F';
        else set c ='X';
    end case;
    return c;
end $$

delimiter ;