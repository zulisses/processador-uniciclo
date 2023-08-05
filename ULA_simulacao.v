module ULA (Entrada1, Entrada2, Zero, Resultado, ALUOp);

  input signed [7:0] Entrada1, Entrada2;
  input [1:0] ALUOp;
  output reg Zero;
  output reg [7:0] Resultado;

  always @(Entrada1, Entrada2) begin
    case (ALUOp)
      2'b00: Resultado = Entrada1 + Entrada2;
      2'b01: Resultado = ~Entrada1 + 1;
      2'b10: Resultado = Entrada1 - Entrada2;
      2'b11: begin 
        Resultado = Entrada1 - Entrada2;
        Resultado[6:0] = {7{Resultado[7]}};
      end
      default: ;
    endcase

    Zero = |Resultado;
    Zero = ~Zero;
  end

endmodule

module ULA_simulacao;
  reg [7:0] Entrada1, Entrada2;
  reg [1:0] ALUOp;
  reg [2:0] i;
  reg [3:0] j;
  wire Zero;
  wire [7:0] Resultado;

  initial begin
    $monitor("Time=%0d Entrada1=%b Entrada2=%b ALUOp=%b Resultado=%b Zero=%b",
      $time, Entrada1, Entrada2, ALUOp, Resultado, Zero);
    
  end

  always begin
    for(i = 0; i < 4; i = i + 1) begin
      ALUOp = i;
      for(j = 0; j < 8; j = j + 1) begin 
        #1 Entrada1 = j;
           Entrada2 = j;
      end
      for(j = 0; j < 8; j = j + 1) begin 
        #1 Entrada1 = j;
           Entrada2 = 7 - j;
      end
    end
  end

  ULA ULA1 (Entrada1, Entrada2, Zero, Resultado, ALUOp);
  
endmodule