module AND_simulacao;
  reg Entrada1, Entrada2;
  wire Resultado;

  initial begin
    $monitor("Time=%0d Entrada1=%b Entrada2=%b Resultado=%b",
      $time, Entrada1, Entrada2, Resultado);
    
  end

  initial begin
       Entrada1 <= 0; Entrada2 <= 0;
    #1 Entrada1 <= 0; Entrada2 <= 1;
    #1 Entrada1 <= 1; Entrada2 <= 0;
    #1 Entrada1 <= 1; Entrada2 <= 1;
  end

  AND AND1 (Entrada1, Entrada2, Resultado);

endmodule