module MUX3_3 (Entrada0, Entrada1, Entrada2, Controle, Resultado);

  input [2:0] Entrada0, Entrada1, Entrada2;
  input [1:0] Controle;
  output [2:0] Resultado;

  assign Resultado = (Controle == 2'b00) ? Entrada0 :
                     (Controle == 2'b01) ? Entrada1 :
                      Entrada2;

endmodule