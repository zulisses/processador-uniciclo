module MemoriaDados (Endereco, DadoEscr, DadoLido, MenWrite, MenRead, Clock);

  input [7:0] Endereco, DadoEscr;
  input Clock, MenWrite, MenRead;
  output reg [7:0] DadoLido;

  reg [7:0] Dados [0:255];

  always @(posedge Clock) begin
    if(MenWrite)
      Dados[Endereco] = DadoEscr;
  end

  always @(*) begin
    if(MenRead)
      DadoLido = Dados[Endereco];
  end

endmodule
