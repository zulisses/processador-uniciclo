module Somador (Entrada1, Entrada2, Resultado);

  input signed [7:0] Entrada1, Entrada2;
  output signed [7:0] Resultado;

  assign Resultado = Entrada1 + Entrada2;

endmodule
