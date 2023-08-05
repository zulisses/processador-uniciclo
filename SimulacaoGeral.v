module SimulacaoGeral;

    reg Clock, Reset;

    reg[15:0] counter;

    /* Memoria de Instrucao */
    wire[7:0] InstrucaoLida;

    /* Memoria de Dados */
    wire[7:0] EnderecoDados, DadoEscrito, DadoLido;

    MemoriaDados memoriaDados(.Endereco(EnderecoDados), 
                              .DadoEscr(DadoEscrito), 
                              .DadoLido(DadoLido), 
                              .MenWrite(nrisc.MemWrite), 
                              .MenRead(nrisc.MemRead), 
                              .Clock(Clock)
                             );

    MemoriaInstrucao memoriaInstrucao(.Endereco(nrisc.pc1.PC), 
                                      .Instrucao(InstrucaoLida), 
                                      .Clock(Clock)
                                     );

    nRisc nrisc(.Reset(Reset), 
                .Clock(Clock),
                .InstrucaoLida(InstrucaoLida), 
                .EnderecoDados(EnderecoDados), 
                .DadoEscrito(DadoEscrito), 
                .DadoLido(DadoLido)
               );
    
    initial begin
        nrisc.pc1.PC = 8'b00000000;
        Clock = 1;
        Reset = 0;
        counter = 0;
        
        $readmemb("dados.txt", memoriaDados.Dados); //Leitura dos dados
        $readmemb("instrucoes.txt", memoriaInstrucao.Instrucoes); // leitura das instrucoes
    end
    
    initial begin
        $monitor("%0d | i=%b | pc=%b | sp=%b | rr=%b | r0=%b | r1=%b | r2=%b | r3=%b | ra=%b",
               counter, 
               InstrucaoLida,
               nrisc.pc1.PC,
               nrisc.bancoDeRegistradores.BR[3'b111],
               nrisc.bancoDeRegistradores.BR[3'b101],
               nrisc.bancoDeRegistradores.BR[3'b000],
               nrisc.bancoDeRegistradores.BR[3'b001],
               nrisc.bancoDeRegistradores.BR[3'b010],
               nrisc.bancoDeRegistradores.BR[3'b011],
               nrisc.bancoDeRegistradores.BR[3'b110]);
    end
    

    always begin
        if(memoriaInstrucao.Instrucoes[nrisc.PCOut] == 8'b00000000) begin
            $display("Maior: %b | Menor: %b",nrisc.bancoDeRegistradores.BR[3'b010], nrisc.bancoDeRegistradores.BR[3'b011]);
        end
         #1; Clock = ~Clock;
    end

    always@(posedge Reset) begin
        nrisc.pc1.PC = 8'b00000000;
    end

    always@(posedge Clock) begin
        counter = counter + 1;
    end
	
endmodule