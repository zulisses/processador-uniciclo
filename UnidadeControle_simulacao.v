module UnidadeControle_simulacao;
  reg [1:0] Opcode;
  reg [2:0] Funct;
  wire PCWrite, RegOrg1, RegOrg2, RegDst, RegWrite, ALUSrc1, Cond, Jump, MenWrite, MenRead, MenToReg;
  wire [1:0] ALUSrc2, ALUOp, JumpValue;

  reg [3:0] i;
  reg [4:0] j;

  initial begin
    $monitor("Time=%0d Opcode=%b Funct=%b PCWrite=%b RegOrg1=%b RegOrg2=%b RegDst=%b RegWrite=%b ALUSrc1=%b ALUSrc2=%b ALUOp=%b JumpValue=%b Cond=%b Jump=%b MenWrite=%b MenRead=%b MenToReg=%b",
      $time, Opcode, Funct, PCWrite, RegOrg1, RegOrg2, RegDst, RegWrite, ALUSrc1, ALUSrc2, ALUOp, JumpValue, Cond, Jump, MenWrite, MenRead, MenToReg);
    
  end

  always begin
    for(i = 0; i < 4; i = i + 1) begin
        Opcode = i;
        for(j = 0; j < 8; j = j + 1) begin
            Funct = j;
            #1 ;
        end
    end
  end

  UnidadeControle UnidadeControle1 (Opcode, Funct, PCWrite, RegOrg1, RegOrg2, RegDst, RegWrite, ALUSrc1, ALUSrc2, ALUOp, JumpValue, Cond, Jump, MenWrite, MenRead, MenToReg);
  
endmodule
