create or replace TYPE USUARIOCASINO AS OBJECT 
( nombreUsuario varchar2(40),
credito number,
constructor function usuariocasino(nombre varchar2)
return self as result,
member procedure incrementarSaldo(apostado number),
member procedure decrementarSaldo(apostado number)
)


create or replace TYPE BODY USUARIOCASINO AS

  constructor function usuariocasino(nombre varchar2)
return self as result AS
  BEGIN
    self.nombreUsuario:=nombre;
    self.credito:=100;
    RETURN ;
  END usuariocasino;
  
  member PROCEDURE incrementarSaldo(apostado number) as
    begin
        self.credito:=self.credito+apostado;
    end incrementarSaldo;
  
  member PROCEDURE decrementarSaldo(apostado number) as
    begin
        self.credito:=self.credito-apostado;
    end decrementarSaldo;
    
end;


create or replace TYPE CASINO AS OBJECT 
( nombreCasino VARCHAR2(40),
credito NUMBER,
constructor FUNCTION casino(nombre VARCHAR2)
return self as result,
member procedure ruleta(usuario in out USUARIOCASINO, creditoApostado number, eleccion number),
member procedure parImpar(usuario in out USUARIOCASINO, creditoApostado number, eleccion number)
)


create or replace TYPE BODY CASINO AS

  constructor FUNCTION casino(nombre VARCHAR2)
return self as result AS
  BEGIN
    self.nombreCasino:=nombre;
    self.credito:=1000;
    RETURN ;
  END casino;
  
  member PROCEDURE ruleta(usuario IN OUT USUARIOCASINO, apostado number, elec number)  as
   numAleatorio NUMBER:=DBMS_RANDOM.value(0,36);
    begin
        iF(apostado < usuario.credito) THEN
            dbms_output.put_line('Error al apostar');

        ELSIF(MOD(elec,37) = numAleatorio) THEN
           dbms_output.put_line('El número es ' || numAleatorio);
           usuario.incrementarSaldo(apostado);
            SELF.credito:=self.credito-apostado;
         ELSE
             usuario.decrementarSaldo(apostado);
           SELF.credito:=self.credito+apostado;
        END IF;
    end ruleta;
    
  member PROCEDURE parImpar(usuario IN OUT USUARIOCASINO, apostado number,elec number) as
  numAleatorio NUMBER:=DBMS_RANDOM.value(0,37);
    begin
        IF(apostado < usuario.credito) THEN
             dbms_output.put_line('No tienes crédito');
        ELSE
            IF(MOD(elec,2) = mod(numAleatorio,2)) THEN
                 usuario.incrementarSaldo(apostado);
                 SELF.credito:=self.credito-apostado;
                 update casinos set credito = credito - apostado where nombreCasino = self.nombreCasino;
            ELSE
                usuario.decrementarSaldo(apostado);
                SELF.credito:=self.credito+apostado;
            END IF;
        END IF;
    end parImpar;
END;



set serveroutput on;
DECLARE
c1 casino:= new casino('Las Vegas');
u usuariocasino:= new usuariocasino('Paco');
begin
DBMS_OUTPUT.PUT_LINE(u.credito);
u.ruleta(u,20,7);
DBMS_OUTPUT.PUT_LINE(u.credito);
END;


create table jugadores of usuariocasino;
create table casinos of casino; 


insert into jugadores values (new jugador('Pepe'));
insert into casinos values (new casino('Golden Bars'));