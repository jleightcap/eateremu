module register8 (
    input clk,
    input clr,
    input write,
    input[7:0] data_i,
    output reg[7:0] data_o
);
    always @(posedge clr)
        data_o <= 8'b00000000;

    always @(posedge (clk & write))
        data_o <= data_i;
endmodule
