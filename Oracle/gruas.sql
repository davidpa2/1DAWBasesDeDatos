añadir un nuevo tipo llamado coche con todas sus propiedades 
hay que declarar el constructor y las funciones que vayan a hacer falta

CREATE OR REPLACE TYPE COCHE AS OBJECT 
( matricula varchar2(9),
peso numeric,
coordenadaX numeric,
coordenadaY numeric,
averiado int,
constructor FUNCTION coche(matricula varchar2, peso numeric) 
return self as result,
member PROCEDURE averiar
)


crear el cuerpo en la clase, esto es escribir el código del constructor y las funciones

CREATE OR REPLACE
TYPE BODY COCHE AS

constructor FUNCTION coche(matricula varchar2, peso numeric) 
return self as result AS
  BEGIN
    self.matricula:=matricula;
    self.peso:=peso;
    self.coordenadaX:=0;
    self.coordenadaY:=0;
    self.averiado:=0;
    RETURN ;
  END coche;
  
member PROCEDURE averiar as
    begin
        self.averiado:=1;
    end averiar;
END;


para comprobar que funciona, desde la conexión se puede crear un objeto y mostrarlo

declare
c coche;
begin
c:= new coche('4444 hhh',800);
DBMS_output.put_line(c.matricula);
DBMS_output.put_line(c.averiado);
c.averiar;
DBMS_output.put_line(c.averiado);
end;


Ahora hacer el objeto grúa

CREATE OR REPLACE TYPE GRUA AS OBJECT 
( matricula varchar2(9),
pesoMax numeric,
coordenadaX numeric,
coordenadaY numeric,
distanciaMax numeric,
constructor FUNCTION grua(matricula varchar2, pesoMax numeric, distanciaMax numeric) 
return self as result,
member PROCEDURE recogerCoche(cocheAveriado in out coche)
)


y su cuerpo:

CREATE OR REPLACE
TYPE BODY GRUA AS

  constructor FUNCTION grua(matricula varchar2, pesoMax numeric, distanciaMax numeric) 
return self as result AS
  BEGIN
    self.matricula:=matricula;
    self.pesoMax:=pesoMax;
    self.coordenadaX:=1;
    self.coordenadaY:=1;
    self.distanciaMax:=10;
    RETURN ;
  END grua;

  member PROCEDURE recogerCoche(cocheAveriado in out coche) AS
  BEGIN
    if (cocheAveriado.peso < self.pesoMax and cocheAveriado.averiado = 1 and distancia(self.coordenadaX,
    self.coordenadaY, cocheAveriado.coordenadaX, cocheAveriado.coordenadaY) < self.distanciaMax)then
        cocheAveriado.averiado:=0;
    end if;
  END recogerCoche;

END;


Comprobar que una grúa recoge al coche

set serveroutput on;
declare
g grua;
begin
g:= new grua('3333 grs',750,2);
DBMS_output.put_line(g.matricula);
DBMS_output.put_line(g.distanciaMax);
g.recogerCoche(c);
DBMS_output.put_line(c.averiado);
end;



CREATE table recogidas (id numeric primary key, grua grua, coche coche, distancia numeric);


hay que modificar el procedimiento para que al recoger un coche se inserte el registro

create or replace TYPE BODY GRUA AS

  constructor FUNCTION grua(matricula varchar2, pesoMax numeric, distanciaMax numeric) 
return self as result AS
  BEGIN
    self.matricula:=matricula;
    self.pesoMax:=pesoMax;
    self.coordenadaX:=1;
    self.coordenadaY:=1;
    self.distanciaMax:=distanciaMax;
    RETURN ;
  END grua;

  member PROCEDURE recogerCoche(cocheAveriado in out coche) AS
  dist numeric;
  BEGIN
  dist:= distancia(self.coordenadaX, self.coordenadaY, cocheAveriado.coordenadaX, cocheAveriado.coordenadaY);
    
    if (cocheAveriado.peso < self.pesoMax and cocheAveriado.averiado = 1 and dist < self.distanciaMax)then
        cocheAveriado.averiado:=0;
        
        insert into recogidas values(SECUENCIAGRUA.nextval, self, cocheAveriado,dist);
    else
        DBMS_OUTPUT.PUT_LINE('No se ha podido recoger al coche');
    end if;
  END recogerCoche;

END;


COMPROBAR 
declare
c1 coche;
g1 grua;
begin
c1:= new coche('4444 dfs', 500);
g1:= new grua('3333 grs',1000, 20);
DBMS_output.put_line(c1.matricula);
DBMS_output.put_line(c1.peso);
DBMS_output.put_line(g1.matricula);
DBMS_output.put_line(g1.distanciaMax);

DBMS_output.put_line(c1.averiado);
c1.averiar;
DBMS_output.put_line(c1.averiado);

g1.recogerCoche(c1);
DBMS_output.put_line(c1.averiado);
end;

select * from recogidas;