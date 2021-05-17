create or replace function factorial(a numeric) return numeric as salida numeric;
begin
    if (a=0) then
        return 1;
    else
        return a * factorial(a-1);
    end if;
end factorial;