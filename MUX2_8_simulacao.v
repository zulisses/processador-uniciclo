module MUX2_8_simulacao;
  reg [7:0] Entrada0, Entrada1;
  reg Controle;
  wire [7:0] Resultado;

  initial begin
    $monitor("Time=%0d Entrada0=%b Entrada1=%b Controle=%b Resultado=%b",
    $time, Entrada0, Entrada1, Controle, Resultado);
    
  end

  initial begin
    Entrada0 <= 8'b11111111;
    Entrada1 <= 8'b00000000;
    Controle <= 0;
  end

  always begin
    #1 Controle <= 1;
    #1 Controle <= 0;
  end

  MUX2_8 MUX2_8Canais(Entrada0, Entrada1, Controle, Resultado);

endmodule