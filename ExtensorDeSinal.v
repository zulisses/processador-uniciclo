module ExtensorDeSinal (Entrada, Resultado);

    input signed [4:0] Entrada;
    output signed [7:0] Resultado;

    assign Resultado = {Entrada[4], Entrada[4], Entrada[4], Entrada};

endmodule