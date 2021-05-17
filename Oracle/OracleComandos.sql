Entrar en oracle: sqlplus usuario

-Para mostrar algo por pantalla:
set serveroutput on;

begin
  DBMS_OUTPUT.put_line(cont);



-Crear funciones
create or replace function sumar(a numeric, b numeric) return numeric as salida numeric;
begin
    salida:=a+b;
end ;

select sumar(8,8) from


create or replace procedure(mensaje varchar2) saludo as
salida varchar(20);
begin 
    salida:='Hola ke tal';
    DBMS_OUTPUT.put_line(salida);
end saludo;


-Rutina anónima
set serveroutput on;
declare
numero numeric:=5;
begin
DBMS_OUTPUT.put_line(numero);
end ;
/


-Bucle for
declare
begin
FOR i IN 1..20
LOOP
   DBMS_OUTPUT.put_line(i);
END LOOP;
end;

-if:
declare
n numeric;
begin
n:=8;
if (mod(n,2)=1) then
DBMS_OUTPUT.put_line('impar');
else
DBMS_OUTPUT.put_line('par');
end if;
end;

-while:
set serveroutput on;

declare
cont numeric;
begin
cont:=1;
while (cont<10) loop
DBMS_OUTPUT.put_line(cont);
cont:=cont+1;
end loop;
end;

-Operadores:
Tipo de operador 	Operadores
Operador de asignación 	:= (dos puntos + igual)
Operadores aritméticos 	+ (suma)
- (resta)
* (multiplicación)
/ (división)
power(b,e)  (exponente)
Operadores relacionales o de comparación 	= (igual a)
<> (distinto de)
< (menor que)
> (mayor que)
>= (mayor o igual a)
<= (menor o igual a)
Operadores lógicos 	AND (y lógico)
NOT (negacion)
OR (o lógico)
Operador de concatenación 	||

-Funciones predefinidas:
select substr('abcdefghijklmnopqrstuvwxyz',7,5) from dual; //Devuelve la cadena de caracteres a partir del séptimo, 
                                        cinco más. Si el primer valor es negativo empieza a contar desde la derecha
select sqrt(4) from dual;
select power(3,2) from dual;

-Objetos:
  Crear un tipo:
  CREATE OR REPLACE TYPE COCHE AS OBJECT 
    ( matricula VARCHAR2(9),
      coordenadaX numeric,
      coordenadaY numeric
    )

  Crear un nuevo objeto a partir de un tipo
    *(como método anónimo):
      declare
      c1 COCHE;
      begin
        c1 :=  new coche('1234 BBB', 2, 3);
        DBMS_OUTPUT.put_line(c1.matricula);
      end ;

    *(como métodos):
      create or replace type Usuario as object (
        login varchar(10),
        nombre varchar(30),
        fIngreso date,
        credito number,
        member procedure incrementoCredito(inc number),
        member procedure decrementoCredito(inc number));

      -Y crear el cuerpo:
        CREATE OR REPLACE
        TYPE BODY USUARIO AS

          member procedure incrementoCredito(inc number) AS
          BEGIN
            self.credito:=self.credito+inc;
          END incrementoCredito;

          member procedure decrementoCredito(inc number) AS
          BEGIN
            self.credito:=self.credito+inc;
          END decrementoCredito;

        END;

      -Crear el objeto con sus propiedades:
        declare
        u1 usuario;
        u2 usuario;
        begin
        u1:= new usuario('usuario','pepe','07/05/21',20);
        u1.incrementoCredito(30);
        DBMS_OUTPUT.put_line(u1.credito);
        DBMS_OUTPUT.put_line(u1.fIngreso);
        end;

      -Crear un nuevo constructor para pasarle los atributos que se quieran ya que el por defecto 
      tiene todos los atributos
        create or replace type Usuario as object (
        login varchar(10),
        nombre varchar(30),
        fIngreso date,
        credito number,
        constructor function Usuario(login varchar2, nombre VARCHAR2)
        return self as result,
        member procedure incrementoCredito(inc number),
        member procedure decrementoCredito(inc number));



set SERVEROUTPUT on;
declare
c1 coche;
c2 coche;
g1 grua;
begin
c1:= new coche('1234 BBB',500);
c2:= new coche('4321 CCC',800);
g1:= new grua('5432 FFF',1000,2);
DBMS_OUTPUT.PUT_LINE('coche2 '|| c2.averiado);
c2.averiar;
DBMS_OUTPUT.PUT_LINE('coche2 '|| c2.averiado || ' en ' || c2.coordenadaX || ',' || c2.coordenadaY);
g1.recogerCoche(c2);
DBMS_OUTPUT.PUT_LINE('coche2 '|| c2.averiado || ' en ' || c2.coordenadaX || ',' || c2.coordenadaY);
end;


-Crear tablas
create table gente (
  dni varchar2(10),
  unUsuario Usuario,
  partidasJugadas smallint
);

Crear una tabla a partir de un objeto:
create table Usuarios OF Usuario;


-Insertar registros
insert into gente values ('12345678G',usuario('AAnuel','Paco'),3);

-Uso de select
select g.dni, g.unUsuario.nombre from gente g;
select g.dni, g.unUsuario.nombre from gente g where g.unUsuario.login = 'AAnuel';

-Update
update gente g set g.unUsuario.credito=200 where g.unUsuario.nombre = 'Paco';

-Uso de secuencias
crear una secuencia
  A la hora de insertar hay que poner:
  insert into tabla values(secuencia.nextval, )