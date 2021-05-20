-Crear usuario:
	create user 'usuario'@'%' identified by '1234';
-Dar privilegios:
	grant all privileges on *.* to 'usuario'@'%';
	flush privileges;
-Entrar con la cuenta:
	mysql -u usuario -p
-Crear base de datos:
	create database <nombre>;
-Mostrar todas las bases de datos:
	show databases;


Para entrar en el entorno gráfico desde el navegador usar (ifconfig -a) para sacar la IP. De manera que escribimos la IP en el navegador
	(IP)/phpmyadmin


-Para apagar la máquina:
	sudo poweroff

-Conectarse desde Linux a la máquina virtual:
	Desde la terminal de Linux poner el comando: ssh usuario@(IP)

-Liberar la IP que tenga asignada y asignar otra:
	sudo dhclient -r -v
	sudo dhclient

----------------------------------------------------------------------------------------------------------------------
sudo dhclient -r -v --> quita ip
sudo dhclient --> añade ip
sudo apt-get purge --> desistala
sudo apt-get autoclean


show databases; -->ver bases de datos
create databases ___; --> crear base de datos
use nombreBaseDatos; --> usar la base de datos
create table nombreTabla(at1 int (auto_increment)* primary key, at2 varchar(30), at3 int); --> una clave
create table nombreTabla(nºPlanta int(3), numero int(3), nombreAula varchar(10), primary key(nºPlanta, numero)); --> diferentes claves
create table nombreTabla(nºPlanta int(3), numero int(3), nombreAula varchar(10), primary key(nºPlanta, numero), index indice (nombre)); --> diferentes claves con indice 
show tables; --> ver tablas creadas
describe nombreTabla; --> ver diseño de la tabla
drop table; --> eliminar tablas

ctrl + insert -->copiar
mayuscula(shift) + insert -->pegar

-Crear un usuario y darle determinados permisos:
	create use 'pepe'@'%' identified by '1234';
	flush privileges;
	grant select, insert on empleados.* to 'pepe'@'%';

------------------------------------------------------------------------------------------------------------------------------
Constraint (restricciones)
	-Primary key
	-Foreign key
	-Unique

Create table (id, int , dni int unique not null default '___', nombre varchar(20), apellido varchar(20), cp varchar(5), primary key (id), unique (nombre, apellido), index indice(dni), constraint fk1 foreign key (cp) references localidad(cp));
-----------------------------------------------------------------------------------------
Volcar (dump) para guardar un script en un fichero del equipo:
msqldump -u usuario -p santiago > santiago2.sql

Ejecutar un script que tenemos guardado:
source santiago2.sql
--------------------------------------------------------------------------------------
Alter table:
	alter table prueba add column apellido varchar(10);    -(añade en la tabla 'prueba' una columna llamada apellido)
	alter table prueba change apellido direccion varchar(10);   -(cambia de la tabla prueba el campo apellido por el campo direccion)
---------------------------------------------------------------------------------------
-Ver el modelo físico desde PHPMyAdmin:
En el menú principal, en database darle a "reverse engineer" y seleccionar la base de datos para que nos muestre el modelo entidad relación.

-VER EL MODELO FÍSICO EN WORKBENCH
	-Con ifconfig ver la ip que hay asignada y añadir una conexión con esa ip:
	-database -Reverse Engineer -...
---------------------------------------------------------------------------------------

Introducir datos:
	insert [into] table tablaEjemplo (c1,c2,c3) values (c1,c2,c3), (c1,c2,c3);

Mostrar campos o tablas:
select [atributos, expresiones que contengan atributos, funciones] from tabla where condition;

Multiplicar tablas:
	select * from empleados, departamentos where empleados.depNum = departamentos.depNum;
	select * from empleados e join departamentos d on e.depNum=d.depNum;
	select apellido, salario+ifnull(comision,0) as Total, dnombre from empleados join departamentos using(dep_no) where dnombre='ventas';
	select * from empleados join (select apellido, salario from empleados where apellido = 'Martin') T1 where e.salario > T1.salario;

-Like:
	select * from empleados where apellido like '%z';
	select * from empleados where apellido like '_A__';

-Between:
	select * from empleados where salario between  150000 and 250000;

-Order:
	select * from empleados order by salario (asc/desc);

Funciones: 
-Suma: sum
	select sum(salario) from empleados;
	select dep_no, sum(salario) group by dep_no;
(agrupar es hacer que del campo que se diga, aparezcan sólo uno por cada valor que haya, por ejemplo si hay muchos 10, solo aparecerá un 10 y todos sus campos)
-Media: avg
	select avg(salario) from empleados;
-Mínimo: min
-Máximo: max
	select apellido, max(salario) from empleados;
	select max(salario) from empleados;
-Contar: count
	select dep_no departamento, count(*) "num Empleados"

-Concat:
	select concat('hola',' Paco');

-Número aleatorio: rand()

-Using: El using se utiliza para al multiplicar dos tablas y que te aparezcan sólo los campos que nos interesan.
	select dep_no, sum(salario), dnombre from empleados e join departamentos d using(dep_no) group by dep_no;

