module MUX3_8 (Entrada0, Entrada1, Entrada2, Controle, Resultado);

  input [7:0] Entrada0, Entrada1, Entrada2;
  input [1:0] Controle;
  output [7:0] Resultado;

  assign Resultado = (Controle == 2'b00) ? Entrada0 :
                     (Controle == 2'b01) ? Entrada1 :
                      Entrada2;

endmodule
