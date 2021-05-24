--Ejercicio1 Cursor SQL

drop table if exists control;
create table if not exists control (idAvion varchar(4), nombre varchar(20));

delimiter $$
drop procedure if exists mantenimientoAviones;
create procedure mantenimientoAviones (nombreComp varchar(20)) deterministic
begin
    declare idAvion varchar(2);
    declare nombreAv varchar(20);
    declare destino varchar(20);
    declare nombreDestino varchar(20);
    declare horasVuelo int default 0;
    declare i int default 0;
    declare cur1 cursor for select a.idav, a.nombre, v.codar from avion a join vuelo v using(idav) where a.compania = nombreComp;
    declare cur2 cursor for select d.nombre from vuelo v join destino d using(codar) where v.codar = destino;
    declare continue handler for SQLSTATE '02000' set i=1;

    open cur1;
    fetch cur1 into idAvion, nombreAv, destino;

    while(i=0) do
        open cur2;
        fetch cur2 into nombreDestino;

        while(i=0) do
        if(destino="Nueva York") then 
          set horasVuelo = horasVuelo + 12;
        elseif(destino="Paris") then
          set horasVuelo = horasVuelo + 2;
        elseif(destino="Madrid") then
          set horasVuelo = horasVuelo + 1;
        elseif(destino="Londres") then
            set horasVuelo = horasVuelo + 3;
        end if;
        fetch cur2 into nombreDestino;
        end while;

        set i = 0;

        if (horasVuelo>=15) then
            insert into control values(idAvion, nombreAv);
        end if;

        set horasVuelo = 0;
        
        close cur2;
        fetch cur1 into idAvion, nombreAv, destino;
    end while;
    close cur1;
end $$

delimiter ;

call mantenimientoAviones('Air Lucena');
select * from control;
call mantenimientoAviones('Lucena Flying');



--Ejercicio2 Oracle

--Tipo vehiculo:
CREATE OR REPLACE TYPE VEHICULO AS OBJECT 
( matricula varchar2(8),
litrosDeposito numeric,
creditoUsuario numeric,
constructor FUNCTION vehiculo
return self as result
)

--Cuerpo vehiculo:
CREATE OR REPLACE
TYPE BODY VEHICULO AS

  constructor FUNCTION vehiculo
return self as result AS
  BEGIN
    RETURN ;
  END vehiculo;
END;

--Tipo gasolinera:
CREATE OR REPLACE TYPE GASOLINERA AS OBJECT 
( nombre varchar2(20),
litrosEnTanque numeric,
eurosPorLitro numeric,
constructor FUNCTION gasolinera
return self as result,
member PROCEDURE aniadirTanque(cant numeric),
member PROCEDURE surtirVehiculo(veh in out vehiculo, cant numeric)
)

--cuerpo gasolinera
CREATE OR REPLACE
TYPE BODY GASOLINERA AS

  constructor FUNCTION gasolinera
return self as result AS
  BEGIN
    RETURN ;
  END gasolinera;

  member PROCEDURE aniadirTanque(cant numeric) AS
  BEGIN
    self.litrosEnTanque:=litrosEnTanque+cant;
  END aniadirTanque;

  member PROCEDURE surtirVehiculo(veh in out vehiculo, cant numeric) AS
  importe numeric default 0;
  BEGIN
    importe:= cant * self.eurosPorLitro;
     if (self.litrosEnTanque < cant) then
        dbms_output.put_line('No hay suficiente cantidad en el tanque');
     else
         if (veh.creditoUsuario>importe ) then
            self.litrosEnTanque:=litrosEnTanque-cant;
            veh.litrosDeposito:= veh.litrosDeposito+cant;
            veh.creditoUsuario:= veh.creditoUsuario-importe;
            insert into respostajes values (SECUENCIAVEHICULO.nextval, self.nombre, veh, importe);
        else 
            dbms_output.put_line('El cliente no tiene suficiente credito');
        end if;
    end if;
  END surtirVehiculo;

END;

--Crear las tablas con los tipos e insertar un registro en cada una
create table gasolineras of gasolinera;
create table vehiculos of vehiculo;
insert into gasolineras values (new gasolinera('Repsol', 500, 1));
insert into vehiculos values (new vehiculo('5555 DDD', 0, 100));

--Crear objetos y asignarle los valores de las tablas
set serveroutput on;

declare
v vehiculo;
g gasolinera;
begin
v:= new vehiculo;
select * into v.matricula, v.litrosDeposito, v.creditoUsuario from vehiculos v where v.matricula = '5555 DDD';
DBMS_output.put_line(v.matricula);
DBMS_output.put_line(v.litrosDeposito);
DBMS_output.put_line(v.creditoUsuario);
g:= new gasolinera;
select * into g.nombre, g.litrosEnTanque, g.eurosPorLitro from gasolineras g where g.nombre = 'Repsol';
DBMS_output.put_line(g.nombre);
DBMS_output.put_line(g.litrosEnTanque);
DBMS_output.put_line(g.eurosPorLitro);

--Surtir al vehículo le añadirá litros en el deposito y le quitará credito
g.surtirVehiculo(v,50);
DBMS_output.put_line('El vehiculo ahora tiene:' || v.litrosDeposito || ' litros y su credito es de:' || v.creditoUsuario);
--Si no tiene suficiente credito, no se añadirá nada
g.surtirVehiculo(v,60);
DBMS_output.put_line('El vehiculo ahora tiene:' || v.litrosDeposito || ' litros y su credito es de:' || v.creditoUsuario);

--Añadir combustible a la gasolinera
g.aniadirTanque(500);
DBMS_output.put_line('La gasolinera ahora tiene:' || g.litrosEnTanque || 'litros.');
end;

--Crear la secuencia
 CREATE SEQUENCE  "ANA"."SECUENCIAVEHICULO"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE ;

--Crerar tabla respostajes
create table respostajes (
  id numeric,
  nombreGasolinera varchar2(20),
  coche vehiculo,
  precioGasolina numeric
);

--Insertar en la tabla repostajes (en el cuerpo de gasolinera)
insert into respostajes values (SECUENCIAVEHICULO.nextval, self.nombre, veh, importe);

--Consulta que muestra todos los respostajes de un coche según su matrícula
select * from respostajes r where r.coche.matricula = '5555 DDD';