module register4 (
    input clk,
    input write,
    input[3:0] data_i,
    output reg[3:0] data_o
);
    always @(posedge (clk & write))
        data_o <= data_i;
endmodule
