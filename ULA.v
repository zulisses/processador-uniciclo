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
