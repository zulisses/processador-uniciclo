module nRisc(Reset, Clock, InstrucaoLida, EnderecoDados, DadoEscrito, DadoLido);

    /* Externo ao Processador*/
    input Reset, Clock;

    /* Interligando Memorias de Instrucao e Dados ao nRisc */
    input [7:0] InstrucaoLida;
    input [7:0] DadoLido;
    inout [7:0] EnderecoDados, DadoEscrito;

    /* Sinais Unidade de Controle */
    wire PCWrite, RegOrg1, RegDst, RegWrite, Cond, Jump, MemWrite, MemRead, MemToReg, ALUSrc1;
    wire [1:0] ALUSrc2, ALUOp, JumpValue, RegOrg2;

    /* PC */
    wire [7:0] PCOut;

    /* Somadores */
    wire [7:0] ResultadoSomador1, ResultadoSomador2;

    /* Banco de Registradores */
    wire [7:0] Dado1, Dado2;

    /* Extensor de Sinal */
    wire [7:0] ImediatoExtendido;

    /* MUX's entradas Banco de Registradores */
    wire [2:0] SaidaMuxRegOrg1, SaidaMuxRegOrg2, SaidaMuxRegDst;

    /* MUX's intermediarios caminho de dados */
    wire [7:0] SaidaMuxJumpValue, SaidaMuxALUSrc1, SaidaMuxALUSrc2;

    /* ALU */
    wire [7:0] ResultadoALU;
    wire ZeroALU;

    /* AND */
    wire ResultadoAND;

    /* MUX's finais */
    wire [7:0] SaidaMuxEntradaJump, SaidaMuxJump, SaidaMuxMemToReg;

    MUX2_3 muxRegOrg1(.Entrada0(InstrucaoLida[5:3]), 
                      .Entrada1(3'b101), 
                      .Controle(RegOrg1), 
                      .Resultado(SaidaMuxRegOrg1)
                     );

    MUX3_3 muxRegOrg2(.Entrada0(InstrucaoLida[2:0]), 
                      .Entrada1({1'b0, InstrucaoLida[2:1]}), 
                      .Entrada2(3'b101), 
                      .Controle(RegOrg2), 
                      .Resultado(SaidaMuxRegOrg2)
                     );

    MUX2_3 muxRegDst(.Entrada0(InstrucaoLida[5:3]),
                     .Entrada1(3'b101),
                     .Controle(RegDst),
                     .Resultado(SaidaMuxRegDst)
                    );

    UnidadeControle unidadeControle (.Opcode(InstrucaoLida[7:6]), 
                                     .Funct(InstrucaoLida[2:0]), 
                                     .PCWrite(PCWrite), 
                                     .RegOrg1(RegOrg1), 
                                     .RegOrg2(RegOrg2), 
                                     .RegDst(RegDst), 
                                     .RegWrite(RegWrite), 
                                     .ALUSrc1(ALUSrc1), 
                                     .ALUSrc2(ALUSrc2), 
                                     .ALUOp(ALUOp), 
                                     .JumpValue(JumpValue), 
                                     .Cond(Cond), 
                                     .Jump(Jump), 
                                     .MenWrite(MenWrite), 
                                     .MenRead(MemRead), 
                                     .MenToReg(MemToReg)
                                    );

    BancoDeRegistradores bancoDeRegistradores(.RegLido1(SaidaMuxRegOrg1), 
                                              .RegLido2(SaidaMuxRegOrg2), 
                                              .RegEscr(SaidaMuxRegDst), 
                                              .DadoEscr(SaidaMuxMemToReg), 
                                              .Dado1(Dado1), 
                                              .Dado2(Dado2), 
                                              .RegWrite(RegWrite), 
                                              .Clock(Clock)
                                             );
    

    assign EnderecoDados = Dado1;
    assign DadoEscrito = Dado2;

    ExtensorDeSinal extensorDeSinal (.Entrada(InstrucaoLida[5:1]), 
                                     .Resultado(ImediatoExtendido)
                                    );
                                    
    Somador Somador1(.Entrada1(PCOut), 
                     .Entrada2(8'b00000001), 
                     .Resultado(ResultadoSomador1)
                    );

    MUX3_8 muxJumpValue(.Entrada0(ImediatoExtendido), 
                        .Entrada1(Dado1), 
                        .Entrada2(8'b00000001), 
                        .Controle(JumpValue), 
                        .Resultado(SaidaMuxJumpValue));

    MUX2_8 muxALUSrc1 (.Entrada0(8'b00000000), 
                       .Entrada1(Dado1), 
                       .Controle(ALUSrc1), 
                       .Resultado(SaidaMuxALUSrc1)
                      );

    MUX3_8 muxALUSrc2 (.Entrada0(Dado2), 
                       .Entrada1({3'b000, InstrucaoLida[5:1]}), 
                       .Entrada2(8'b00000000),
                       .Controle(ALUSrc2), 
                       .Resultado(SaidaMuxALUSrc2)
                      );

    Somador Somador2 (.Entrada1(ResultadoSomador1), 
                      .Entrada2(SaidaMuxJumpValue), 
                      .Resultado(ResultadoSomador2)
                     );

    ULA ula (.Entrada1(SaidaMuxALUSrc1), 
             .Entrada2(SaidaMuxALUSrc2), 
             .Zero(ZeroALU), 
             .Resultado(ResultadoALU), 
             .ALUOp(ALUOp)
            );

    AND andCond (.Entrada1(Cond), 
                 .Entrada2(ZeroALU), 
                 .Resultado(ResultadoAND)
                );
            
    MUX2_8 muxEntradaJump (.Entrada0(ResultadoSomador2), 
                           .Entrada1(ResultadoSomador1), 
                           .Controle(ResultadoAND), 
                           .Resultado(SaidaMuxEntradaJump)
                          );

    MUX2_8 muxJump (.Entrada0(ResultadoSomador1), 
                    .Entrada1(SaidaMuxEntradaJump), 
                    .Controle(Jump), 
                    .Resultado(SaidaMuxJump)
                   );

    MUX2_8 muxMemToReg (.Entrada0(ResultadoALU), 
                        .Entrada1(DadoLido), 
                        .Controle(MemToReg), 
                        .Resultado(SaidaMuxMemToReg)
                       );

    PC pc1 (.PCIn(SaidaMuxJump), 
            .PCOut(PCOut), 
            .PCWrite(PCWrite), 
            .Clock(Clock)
            );

endmodule