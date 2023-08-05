module MUX3_8_simulacao;
  reg [7:0] Entrada0, Entrada1, Entrada2;
  reg [1:0] Controle;
  wire [7:0] Resultado;

  initial begin
    $monitor("Time=%0d Entrada0=%b Entrada1=%b Entrada2=%b Controle=%b Resultado=%b",
    $time, Entrada0, Entrada1, Entrada2, Controle, Resultado);
    
  end

  initial begin
    Entrada0 <= 8'b11111111;
    Entrada1 <= 8'b01010101;
    Entrada2 <= 8'b00000000;
    Controle <= 2'b00;
  end

  always begin
    #1 Controle <= 2'b01;
    #1 Controle <= 2'b10;
    #1 Controle <= 2'b00;
  end

  MUX3_8 MUX3_8Canais(Entrada0, Entrada1, Entrada2, Controle, Resultado);

endmodule