delimiter $$
create function pasarhex( n int) returns char(1)
begin
declare c char(1);
case n
when 10 then set c='A';
when 11 then set c='B';
when 12 then set c='C';
when 13 then set c='D';
when 14 then set c='E';
when 15 then set c='F';
else set c='X';
end case;
return c;
end $$
delimiter;



delimiter $$
create function hexadecimal(n int) returns varchar(30)
begin
declare salida varchar(30) default "";
while (n>=16) do
if(n%16<10) then
set salida=concat(n%16,salida);
else
set salida=concat(pasarhex(n%16),salida);
end if;
set n=truncate(n/16,0);
end while;

if(n%16<10) then
set salida=concat(n,salida);
else
set salida=concat(pasarhex(n),salida);

end if;
set salida=concat(salida,'H');
return salida;
end $$
delimiter ;