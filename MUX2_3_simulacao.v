module MUX2_3_simulacao;
  reg [3:0] Entrada0, Entrada1;
  reg Controle;
  wire [3:0] Resultado;

  initial begin
    $monitor("Time=%0d Entrada0=%b Entrada1=%b Controle=%b Resultado=%b",
    $time, Entrada0, Entrada1, Controle, Resultado);
    
  end

  initial begin
    Entrada0 <= 3'b111;
    Entrada1 <= 3'b000;
    Controle <= 0;
  end

  always begin
    #1 Controle <= 1;
    #1 Controle <= 0;
  end

  MUX2_3 MUX2_3Canais(Entrada0, Entrada1, Controle, Resultado);

endmodule