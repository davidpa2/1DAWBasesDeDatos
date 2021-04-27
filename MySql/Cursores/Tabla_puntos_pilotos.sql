drop procedure puntospilotoPT;
drop table tabpuntos;
create table tabpuntos(piloto varchar(30), puntos int);

delimiter $$

create procedure puntospilotoPT() deterministic
begin
  declare d int;
  declare p varchar(30);
  declare pf int;
  declare puntosTotal int default 0;
  declare fin int default 0;

  declare cur1 cursor for select dorsal from piloto;
  declare cur2 cursor for select pil.nombre, pos_fin from participa p join piloto pil using(dorsal) where p.dorsal=d;
  declare continue handler for SQLSTATE '02000' set fin=1;

  open cur1;
  fetch cur1 into d;
  while (fin=0) do
    open cur2;
    fetch cur2 into p,pf;
      while(fin=0) do
        if(pf=1) then 
          set puntosTotal = puntosTotal + 25;
        elseif(pf=2) then
          set puntosTotal = puntosTotal + 20;
        elseif(pf=3) then
          set puntosTotal = puntosTotal +15;
        elseif(pf=4) then
          set puntosTotal = puntosTotal +10;
        elseif(pf=5) then
          set puntosTotal = puntosTotal +5;
        end if;
        fetch cur2 into p,pf;
      end while;
    insert into tabpuntos values(p,puntosTotal);
    if (fin=1) then
      set fin = 0;
    end if;
    close cur2;
    fetch cur1 into d;
    set puntosTotal = 0;
  end while;
  close cur1; 
end $$

delimiter ;

call puntospilotoPT();
select * from tabpuntos;