-Having: Se usa para poner una condición a posteriori, por ejemplo, si hacemos un campo calculado, para ponerle una condición habría que poner el having al final.
	select oficio, max(salario) from empleados where oficio != 'presidente' group by salario having max(salario) >=200000;

-Limit: de esta manera se puede sacar el valor máximo de un agrupamiento: al poner que se ordene de manera descendente y limitado a 1, saldrá sólo la primera, que será el máximo:
	select count(*) from empleados group by dep_no order by count(*) desc limit 1;

-Update: Para actualizar los valores de un campo. Al poner where pondremos una condicion para actualizar todos los valores que reunan la condicion.
	update tabla set campo = valor, campo = valor where campo='      ';
	update clientes set ciudad='Barcelona' where ciudad='Valencia';
	update ventas v, cliente c set color='negro' where v.dni=c.dni and nombre='Luis' and apellido='garcia';
	-Actualización multitabla:
		update coches c, marco m, marcas ma set co.precio = co.precio * 0.9 where c.codcoche = m.codcoche and m.cifm = ma.cifm and m.cifc and ma.nombe = 'seat';
	-Al poner autocommit a 0 hacemos que al actualizar una tabla, se pueda volver a tener entes de actualizarla.
		set @@autocommit = 0;
		start transaction;
		rollback;   -Devuelve todos los cambios.

-Delete:
	delete from tabla where condicion;
	delete from coches where nombre='ZX';

-Vistas:
	create view emp30 as select * from emp where deptno = 30;
	drop view emp30;

-Left join: además de la multiplicación, te saca los campos que no tengan dada que ver entre la multiplicación de la tabla de la izquierda.
	select * from CLIENTES left join VENTAS using(dni);

-Triggers: mostrar triggers: show triggers \g;

if (condicion) then
	----------------;
	----------------;
else 
	---------------;
	---------------;
end if;


while ( ) do

end while;


delimiter $$
create trigger nombre 'after insert' on nombreTabla
	for each row begin
		update.........................;
		--------------------;
	end $$
delimiter ;

-----------------------------------------------------------------------------------------------------
-Procedimientos: no devuelven nada

delimiter $$
create prodecure nombreProcedimiento (arg, tipo, ....)
	begin

	end $$
delimiter ;

delimiter $$
create procedure p1 (x int, y int)
	begin
		declare a int default 0;
		set a =x + y;
		select a resultado;
	end $$
delimiter;

call p1();


-Funciones: deben de devolver un tipo

delimiter $$
create function suma (x int, y int) 
returns int
	begin
		declare a int default 0;
		set a =x + y;
		return a;
	end $$
delimiter ;

select suma();

-Declarar una variable temporal: Desaparecerán una vez se salga de SQL
set @var1 = suma(7,5)  -Se le puede asignar una llamada a un procedimiento.

-Mostrar todos los procedimientos creados:
	show function status\g
-Mostrar las características de una funcion:
	show create procedure intercambiar\g


-Funciones predefinidas:
	ascii('a');    //Devuelve el valor numérico del número ascii
	char(97);	  //Devuelve la letra o carácter que equivale a ese número en ascii
	select substring('En un lugar de la Mancha',7,5); //Devuelve la cadena de caracteres a partir del séptimo, cinco más. Si el primer valor es negativo empieza a contar desde la derecha
	select substring_index('En un lugar de la Mancha',' ', 2); //Busca el segundo espacio en blanco de la cadena, devuelve todo el pedazo hasta que esté el segundo espacio en blanco
						        //Se puede buscar una palabra, una letra o un número
	length('asdf') //Devuelve la longitud de la cadena que se diga
	select date_format(now(),"%y"); //Devuelve el valor de la fecha según lo que se le diga: 'y' es las dos ultimas cifras del año, 'Y' las dos últimas...


-Handers: Es un manejador con el que se van a tratar las excepciones en el caso de que ocurra, que haga algo
		Pueden ser de tipo CONTINUE en el que una vez salte la exception siga ejecutándose o de EXIT que se terminará la funcion cuando salte la exception
	delimiter &&
	
	create procedure exception(x int)
	begin
		declare continue handler for sqlstate '23000' set x = x + 1;
		create table if not exists numeros(n int primary key);

		insert into numeros values (x);
	end $$

	delimiter ;

-Cursores: Sirven para poder trabajar con las tuplas de manera independiente

	delimiter $$
	create function puntosPiloto (n int) returns int
	begin	
		declare p int;
		declare posFin int;
		declare salida int default 0;
		declare i int default 0;

		declare cur1 cursor for select posicion, posicionFinal from carrera where condicion;
		declare continue handler for sqlstate '02000' set i = 1;

		open cur1;
		fetch cur1 into p, posFin;

		while (i=0) do
			if (posFin = 1) then
				set salida = salida + 20;
			else if (posFin = 2) then
				set salida = salida + 15;
			else if (posFin = 3) then
				set salida = salida + 10;
			end if;

			fetch cur1 into p, posFin;
		end while;

		close cur1;
	return salida;
	end $$

	delimiter ;