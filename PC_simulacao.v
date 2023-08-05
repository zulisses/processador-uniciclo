module PC_simulacao;
  reg [7:0] PCIn, i;
  reg PCWrite, Clock;
  wire [7:0] PCOut;

  initial begin
    Clock <= 1;
    PCIn <= 0;
    PCWrite <= 1;
  end

  initial begin
    $monitor("Time=%0d PCIn=%b PCOut=%b PCWrite=%b Clock=%b",
    $time, PCIn, PCOut, PCWrite, Clock);
    
  end

  always begin
    #1 Clock <= 0;
    #1 Clock <= 1;
  end

  always begin
    #32 PCWrite <= 0;
    #32 PCWrite <= 1;
  end

  always begin

    for (i = 1; i < 256; i = i + 1) begin
      #2 PCIn <= i;
    end

  end

  PC PC1(PCIn, PCOut, PCWrite, Clock);

endmodule