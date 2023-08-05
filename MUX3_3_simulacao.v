module MUX3_3_simulacao;
  reg [2:0] Entrada0, Entrada1, Entrada2;
  reg [1:0] Controle;
  wire [2:0] Resultado;

  initial begin
    $monitor("Time=%0d Entrada0=%b Entrada1=%b Entrada2=%b Controle=%b Resultado=%b",
    $time, Entrada0, Entrada1, Entrada2, Controle, Resultado);
    
  end

  initial begin
    Entrada0 <= 3'b111;
    Entrada1 <= 3'b010;
    Entrada2 <= 3'b000;
    Controle <= 2'b00;
  end

  always begin
    #1 Controle <= 2'b01;
    #1 Controle <= 2'b10;
    #1 Controle <= 2'b00;
  end

  MUX3_3 MUX3_3Canais(Entrada0, Entrada1, Entrada2, Controle, Resultado);

endmodule