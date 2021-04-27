drop function if exists distancia;
create function distancia(x1 float(5,2), y1 float(5,2), x2 float(5,2), y2 float(5,2)) returns float(5,2) deterministic
return sqrt( pow(x1-x2, 2) + pow(y1-y2, 2));
