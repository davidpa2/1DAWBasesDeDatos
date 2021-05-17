CREATE OR REPLACE TYPE USUARIOCASINO AS OBJECT 
( nombreUsuario varchar2(40),
credito numeric,
constructor function usuariocasino(nombre varchar2)
return self as result,
member procedure incrementarSaldo,
member procedure decrementarSaldo
)


CREATE OR REPLACE
TYPE BODY USUARIOCASINO AS

  constructor function usuariocasino(nombre varchar2)
return self as result AS
  BEGIN
    self.nombreUsuario:=nombre;
    self.credito:=100;
    RETURN ;
  END usuariocasino;
  
  member PROCEDURE incrementarSaldo as
    begin
        self.credito:=self.credito+25;
    end incrementarSaldo;
  
  member PROCEDURE decrementarSaldo as
    begin
        self.credito:=self.credito-25;
    end decrementarSaldo;
    
end; 


create or replace TYPE CASINO AS OBJECT 
( nombreCasino VARCHAR2(40),
credito NUMERIC,
constructor FUNCTION casino(nombre VARCHAR2)
return self as result,
member procedure ruleta,
member procedure parImpar
)






declare
j jugador:= new jugador('Pepe');
c casino:= new casino('Las vecas');
begin
c.ruleta.(J,10,7);
DBMS_OUTPUT.PUT_LINE(j.nombre || j.credito);
c.ruleta(j,10,7);
DBMS_OUTPUT.PUT_LINE(j.nombre || j.credito);

end;