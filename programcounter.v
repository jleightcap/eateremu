module program_counter (
    input clk,
    input clr,
    input ce,
    input jmp,
    input[3:0] jmp_data,
    output reg[3:0] pc
);
    always @(posedge clr)
        pc <= 4'b0000;

    always @(posedge (clk & ce))
        pc++;

    always @(posedge (clk & jmp)) begin
        pc <= jmp_data;
    end
endmodule
