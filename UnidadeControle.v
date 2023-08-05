module UnidadeControle (Opcode, Funct, PCWrite, RegOrg1, RegOrg2, RegDst, RegWrite, ALUSrc1, ALUSrc2, ALUOp, JumpValue, Cond, Jump, MenWrite, MenRead, MenToReg);

  input [1:0] Opcode;
  input [2:0] Funct;
  output reg PCWrite, RegOrg1, RegDst, RegWrite, ALUSrc1, Cond, Jump, MenWrite, MenRead, MenToReg;
  output reg [1:0] ALUSrc2, ALUOp, JumpValue, RegOrg2;

  always @(Opcode, Funct) begin
        case (Opcode)
            2'b00: begin
                case (Funct)
                    3'b000: begin // halt
                        PCWrite = 0; 
                        RegOrg1 = 1'bX;
                        RegOrg2 = 2'bXX;
                        RegDst = 1'bX;
                        RegWrite = 0;
                        ALUSrc1 = 1'bX;
                        ALUSrc2 = 2'bXX;
                        ALUOp = 2'bXX;
                        JumpValue = 2'bXX;
                        Cond = 1'bX;
                        Jump = 1'bX;
                        MenWrite = 0;
                        MenRead = 0;
                        MenToReg = 1'bX;
                    end
                    3'b001: begin // lw
                        PCWrite = 1;
                        RegOrg1 = 0;
                        RegOrg2 = 2'bXX;
                        RegDst = 1;
                        RegWrite = 1;
                        ALUSrc1 = 1'bX;
                        ALUSrc2 = 2'bXX;
                        ALUOp = 2'bXX;
                        JumpValue = 2'bXX;
                        Cond = 1'bX;
                        Jump = 0;
                        MenWrite = 0;
                        MenRead = 1;
                        MenToReg = 1;
                    end
                    
                    3'b010: begin // sw
                        PCWrite = 1; 
                        RegOrg1 = 0;
                        RegOrg2 = 2'b10;
                        RegDst = 1'bX;
                        RegWrite = 0;
                        ALUSrc1 = 1'bX;
                        ALUSrc2 = 2'bXX;
                        ALUOp = 2'bXX;
                        JumpValue = 2'bXX;
                        Cond = 1'bX;
                        Jump = 0;
                        MenWrite = 1;
                        MenRead = 0;
                        MenToReg = 1'bX;
                    end
                    3'b011: begin // jr
                        PCWrite = 1; 
                        RegOrg1 = 0;
                        RegOrg2 = 2'bXX;
                        RegDst = 1'bX;
                        RegWrite = 0;
                        ALUSrc1 = 1'bX;
                        ALUSrc2 = 2'bXX;
                        ALUOp = 2'bXX;
                        JumpValue = 2'b01;
                        Cond = 0;
                        Jump = 1;
                        MenWrite = 0;
                        MenRead = 0;
                        MenToReg = 1'bX;
                    end
                    3'b100: begin // rst
                        PCWrite = 1; 
                        RegOrg1 = 1'bX;
                        RegOrg2 = 2'bXX;
                        RegDst = 0;
                        RegWrite = 1;
                        ALUSrc1 = 0;
                        ALUSrc2 = 2'b10;
                        ALUOp = 2'b00;
                        JumpValue = 2'bXX;
                        Cond = 1'bX;
                        Jump = 0;
                        MenWrite = 0;
                        MenRead = 0;
                        MenToReg = 0;
                    end
                    3'b101: begin // inv
                        PCWrite = 1; 
                        RegOrg1 = 0;
                        RegOrg2 = 2'bXX;
                        RegDst = 0;
                        RegWrite = 1;
                        ALUSrc1 = 1;
                        ALUSrc2 = 2'bXX;
                        ALUOp = 2'b01;
                        JumpValue = 2'bXX;
                        Cond = 1'bX;
                        Jump = 0;
                        MenWrite = 0;
                        MenRead = 0;
                        MenToReg = 0;
                    end
                    3'b110: begin // beqz
                        PCWrite = 1; 
                        RegOrg1 = 0;
                        RegOrg2 = 2'bXX;
                        RegDst = 1'bX;
                        RegWrite = 0;
                        ALUSrc1 = 1;
                        ALUSrc2 = 2'b10;
                        ALUOp = 2'b10;
                        JumpValue = 2'b10;
                        Cond = 1;
                        Jump = 1;
                        MenWrite = 0;
                        MenRead = 0;
                        MenToReg = 1'bX;
                    end
                    default: ;
                endcase
            end
            2'b01: begin // add
                PCWrite = 1; 
                RegOrg1 = 0;
                RegOrg2 = 2'b00;
                RegDst = 0;
                RegWrite = 1;
                ALUSrc1 = 1;
                ALUSrc2 = 2'b00;
                ALUOp = 2'b00;
                JumpValue = 2'bXX;
                Cond = 1'bX;
                Jump = 0;
                MenWrite = 0;
                MenRead = 0;
                MenToReg = 0;
            end
            2'b10: begin
                case(Funct[0])
                    1'b0:  begin // addi
                        PCWrite = 1; 
                        RegOrg1 = 1;
                        RegOrg2 = 2'bXX;
                        RegDst = 1;
                        RegWrite = 1;
                        ALUSrc1 = 1;
                        ALUSrc2 = 2'b01;
                        ALUOp = 2'b00;
                        JumpValue = 2'bXX;
                        Cond = 1'bX;
                        Jump = 0;
                        MenWrite = 0;
                        MenRead = 0;
                        MenToReg = 0;
                    end
                    1'b1:  begin // j
                        PCWrite = 1;
                        RegOrg1 = 1'bX;
                        RegOrg2 = 2'bXX;
                        RegDst = 1'bX;
                        RegWrite = 0;
                        ALUSrc1 = 1'bX;
                        ALUSrc2 = 2'bXX;
                        ALUOp = 2'bXX;
                        JumpValue = 2'b00;
                        Cond = 0;
                        Jump = 1;
                        MenWrite = 0;
                        MenRead = 0;
                        MenToReg = 1'bX;
                    end
                endcase
            end
            2'b11: begin 
                case(Funct[0])
                    1'b0:  begin // beqr
                        PCWrite = 1;
                        RegOrg1 = 0;
                        RegOrg2 = 2'b01;
                        RegDst = 1'bX;
                        RegWrite = 0;
                        ALUSrc1 = 1;
                        ALUSrc2 = 2'b00;
                        ALUOp = 2'b10;
                        JumpValue = 2'b10;
                        Cond = 1;
                        Jump = 1;
                        MenWrite = 0;
                        MenRead = 0;
                        MenToReg = 1'bX;
                    end
                    1'b1:  begin // slt
                        PCWrite = 1;
                        RegOrg1 = 0;
                        RegOrg2 = 2'b01;
                        RegDst = 1;
                        RegWrite = 1;
                        ALUSrc1 = 1;
                        ALUSrc2 = 2'b00;
                        ALUOp = 2'b11;
                        JumpValue = 2'bXX;
                        Cond = 1'bX;
                        Jump = 0;
                        MenWrite = 0;
                        MenRead = 0;
                        MenToReg = 0;
                    end
                endcase
            end
            default: ;
        endcase
  end

endmodule
