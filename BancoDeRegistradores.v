module BancoDeRegistradores (RegLido1, RegLido2, RegEscr, DadoEscr, Dado1, Dado2, RegWrite, Clock);

  input [2:0] RegLido1, RegLido2, RegEscr;
  input [7:0] DadoEscr;
  input RegWrite, Clock;
  output reg [7:0] Dado1, Dado2;
  
  reg [7:0] BR [7:0];
  
  always @(posedge Clock) begin
    if(RegWrite) begin 
      BR[RegEscr] = DadoEscr;
      //$display("%b de: %b",RegEscr, DadoEscr);
    end
  end
  
  always @(*) begin
    Dado1 = BR[RegLido1];
    Dado2 = BR[RegLido2];
  end

endmodule