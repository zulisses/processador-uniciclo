module MUX2_3 (Entrada0, Entrada1, Controle, Resultado);

  input [2:0] Entrada0, Entrada1;
  input Controle;
  output [2:0] Resultado;

  assign Resultado = Controle ? Entrada1 : Entrada0;

endmodule