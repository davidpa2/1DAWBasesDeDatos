create or replace function  fibonacci(n in numeric) return numeric as
begin 
    if(n=0) then
        return 0;
    elsif (n=1) then
        return 1;
    else
        return fibonacci(n-1)+fibonacci(n-2);
    end if;
end;