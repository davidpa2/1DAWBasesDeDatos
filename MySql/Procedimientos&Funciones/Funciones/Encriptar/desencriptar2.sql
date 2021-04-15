create function desencriptar2(a char(1), desplazamiento int)
returns char(1) deterministic
return char(ascii(a)-desplazamiento);