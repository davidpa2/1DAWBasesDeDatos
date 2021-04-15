delimiter $$
drop function if exists pasarHex;
create function pasarHex(n int) returns char(1) deterministic
begin
    declare c char(1);
    
    case n
        when  0 then
            set c = '0';
        when  1 then
            set c = '1';
        when  2 then
            set c = '2';
        when  3 then
            set c = '3';
        when  4 then
            set c = '4';
        when  5 then
            set c = '5';
        when  6 then
            set c = '6';
        when  7 then
            set c = '7';
        when  8 then
            set c = '8';
        when  9 then
            set c = '9';
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