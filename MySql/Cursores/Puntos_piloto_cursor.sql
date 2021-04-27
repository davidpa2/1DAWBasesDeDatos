create table if not exists tabpuntos(piloto varchar(30), puntos int);

delimiter $$

drop procedure if exists puntospilotoP;
create procedure puntospilotoP(n int)
begin
  declare p varchar(30);
  declare pf int;
  declare salida int default 0;
  declare fin int default 0;
  declare cur1 cursor for select pl.nombre, pos_fin from participa p join piloto pl using(dorsal) where pl.dorsal=n;
  declare continue handler for SQLSTATE '02000' set fin=1;

  open cur1;
  fetch cur1 into p,pf;

  while(fin=0) do
    if(pf=1) then 
      set salida = salida + 20;
    elseif(pf=2) then
      set salida = salida + 15;
    elseif(pf=3) then
    set salida = salida +10;
    end if;
    fetch cur1 into p,pf;
  end while;

  if (p = null) then
    select "No existe ese piloto" Mensaje;
  else 
    insert into tabpuntos values(p,salida);
  end if;

  close cur1;
end $$

delimiter ;

call puntospilotoP(5);