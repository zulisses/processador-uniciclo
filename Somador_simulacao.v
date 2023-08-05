module Somador_simulacao;
  reg signed [7:0] Entrada1, Entrada2;
  wire signed [7:0] Resultado;
  reg [3:0] j;
  reg [3:0] i;
  

  initial begin
    $monitor("Time=%0d Entrada1=%b Entrada2=%b Resultado=%b",
      $time, Entrada1, Entrada2, Resultado);
    
  end

  always begin
    for(j = 0; j < 8; j = j + 1) begin 
      for(i = 0; i < 8; i = i + 1) begin 
      #1 Entrada1 <= i;
          Entrada2 <= j;
      end
    end
  end

  Somador Somador1 (Entrada1, Entrada2, Resultado);
  
endmodule