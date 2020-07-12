module register8 (
    input clk,
    input write,
    input[7:0] data_i,
    output reg[7:0] data_o
);
    always @(posedge (clk & write))
        data_o <= data_i;
endmodule
