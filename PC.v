module PC (PCIn, PCOut, PCWrite, Clock);

  input [7:0] PCIn;
  output reg [7:0] PCOut;
  input PCWrite, Clock;

  reg [7:0] PC;

  always @(posedge Clock) begin
    if(PCWrite)
      PC = PCIn;
  end

  always @(negedge Clock) begin
    PCOut = PC;
  end

endmodule
