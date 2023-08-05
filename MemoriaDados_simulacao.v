module MemoriaDados_simulacao;

  reg [7:0] Endereco, DadoEscr;
  reg Clock, MenWrite, MenRead;
  wire [7:0] DadoLido;

  reg [8:0] i, j;

  initial begin
    Clock <= 0;
    MenWrite <= 1;
    MenRead <= 0;
  end

  initial begin
    $monitor("Time=%0d Endereco=%b DadoEscr=%b DadoLido=%b MenWrite=%b MenRead=%b Clock=%b",
    $time, Endereco, DadoEscr, DadoLido, MenWrite, MenRead, Clock);
    
  end

  always begin
    #1 Clock <= 1;
    #1 Clock <= 0;
  end

  always begin

    for(i = 0; i < 256; i = i + 1) begin
      #2 Endereco <= i;
         DadoEscr <= i;
         MenWrite <= 1;
         MenRead <= 0;
    end
    
    for(j = 0; j < 256; j = j + 1) begin
      #2 Endereco <= j;
         MenWrite <= 0;
         MenRead <= 1;
    end

  end

  MenoriaDados MenoriaDados1 (Endereco, DadoEscr, DadoLido, MenWrite, MenRead, Clock);

endmodule