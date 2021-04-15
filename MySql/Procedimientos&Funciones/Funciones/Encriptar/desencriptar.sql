create function desencriptar(a char(1))
returns char(1) deterministic
return char(ascii(a)-3);