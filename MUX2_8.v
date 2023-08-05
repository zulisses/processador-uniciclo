module MUX2_8 (Entrada0, Entrada1, Controle, Resultado);

  input [7:0] Entrada0, Entrada1;
  input Controle;
  output [7:0] Resultado;

  assign Resultado = Controle ? Entrada1 : Entrada0;

endmodule