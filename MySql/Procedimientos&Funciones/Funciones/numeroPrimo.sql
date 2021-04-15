delimiter $$

create function primo(n int) returns int deterministic
begin
  declare primo int default 1;
  declare cont int default 2;
  if (n < 2 )then
    set primo = 0;
  else
    while (cont <= sqrt(n) and primo = 1) do
        if (n mod cont = 0) then
        set primo = 0;
        end if;
        set cont = cont + 1;
    end while;
  end if;
  return primo;

end $$

delimiter ;