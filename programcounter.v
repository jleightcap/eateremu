module program_counter (
    input clk,
    input ce,
    input jmp,
    input[3:0] jmp_data,
    output reg[3:0] pc
);
    initial 
        pc <= 4'b0000;

    always @(posedge (clk & ce))
        pc++;

    always @(posedge clk) begin
        if (jmp) pc <= jmp_data;
    end
endmodule
