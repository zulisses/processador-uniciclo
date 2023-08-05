module ExtensorDeSinal_simulacao;
  reg signed [4:0] Entrada;
  wire signed [7:0] Resultado;
  reg [5:0] j;

  initial begin
    $monitor("Time=%0d Entrada=%b Resultado=%b",
      $time, Entrada, Resultado);
    
  end

  always begin
    for(j = 0; j < 32; j = j + 1) begin
    #1 Entrada <= j;
    end
  end

  ExtensorDeSinal ExtensorDeSinal1 (Entrada, Resultado);
  
endmodule