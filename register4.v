module register4 (
    input clk,
    input clr,
    input write,
    input[3:0] data_i,
    output reg[3:0] data_o
);
    always @(posedge clr)
        data_o <= 4'b0000;

    always @(posedge (clk & write))
        data_o <= data_i;
endmodule
